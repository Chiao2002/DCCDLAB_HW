clear;close all; clc;
%% Q1 scaling factor S(N)
N = 30;

% test = SCF(N);

s_mult = 1;
s_ans = [];
for i = 0 : N-1
    s_mult = s_mult * (1/sqrt(1+2^(-2*i)));
    s_ans = [s_ans s_mult];
end
max_s = 1/s_mult;

figure(1)
title('scaling factor')
xlabel('N')
ylabel('value of S(N)')
hold on
plot(1:N, s_ans)
hold off
% function x_mult = SCF(N)
%     x_mult = 1;
%     for i = 0 : N-1
%         x_mult = x_mult * (1/sqrt(1+2^(-2*i)));
%     end
% end

%% Q2 Q3
% quantization
quantizer = @(word_len, int_part, x)  round(x * 2^(word_len-int_part)) / 2^(word_len-int_part);

beta = mod(4,3)+1;
theda = zeros(30, 12);
out_x = zeros(30,12);
out_y = zeros(30,12);
out_XY = [];
for n = 0 : 11
    alpha = (4*n+beta)*pi/24;
    % initialization 
    X(n+1) = sin(alpha);
    Y(n+1) = cos(alpha);
    
    % quantize
    X_q(n+1) = quantizer(12, 2, X(n+1));
    Y_q(n+1) = quantizer(12, 2, Y(n+1));

    % mapping 2to1 3to4
    if X_q(n+1)<0 && Y_q(n+1)>0
        X_q(n+1) = -X_q(n+1);
%         Y_q(n+1) = -Y_q(n+1);
    end
    if X_q(n+1)<0 && Y_q(n+1)<0
       X_q(n+1) = -X_q(n+1);
%        Y_q(n+1) = -Y_q(n+1);
    end
     
    ideal_angle(n+1) = atan(Y_q(n+1)/X_q(n+1));
    
    out_x(1, n+1) = X_q(n+1);
    out_y(1, n+1) = Y_q(n+1);
end
% max_x = max(X)*max_s*2^10;
% min_x = min(X)*max_s*2^10;

out_xq(1,:)=out_x(1, :);
out_yq(1,:)=out_y(1, :);
for i = 1:29
    for n = 1:12
        
        % determine direction
%         mu = -out_y(i,n)/norm(out_y(i,n));
        mu(i, n) = -sign(out_yq(i, n));
        
        
        % perform micro-rotation
        out_x(i+1, n) = out_x(i, n) - mu(i, n)*(2^(-(i-1)))*out_y(i, n);
        out_y(i+1, n) = out_x(i, n)*mu(i, n)*(2^(-(i-1))) + out_y(i, n);
        
        % phase accumulation
        theda(i+1, n) = theda(i, n) - mu(i, n)*atan(2^(-(i-1)));
        
        
        % quantization
        out_xq(i+1, n) = quantizer(12, 2, out_x(i+1, n));
        out_yq(i+1, n) = quantizer(12, 2, out_y(i+1, n));
               
    end 
    phase_error_avg(i) = sum(abs(ideal_angle-theda(i+1, :)))/12;
end
figure(2)
title('Phase error')
xlabel('Numbers of micro-rotation N')
ylabel('Average error(log2)')
hold on
plot(1:N-1, log2(phase_error_avg))
plot(1:N-1, -8,'+')
hold off

% determine fixed-point of theda
WLINT = 2;
WLMAX = 20;
wl_arr = WLINT : WLMAX;
theda_q = zeros(20,12);
for j = wl_arr
   theda_q(j, :) = theda(j-1, :) - mu(j-1, :)*quantizer(j, 2, atan(2^(-(j-2))));
   theda_q_err(j-1, :) = sum(abs(ideal_angle - theda_q(j-1, :)))/12;
end
figure(3)
title('Quantized')
xlabel('Worth length of elementary angles')
ylabel('Average error(log2)')
hold on
plot(wl_arr, log2(theda_q_err))
plot(wl_arr, -8,'+')
hold off

% elementary angles to binary
for i = 0 : 8
   elementary_angle(i+1) = atan(1/2^i);
   elementary_angle_q(i+1) = quantizer(10, 2, elementary_angle(i+1));
end
bin_elementary_angle = dec2bin(elementary_angle_q * 2^10);


%% Q4

for i = 1:25
    s = 1/sqrt(1+2^(-2*(i-1)));
    error(i) = log10(1-s);
end

figure(4)
title('Error of the magnitude function')
xlabel('Numbers of micro-rotation N')
ylabel('error of the magnitude(log10)')
hold on
plot(1:25, error)
plot(1:25, log10(0.005), '.')
hold off   

%% Q5
s_mult = 1;
for i = 0 : 19
    s_q(i+1, :) = quantizer(i, 2, s_ans);
    s_error(i+1) = sum(abs(s_ans-s_q(i+1, :)))/N;
end
figure(5)
title('Error of scaling factor')
xlabel('word-length')
ylabel('average error(log2)')
hold on
plot(0:19, log2(s_error))
plot(0:19, -8, '.')
hold off

S_6 = dec2bin(s_ans(6)*2^10);
    
    


