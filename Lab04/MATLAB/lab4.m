clear; close all; clc;
%% params
alpha = 0.5;
Ts = 1;
phi = 4;

%% linear
linear_c_1 = @(mu) mu;
linear_c0 = @(mu) 1-mu;

f_linear = @(x, x1, mu) linear_c_1(mu)*x1 + linear_c0(mu)*x;
%% second order
second_c0 = @(mu) (1-mu).*(2-mu)/2;
second_c_1 = @(mu) (2-mu).*mu;
second_c_2 = @(mu) -mu.*(1-mu)/2;

f_second_order = @(x, x1, x2, mu) second_c0(mu)*x + second_c_1(mu)*x1 + second_c_2(mu)*x2;
%% piecewise parabolic
parabolic_c1 = @(mu) -alpha*mu + alpha*mu.^2;
parabolic_c0 = @(mu) 1 +(alpha-1)*mu - alpha*mu.^2;
parabolic_c_1 = @(mu) (alpha+1)*mu - alpha*mu.^2;
parabolic_c_2 = @(mu) -alpha*mu + alpha*mu.^2;

f_parabolic = @(x_1, x, x1, x2, mu) parabolic_c1(mu)*x_1 + parabolic_c0(mu)*x + parabolic_c_1(mu)*x1 + parabolic_c_2(mu)*x2;
%% Q1: Time-domain impulse response figure
mu = linspace( 0, 1, 11 );

figure(1)
plot( mu-1, linear_c_1(mu) )
title('Linear interpolator')
xlabel('t/Ts')
ylabel('h(t)')
hold on
plot( mu, linear_c0(mu) )
hold off
figure(2)
plot( mu-2, second_c_2(mu) )
title('Second-order interpolator')
xlabel('t/Ts')
ylabel('h(t)')
hold on
plot( mu-1, second_c_1(mu) )
plot( mu, second_c0(mu) )
hold off
figure(3)
plot( mu-2, parabolic_c_2(mu) )
title('Piecewise parabolic interpolator')
xlabel('t/Ts')
ylabel('h(t)')
hold on
plot( mu-1, parabolic_c_1(mu) )
plot( mu, parabolic_c0(mu) )
plot( mu+1, parabolic_c1(mu) )
hold off

%% Q2: Frequency-domain response figure
h_linear = [];
h_second = [];
h_parabolic = [];
h_linear = [linear_c_1(mu(1:10)) linear_c0(mu(1:10))];
h_second = [second_c_2(mu(1:10)) second_c_1(mu(1:10)) second_c0(mu(1:10))];
h_parabolic =[parabolic_c_2(mu(1:10)) parabolic_c_1(mu(1:10)) parabolic_c0(mu(1:10)) parabolic_c1(mu(1:10))];
fvtool(h_linear)
fvtool(h_second)
fvtool(h_parabolic)

%% Q3
x_m = @(m) cos(2*pi*((m*Ts)/(8*Ts) + phi/10));

t = [];
Q3_true = [];
Q3_linear = [];
Q3_second = [];
Q3_parabolic = [];
err = [];

for m = 24:64
   for mu = (0:5)/6
      x_linear = f_linear( x_m(m), x_m(m+1), mu );
      x_second = f_second_order( x_m(m), x_m(m+1), x_m(m+2), mu );
      x_parabolic = f_parabolic( x_m(m-1), x_m(m), x_m(m+1), x_m(m+2), mu );
% f_parabolic = @(x_1, x, x1, x2, mu) parabolic_c1(mu)*x_1 + parabolic_c0(mu)*x + parabolic_c_1(mu)*x1 + parabolic_c_2(mu)*x2;
      t = [t m+mu];
      x_true = x_m(m+mu);
      Q3_true = [Q3_true x_true];
      
      Q3_linear = [Q3_linear x_linear];
      Q3_second = [Q3_second x_second];
      Q3_parabolic = [Q3_parabolic x_parabolic];
      
      err = [err [abs(x_linear-x_true);abs(x_second-x_true);abs(x_parabolic-x_true)]];
   end  
end
% RMSE
rmse_linear = norm(Q3_true-Q3_linear)/length(Q3_true);
rmse_second = norm(Q3_true-Q3_second)/length(Q3_true);
rmse_parabolic = norm(Q3_true-Q3_parabolic)/length(Q3_true);

figure(4)
title('Interpolated output v.s. True value and Error')
xlabel('t')
ylabel('Amplitude and Error')
hold on
plot(t, Q3_linear, 'b--', 'LineWidth',2 )
plot(t, Q3_second, 'c-.', 'LineWidth',2 )
plot(t, Q3_parabolic, 'm:', 'LineWidth',2)
plot(t, Q3_true, 'r-', 'LineWidth',2 )
plot(t, err(1,:), 'k-.', 'LineWidth',1)
plot(t, err(2,:), 'g--', 'LineWidth',1)
plot(t, err(3,:), 'm-', 'LineWidth',1)
legend('linear', 'second', 'parabolic', 'true value', 'err of linear', 'err of second', 'err of paraabolic')
hold off

%% Q4
x_m = @(m) cos(2*pi*((m*Ts)/(4*Ts) + phi/10));

t = [];
Q4_true = [];
Q4_linear = [];
Q4_second = [];
Q4_parabolic = [];
err = [];

for m = 12:32
   for mu = (0:5)/6
      x_linear = f_linear( x_m(m), x_m(m+1), mu );
      x_second = f_second_order( x_m(m), x_m(m+1), x_m(m+2), mu );
      x_parabolic = f_parabolic( x_m(m-1), x_m(m), x_m(m+1), x_m(m+2), mu );
      
      t = [t m+mu];
      x_true = x_m(m+mu);
      Q4_true = [Q4_true x_true];
      
      Q4_linear = [Q4_linear x_linear];
      Q4_second = [Q4_second x_second];
      Q4_parabolic = [Q4_parabolic x_parabolic];
      
      err = [err [abs(x_linear-x_true);abs(x_second-x_true);abs(x_parabolic-x_true)]];
   end  
end
% RMSE
rmse_linear = norm(Q4_true-Q4_linear)/length(Q4_true);
rmse_second = norm(Q4_true-Q4_second)/length(Q4_true);
rmse_parabolic = norm(Q4_true-Q4_parabolic)/length(Q4_true);

figure(5)
title('Interpolated output v.s. True value and Error')
xlabel('t')
ylabel('Amplitude and Error')
hold on
plot(t, Q4_linear, 'b--', 'LineWidth',2 )
plot(t, Q4_second, 'c-.', 'LineWidth',2 )
plot(t, Q4_parabolic, 'm:', 'LineWidth',2)
plot(t, Q4_true, 'r-', 'LineWidth',2 )
plot(t, err(1,:), 'k-.', 'LineWidth',1)
plot(t, err(2,:), 'g--', 'LineWidth',1)
plot(t, err(3,:), 'm-', 'LineWidth',1)
legend('linear', 'second', 'parabolic', 'true value', 'err of linear', 'err of second', 'err of paraabolic')
hold off


%% Q5
% quantization
quantizer = @(word_len, int_part, x)  floor(x * 2^(word_len-int_part)) / 2^(word_len-int_part);

x_m = @(m) cos(2*pi*((m*Ts)/(8*Ts) + phi/10));
% Initialization
Ts = 1;
WLMAX = 15;
WLINT = 1;
wl_arr = WLINT : WLMAX;

%% Q5-a Determine wordlength of input
Q5_linear_q = [];
for j = wl_arr
    Q5_ans = [];
    for m = 24:64
        for mu = (0:5)/6
            x_m_q = f_linear( quantizer(j, WLINT, x_m(m)), quantizer(j, WLINT,x_m(m+1)), mu ) ;
            Q5_ans = [Q5_ans x_m_q];
        end
    end
    Q5_linear_q = [Q5_linear_q ; Q5_ans];
%     trunction_err( j ) = sum(abs(Q3_linear - Q5_linear_q(j,:))) / length(Q3_linear);
    trunction_err( j ) = norm(Q3_linear - Q5_linear_q(j,:))/length(Q3_linear);
end
figure(6)
title('Error between quantized and floating point')
xlabel('Input word-length')
ylabel('Output error')
plot( wl_arr, log2(trunction_err), 'b-' )
hold on
plot( wl_arr, -10, 'ro' )
hold off

%% Q5-b Determine wordlength of mu
INPUTWL = 7;
Q5_linear_q = [];
for j = wl_arr
    Q5_ans = [];
    for m = 24:64
        for mu = (0:5)/6
            x_m_q = f_linear( quantizer(INPUTWL, WLINT, x_m(m)), quantizer(INPUTWL, WLINT, x_m(m+1)), quantizer(j, WLINT, mu) );
            Q5_ans = [Q5_ans x_m_q];
        end      
    end
    Q5_linear_q = [Q5_linear_q ; Q5_ans];
    trunction_err( j ) = norm(Q3_linear - Q5_linear_q(j,:))/length(Q3_linear);
end
figure(7)
title('Error between quantized and floating point')
xlabel('Mu word-length')
ylabel('Output error')
plot( wl_arr, log2(trunction_err), 'b-' )
hold on
plot( wl_arr, -10, 'ro' )
hold off

%% Q6
% quantization
quantizer = @(word_len, int_part, x)  floor( x * 2^(word_len-int_part) ) / 2^(word_len-int_part);
% input x(m)
x_m = @(m) cos(2*pi*((m*Ts)/(8*Ts) + phi/10));
m = 23:66;
x = x_m(m);

% piecewise parabolic
mu2_alpha = [alpha -alpha -alpha alpha];
mu1_alpha = [-alpha alpha+1 alpha-1 -alpha];
mu0_alpha = [0 0 1 0];
register2 = x(1:3);
register1 = x(1:3);
register0 = x(1:3);
y_out = [];
for i = 4 : length(x)
    % v(2)
    y2(i-3) = x( i )*mu2_alpha(1) + register2(3)*mu2_alpha(2) + register2(2)*mu2_alpha(3) + register2(1)*mu2_alpha(4);    
    register2( 1:2 ) = register2( 2:3 );
    register2( 3 ) = x( i );
    % v(1)
    y1(i-3) = x( i )*mu1_alpha(1) + register1(3)*mu1_alpha(2) + register1(2)*mu1_alpha(3) + register1(1)*mu1_alpha(4);
    register1( 1:2 ) = register1( 2:3 );
    register1( 3 ) = x( i );
    % v(0)
    y0(i-3) = x( i )*mu0_alpha(1) + register0(3)*mu0_alpha(2) + register0(2)*mu0_alpha(3) + register0(1)*mu0_alpha(4);
    register0( 1:2 ) = register0( 2:3 );
    register0( 3 ) = x( i );
   
    for mu = (0:5)/6
        y_ans = (y2(i-3)*mu + y1(i-3))*mu + y0(i-3);
        y_out = [y_out y_ans];
    end  
end
% figure(2)
% plot(y_out)

%% Q6-a Determine wordlength of input
% Initialization
WLMAX = 20;
WLINT = 2;
wl_arr = WLINT : WLMAX;
x_q = zeros(1,length(x));
Q6_parabolic_q = [];
for j = wl_arr
    x_q(1) = quantizer( j, WLINT, x(1));
    x_q(2) = quantizer( j, WLINT, x(2));
    x_q(3) = quantizer( j, WLINT, x(3));
    register2 = x_q(1:3);
    register1 = x_q(1:3);
    register0 = x_q(1:3);
    y_ans = [];
    y_out_a = [];
    for i = 4 : length(x)        
        x_q(i) = quantizer( j, WLINT, x(i) );
        % v(2)
        y2 = x_q(i)*mu2_alpha(1) + register2(3)*mu2_alpha(2) + register2(2)*mu2_alpha(3) + register2(1)*mu2_alpha(4);    
        register2( 1:2 ) = register2( 2:3 );
        register2( 3 ) = x_q(i);
        % v(1)
        y1 = x_q(i)*mu1_alpha(1) + register1(3)*mu1_alpha(2) + register1(2)*mu1_alpha(3) + register1(1)*mu1_alpha(4);
        register1( 1:2 ) = register1( 2:3 );
        register1( 3 ) = x_q(i);
        % v(0)
        y0 = x_q(i)*mu0_alpha(1) + register0(3)*mu0_alpha(2) + register0(2)*mu0_alpha(3) + register0(1)*mu0_alpha(4);
        register0( 1:2 ) = register0( 2:3 );
        register0( 3 ) = x_q(i);

        for mu = (0:5)/6
            y_ans = (y2*mu + y1)*mu + y0;
            y_out_a = [y_out_a y_ans];
        end
    end
    Q6_parabolic_q = [Q6_parabolic_q ; y_out_a];
    trunction_err( j-1 ) = sqrt(mean((y_out - Q6_parabolic_q(j-1,:)).^2));
end
figure(9)
plot( wl_arr, log2(trunction_err), 'b-' )
hold on
plot( wl_arr, -9, 'ro' )
title('Error between quantized and floating point')
xlabel('Intput word-length')
ylabel('Output error')
hold off

%% Q6-b Determine wordlength of mu
% Initialization
WLMAX = 20;
WLINT = 2;
wl_arr = WLINT : WLMAX;
INPUTWL = 13;
Q6_parabolic_q = [];
for j = wl_arr
    x_q(1) = quantizer( INPUTWL, WLINT, x(1));
    x_q(2) = quantizer( INPUTWL, WLINT, x(2));
    x_q(3) = quantizer( INPUTWL, WLINT, x(3));
    register2 = x_q(1:3);
    register1 = x_q(1:3);
    register0 = x_q(1:3);
    y_ans = [];
    y_out_b = [];
    for i = 4 : length(x)        
        x_q(i) = quantizer( INPUTWL, WLINT, x(i) );
        % v(2)
        y2 = x_q(i)*mu2_alpha(1) + register2(3)*mu2_alpha(2) + register2(2)*mu2_alpha(3) + register2(1)*mu2_alpha(4);    
        register2( 1:2 ) = register2( 2:3 );
        register2( 3 ) = x_q(i);
        % v(1)
        y1 = x_q(i)*mu1_alpha(1) + register1(3)*mu1_alpha(2) + register1(2)*mu1_alpha(3) + register1(1)*mu1_alpha(4);
        register1( 1:2 ) = register1( 2:3 );
        register1( 3 ) = x_q(i);
        % v(0)
        y0 = x_q(i)*mu0_alpha(1) + register0(3)*mu0_alpha(2) + register0(2)*mu0_alpha(3) + register0(1)*mu0_alpha(4);
        register0( 1:2 ) = register0( 2:3 );
        register0( 3 ) = x_q(i);

        for mu = (0:5)/6
            mu_q = quantizer(j, WLINT, mu);
            y_ans = (y2*mu_q + y1)*mu_q + y0;
            y_out_b = [y_out_b y_ans];
        end  
    end
    Q6_parabolic_q = [Q6_parabolic_q ; y_out_b];
    trunction_err( j-1 ) = sqrt(mean((y_out - Q6_parabolic_q(j-1,:)).^2));
end
figure(10)
plot( wl_arr, log2(trunction_err), 'b-' )
hold on
plot( wl_arr, -9, 'ro' )
title('Error between quantized and floating point')
xlabel('Mu word-length')
ylabel('Output error')
hold off

%% Q6-c Determine wordlength of multiplier(by mu)
% Initialization
WLMAX = 20;
WLINT = 2;
wl_arr = WLINT : WLMAX;
INPUTWL = 13;
MUWL = 13;
Q6_parabolic_q = [];
for j = wl_arr
    x_q(1) = quantizer( INPUTWL, WLINT, x(1));
    x_q(2) = quantizer( INPUTWL, WLINT, x(2));
    x_q(3) = quantizer( INPUTWL, WLINT, x(3));
    register2 = x_q(1:3);
    register1 = x_q(1:3);
    register0 = x_q(1:3);
    y_ans = [];
    y_out_c = [];
    for i = 4 : length(x)        
        x_q(i) = quantizer( INPUTWL, WLINT, x(i) );
        % v(2)
        y2 = x_q(i)*mu2_alpha(1) + register2(3)*mu2_alpha(2) + register2(2)*mu2_alpha(3) + register2(1)*mu2_alpha(4);    
        register2( 1:2 ) = register2( 2:3 );
        register2( 3 ) = x_q(i);
        % v(1)
        y1 = x_q(i)*mu1_alpha(1) + register1(3)*mu1_alpha(2) + register1(2)*mu1_alpha(3) + register1(1)*mu1_alpha(4);
        register1( 1:2 ) = register1( 2:3 );
        register1( 3 ) = x_q(i);
        % v(0)
        y0 = x_q(i)*mu0_alpha(1) + register0(3)*mu0_alpha(2) + register0(2)*mu0_alpha(3) + register0(1)*mu0_alpha(4);
        register0( 1:2 ) = register0( 2:3 );
        register0( 3 ) = x_q(i);

        for mu = (0:5)/6
            mu_q = quantizer(MUWL, WLINT, mu);
            y_ans = quantizer(j, WLINT, (quantizer(j, WLINT, y2*mu_q) + y1)*mu_q) + y0;
            y_out_c = [y_out_c y_ans];
        end  
    end
    Q6_parabolic_q = [Q6_parabolic_q ; y_out_c];
    trunction_err( j-1 ) = sqrt(mean((y_out - Q6_parabolic_q(j-1,:)).^2));
end
figure(11)
plot( wl_arr, log2(trunction_err), 'b-' )
hold on
plot( wl_arr, -9, 'ro' )
title('Error between quantized and floating point')
xlabel('After multiplier word-length')
ylabel('Output error')
hold off

%% Q6-d Determine wordlength of adder
% Initialization
WLMAX = 20;
WLINT = 2;
wl_arr = WLINT : WLMAX;
INPUTWL = 13;
MUWL = 13;
MULTWL = 13;
Q6_parabolic_q = [];
for j = wl_arr
    x_q(1) = quantizer( INPUTWL, WLINT, x(1));
    x_q(2) = quantizer( INPUTWL, WLINT, x(2));
    x_q(3) = quantizer( INPUTWL, WLINT, x(3));
    register2 = x_q(1:3);
    register1 = x_q(1:3);
    register0 = x_q(1:3);
    y_ans = [];
    y_out_d = [];
    for i = 4 : length(x)        
        x_q(i) = quantizer( INPUTWL, WLINT, x(i) );
        % v(2)
        y2 = x_q(i)*mu2_alpha(1) + register2(3)*mu2_alpha(2) + register2(2)*mu2_alpha(3) + register2(1)*mu2_alpha(4);    
        register2( 1:2 ) = register2( 2:3 );
        register2( 3 ) = x_q(i);
        % v(1)
        y1 = x_q(i)*mu1_alpha(1) + register1(3)*mu1_alpha(2) + register1(2)*mu1_alpha(3) + register1(1)*mu1_alpha(4);
        register1( 1:2 ) = register1( 2:3 );
        register1( 3 ) = x_q(i);
        % v(0)
        y0 = x_q(i)*mu0_alpha(1) + register0(3)*mu0_alpha(2) + register0(2)*mu0_alpha(3) + register0(1)*mu0_alpha(4);
        register0( 1:2 ) = register0( 2:3 );
        register0( 3 ) = x_q(i);

        for mu = (0:5)/6
            mu_q = quantizer(MUWL, WLINT, mu);
            y2MULTmu_q = quantizer(MULTWL, WLINT, y2*mu_q);
            y_ans = quantizer(j, WLINT, quantizer(MULTWL, WLINT, quantizer(j, WLINT, y2MULTmu_q + y1)*mu_q ) + y0);
            y_out_d = [y_out_d y_ans];
        end  
    end
    Q6_parabolic_q = [Q6_parabolic_q ; y_out_d];
    trunction_err( j-1 ) = sqrt(mean((y_out - Q6_parabolic_q(j-1,:)).^2));
end
figure(12)
plot( wl_arr, log2(trunction_err), 'b-' )
hold on
plot( wl_arr, -9, 'ro' )
title('Error between quantized and floating point')
xlabel('Adder word-length')
ylabel('Output error')
hold off

%% Write data
x_verilog = floor(x*2^(13-2));
mu = [0 1/6 2/6 3/6 4/6 5/6];
mu_verilog = floor(mu*2^(13-2));
fid = fopen('input_x.txt', 'w');
fprintf(fid, "%d\n", x_verilog);

x_fpga = [];
for k = 4 : 44
    for s = 1 : 6
    reaptx(1,s) = x_verilog( :,k );   
    end
    x_fpga = [x_fpga reaptx];
end
fid = fopen('inputx2fpga.txt', 'w');
fprintf(fid, "%d\n", x_fpga);
fclose(fid);

fid = fopen('mu.txt', 'w');
fprintf(fid, "%d\n", mu_verilog);
fclose(fid);

%% Read data
C = zeros(1,246);
C( 1, :) = textread('D:\graduate_ncu\DCCD_lab\lab_4\Q7\Q7.sim\sim_1\behav\xsim\fpga_output_y.txt', '%n');
y_verilog = C(1,:)/2^11;
trunction_err_verilog = y_out - y_verilog;
% trunction_err_verilog = sqrt(mean((y_out - y_verilog).^2));
stem(trunction_err_verilog)
title('Error between Verilog and Matlab output')
% xlabel('')
ylabel('Error')

%% Read data
C = zeros(1,248);
C( 1, :) = textread('D:\graduate_ncu\DCCD_lab\lab_4\lab4_v2018.3\lab4_v2018.3.sim\sim_1\synth\timing\xsim\output_y.txt', '%n');
y_posim = C(1,:)/2^11;
D = zeros(1,248);
D(1, :) = textread('D:\graduate_ncu\DCCD_lab\lab_4\lab4_v2018.3\vericomm\fpga_output_y.out', '%n');
y_fpga = D(1,:)/2^11;
trunction_err_verilog = y_posim - y_fpga;
figure
plot(trunction_err_verilog)
% stem(trunction_err_verilog)
title('Error between post-route and FPGA board')
% xlabel('')
ylabel('Error')



%% TEST

% input x(m)
x_m = @(m) cos(2*pi*((m*Ts)/(8*Ts) + phi/10));
m = 23:66;
x = x_m(m);

mu2_alpha = [alpha -alpha -alpha alpha];
mu1_alpha = [-alpha alpha+1 alpha-1 -alpha];
mu0_alpha = [0 0 1 0];
register2 = x(1:3);
register1 = x(1:3);
register0 = x(1:3);
y_out = [];
w1 = [];
w2 = [];
w3 = [];
for i = 4 : length(x)
    % v(2)
    y2(i-3) = x( i )*mu2_alpha(1) + register2(3)*mu2_alpha(2) + register2(2)*mu2_alpha(3) + register2(1)*mu2_alpha(4);    
    register2( 1:2 ) = register2( 2:3 );
    register2( 3 ) = x( i );
    % v(1)
    y1(i-3) = x( i )*mu1_alpha(1) + register1(3)*mu1_alpha(2) + register1(2)*mu1_alpha(3) + register1(1)*mu1_alpha(4);
    register1( 1:2 ) = register1( 2:3 );
    register1( 3 ) = x( i );
    % v(0)
    y0(i-3) = x( i )*mu0_alpha(1) + register0(3)*mu0_alpha(2) + register0(2)*mu0_alpha(3) + register0(1)*mu0_alpha(4);
    register0( 1:2 ) = register0( 2:3 );
    register0( 3 ) = x( i );
   
    for mu = (0:5)/6
        w11 = y2(i-3)*mu;
        w1 = [w1 w11];
        w22 = w11 + y1(i-3);
        w2 = [w2 w22];
        w33 = w22*mu;
        w3 = [w3 w33];
        y_ans =  w33 + y0(i-3);
        y_out = [y_out y_ans];
    end
end
