clear all; close all;
% CORDIC %
% Vectoring Mode%
% to partition one rotation angle into the sum of several elementary angles.
% elementary angles which can be accomplished by shift-and-add.
% theta_element=sum(mu_i*theta_element_i);, i=0~N-1
% theta_element_i=atan(2^-(i));
% mu_i={+1, -1}, it determines the direction of rotation
% vector (X(i), Y(i))  at the i-th micro-rotation is
% [X(i+1) ; Y(i+1)]=[1  -mu_i*2^(-i) ; mu_i*2^(-i)  1]*[X(i) ; Y(i)];
%
%% Q1: Scaling Factor S(N) %%
num_iteration = 20;

for k = 1:num_iteration  %k=0~N
    elementary_angle(k) = atan(2^(-(k-1)));
    scaling_factor_each(k) = cos(elementary_angle(k)); %=1/sqrt(1+2^(-2*i))
    if k==1
        Scaling_Factor(k) = scaling_factor_each(k);
        Scaling(k) = 1/Scaling_Factor(k);
    else
        Scaling_Factor(k) = scaling_factor_each(k)*Scaling_Factor(k-1);
        Scaling(k) = 1/Scaling_Factor(k);
    end
end

x_axis = 0:num_iteration-1;
Iteration_Table = [x_axis.', elementary_angle.'.*(180/pi),...
    scaling_factor_each.', Scaling_Factor.', Scaling.'];
% Table_text = {'N', 'theta_e(N) (degree)', 'theta_e(N) (phase)', 'S(N)', '1/S(N)'};
% T = [Table_text; num2cell(Iteration_Table)];
T = cell2table(num2cell(Iteration_Table),...
    'VariableNames', ["N" "Angle" "Phase" "ScalingFactor" "Scaling"]);

figure(1); title('Scaling Factor')
plot(x_axis, Scaling_Factor)
xlabel('N'); ylabel('S(N)')
grid on;
close;
%% Q2&Q3: Determine the word-lenth of X(i) and Y(i): 12 bits %
% N = num_iteration;
% n = 0:11;
beta = 3;
X_pseudo = zeros(1, num_iteration+1);
Y_pseudo = zeros(1, num_iteration+1);
phase_out = zeros(1, num_iteration+1);
for n = 1:12
    alpha = (4*(n-1)+beta)/24*pi; %accroding to required n=0~11, => (n-1)
    X(n) = sin(alpha);
    Y(n) = cos(alpha);
    
    % Initialization: X(0), Y(0), theta = (I, IV)? 0 : pi; %
    [X_pseudo(n, 1), Y_pseudo(n, 1), phase_out(n, 1)] = cordic_vectoring_first(X(n), Y(n));
    
    % Iteration step: %
    for N = 1:num_iteration
        [X_pseudo(n, N+1), Y_pseudo(n, N+1), phase_out(n, N+1)] = ...
            cordic_vectoring_stage(X_pseudo(n, N), Y_pseudo(n, N), phase_out(n, N), N-1);
    end
end
angles = phase_out .*(180/pi);

answer_phase = (atan(Y./X) + (X<0)*pi).'; %rad
answer_angle = (atan(Y./X) .* (180/pi) + (X<0)*180).'; %degree
answer_magnitude = sqrt(X.^2+Y.^2).';
X_N = sqrt(X.^2+Y.^2).' * Scaling(num_iteration);
Table_X_Y_agl_mag = [X.', Y.', answer_angle, answer_magnitude];

%% Determine the number of required micro-rotations
% and determine the elementary angles with word-length,
% so that the average phase error of atan(Y/X) less than 2^(-8) %
% answer: rotates times = 9 (stage0~stage8)

% quantization function %
quantizer = @(word_len, int_part, x)  round(x * 2^(word_len-int_part)) / 2^(word_len-int_part);

for n = 1:12
    alpha = (4*(n-1)+beta)/24*pi; %accroding to required n=0~11, => (n-1)
    X_q(n) = quantizer(12, 2, sin(alpha));
    Y_q(n) = quantizer(12, 2, cos(alpha));
    
    % Initialization: X(0), Y(0), theta = (I, IV)? 0 : pi; %
    [X_pseudo(n, 1), Y_pseudo(n, 1), phase_out_Q3(n, 1)] = cordic_vectoring_first(X_q(n), Y_q(n));
    X_pseudo_q(n, 1) = quantizer(12, 2, X_pseudo(n, 1));
    Y_pseudo_q(n, 1) = quantizer(12, 2, Y_pseudo(n, 1));
    phase_error_Q3(n, 1) = abs(answer_phase(n)-phase_out_Q3(n, 1));
    % Iteration step: %
    for N = 1:num_iteration
        [X_pseudo(n, N+1), Y_pseudo(n, N+1), phase_out_Q3(n, N+1)] = ...
            cordic_vectoring_stage(X_pseudo_q(n, N), Y_pseudo_q(n, N), phase_out_Q3(n, N), N-1);
        X_pseudo_q(n, N+1) = quantizer(12, 2, X_pseudo(n, N+1));
        Y_pseudo_q(n, N+1) = quantizer(12, 2, Y_pseudo(n, N+1));
        
        phase_error_Q3(n, N+1) = abs(answer_phase(n)-phase_out_Q3(n, N+1));
    end
end
mean_phase_error_Q3 = log2(mean(phase_error_Q3));
x_axis = (1:num_iteration)-1;
figure(2); title('Phase error');
xlabel('Numbers of micro-rotation N'); ylabel('MSE (log2)');
hold on; 
plot(x_axis, mean_phase_error_Q3(2:end))
plot(x_axis, -8, 'ro')
% close;
%% determine word-length of the elementary angles %
% answer: WL 14 bits (int:4 bits, float:10 bits), if rotate 10 times 
% then qutization error: 2^-13 (log2)
rot = 1:10;
for WL = 10:20
    elementary_angle_Q3 = atan(2.^(-(rot-1)));
    elementary_angle_q = quantizer(WL, 4, elementary_angle_Q3);
    elementary_q_error(WL-9, :) = abs(elementary_angle_Q3-elementary_angle_q);
end
mean_elementary_q_error = log2(mean(elementary_q_error, 2));

%% CORDIC fxed-point %
WL_phase = 14;
for n = 1:12
    alpha = (4*(n-1)+beta)/24*pi; %accroding to required n=0~11, => (n-1)
    X_q(n) = quantizer(12, 2, sin(alpha));
    Y_q(n) = quantizer(12, 2, cos(alpha));
    
    % Initialization: X(0), Y(0), theta = (I, IV)? 0 : pi; %
    [X_pseudo(n, 1), Y_pseudo(n, 1), phase_out_Q3(n, 1)] = cordic_vectoring_first(X_q(n), Y_q(n));
    X_pseudo_q(n, 1) = quantizer(12, 2, X_pseudo(n, 1));
    Y_pseudo_q(n, 1) = quantizer(12, 2, Y_pseudo(n, 1));
    phase_out_q(n, 1) = quantizer(WL_phase, 4, phase_out_Q3(n, 1));
    phase_error_Q3(n, 1) = abs(answer_phase(n)-phase_out_q(n, 1));
    % Iteration step: %
    for N = 1:num_iteration
        [X_pseudo(n, N+1), Y_pseudo(n, N+1), phase_out_Q3(n, N+1)] = ...
            cordic_vectoring_stage_fixed(X_pseudo_q(n, N), Y_pseudo_q(n, N),...
            phase_out_q(n, N), WL_phase, N-1);
        
        X_pseudo_q(n, N+1) = quantizer(12, 2, X_pseudo(n, N+1));
        Y_pseudo_q(n, N+1) = quantizer(12, 2, Y_pseudo(n, N+1));
        phase_out_q(n, N+1) = quantizer(WL_phase, 4, phase_out_Q3(n, N+1));
        phase_error_Q3(n, N+1) = abs(answer_phase(n)-phase_out_q(n, N+1));
    end
end
mean_phase_error_Q3 = log2(mean(phase_error_Q3));
x_axis = (1:num_iteration)-1;
figure(3); title('Phase error');
xlabel('Numbers of micro-rotation N'); ylabel('MSE(log2)');
hold on; 
plot(x_axis, mean_phase_error_Q3(2:end));
plot(x_axis, -8, 'ro');







