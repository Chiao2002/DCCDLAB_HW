clear; clc;
%%  Q1
% Paramater
T = 1;
Ts = T/4;
beta = 0.25;
h_n = zeros( 1, 25 );
% Impulse response
for n = 1:length(h_n)
    t = ((n-13)*Ts);
    if t == T/(2*beta) || t == -T/(2*beta)
        h_n(n) = pi/(4*T) * sinc(1/(2*beta));
    else
        h_n(n) = (1/T) * sinc(t/T)*cos((pi*beta*t/T))/(1-(2*beta*t/T)^2);
    end
end
figure(1)
x_axis = -12:1:12;
stem( x_axis, h_n )   % time-domain
title('Time-domain impulse response')
xlabel('n'), ylabel('h[n]')
% Draw the magnitude and phase response of the frequency-domain
fvtool(h_n);
close all;

%% Q2
% Time-domain
n=0:100;
x_n = 1/2 * (sin(2.*pi.*n./32) + sin(2.*pi.*n./4) + cos(2.*pi.*n./16));
% Frequency-domain
X = fft(x_n);
X_sh = fftshift(X);
% Magnitude
X_amp = 20*log10(abs(X_sh));

% Initialization
REGISLEN = length(h_n) - 1;
register = zeros( 1, REGISLEN );
x_pd = zeros( 1, length(x_n)+REGISLEN );
y = zeros( 1, length(x_pd) );

x_pd( 1, 1:length(x_n) ) = x_n;
% Time-domain output(direct form)
for i = 1 : length(x_pd)
   y(i) = x_pd( i )*h_n(1) + sum(register(1:24).*h_n( 2:25 ));
   register( 2:24 ) = register( 1:23 ); 
   register( 1 ) = x_pd( i );
end

% Frequency-domain output
Y = fft(y);
Y_sh = fftshift(Y);
% Magnitude
Y_amp = 20*log10(abs(Y_sh));

% Draw the input signal in time-domain
figure(4)
stem(x_n)
title('Signal input in time-domain')
xlabel('n'), ylabel('x[n]')
% Draw the magnitude and phase response of frequency-domaun
fvtool(x_n); % Input signal
fvtool(y);   % Output signal
% Draw the output signal in time-domain
figure(6)
stem(y)
title('Signal output in time-domain')
xlabel('n'), ylabel('y[n]')
close all;

%% Q3 %%%%%%%%%%%%%%
%% function
% quantization
quantizer = @(word_len, int_part, x)  floor(x * 2^(word_len-int_part)) / 2^(word_len-int_part);

% Initialization
register = zeros(1,REGISLEN);
x_pd = zeros( 1, length(x_n)+REGISLEN );
y_n = zeros( 1, length(x_pd) );

% Direct form
directForm = @(x, h_n, register, word_len, int_part)  quantizer(word_len, int_part, x*h_n(1)) + sum( quantizer( word_len, int_part, register.*h_n( 2:25 )) );
x_pd( 1, 1:length(x_n) ) = x_n;
for i = 1: 125
    x_input =  x_pd(i);
    % get y
    y_n(i) = directForm( x_input, h_n, register, 32, 8);

    % update shift register
    register( 2:24 ) = register( 1:23 );
    register( 1 ) = x_input;
end
%%
% Initialization
WLMAX = 25;
WLINT = 2;
REGISLEN = length(h_n) - 1;
wl_arr = WLINT : WLMAX;
x_pd = [ x_n zeros(1, REGISLEN)];
%% Q3-a
register = zeros(1,REGISLEN);
y_n = zeros(1 , length(x_pd));   % initial y[n]
trunction_err = zeros(1 , WLMAX-WLINT+1);   % initial trunction error array

Q3_x = [];

% Input signal trunction error test
for j = wl_arr
    for i = 1:length(x_pd)
        x_input = quantizer( j, WLINT, x_pd(i));
        Q3_x = [Q3_x x_input];
        % get y
        y_n(i) = directForm( x_input, h_n, register, 32, 8);

        % update shift register
        register( 2:24 ) = register( 1:23 );
        register( 1 ) = x_input;
    end
    trunction_err( j-1 ) = sum(abs(y - y_n)) / length(y);
end
figure(8)
title('Output error versus input word-length')
xlabel('Input word-length')
ylabel('Output error')
plot( wl_arr, log2(trunction_err), 'b-' )
hold on
plot( wl_arr, -12, 'ro' )
hold off
close all;
%% Q3-b
register = zeros(1,REGISLEN);
y_n = zeros(1 , length(x_pd));   % initial y[n]
trunction_err = zeros(1 , WLMAX-WLINT+1);   % initial trunction error array
% Coefficient of FIR trunction error test

register = zeros(1,REGISLEN);
y_n = zeros(1 , length(x_pd));   % initial y[n]
trunction_err = zeros(1 , WLMAX-WLINT+1);   % initial trunction error array

for j = wl_arr
    h_n_q = quantizer(j, WLINT, h_n); 
    for i = 1:length(x_pd)
        x_input = quantizer( 17, WLINT, x_pd(i) );
        
        % get y
        y_n(i) = directForm( x_input, h_n_q, register, 32, 8 );

        % update shift register
        register( 2:24 ) = register( 1:23 );
        register( 1 ) = x_input;
    end
    trunction_err( j-1 ) = sum(abs(y - y_n)) / length(y);
end
figure(9)
title('Output error versus coefficient word-length')
xlabel('Coefficient word-length')
ylabel('Output error')
hold on
plot( wl_arr, log2(trunction_err), 'b-')
plot( wl_arr, -12, 'ro')
hold off
close all;


%% Q3-c
% Multiplication trunction error test
h_n_q = quantizer(17, WLINT, h_n);
for j = wl_arr
    for i = 1:length(x_pd)
        x_input = quantizer( 17, WLINT, x_pd(i) );
        
        % get y
        y_n(i) = directForm( x_input, h_n_q, register, j, WLINT );

        % update shift register
        register( 2:24 ) = register( 1:23 );
        register( 1 ) = x_input;
    end
    trunction_err( j-1 ) = sum(abs(y - y_n)) / length(y);
end
figure(10)
title('Output error versus word-length afrer multiplication')
xlabel('Word-length after multiplication')
ylabel('Output error')
hold on
plot(wl_arr, log2(trunction_err), 'b-')
plot(wl_arr, -12, 'ro')
hold off
fvtool(h_n_q)
close all;
%% Q3-d
% Addition trunction error test
h_n_q = quantizer(17, WLINT, h_n);

for j = wl_arr
    for i = 1:length(x_pd)
        x_input = quantizer( 17, WLINT, x_pd(i) );
        
        % get y
        s = quantizer(20, WLINT, x_input * h_n_q(1));
        for k = 2:REGISLEN
            s = quantizer(j, WLINT, s + quantizer(20, WLINT, register(k-1)*h_n_q(k)));
        end
        y_n(i) = s;
        
        % update shift register
        register( 2:24 ) = register( 1:23 );
        register( 1 ) = x_input;
    end
    trunction_err( j-1 ) = sum(abs(y - y_n)) / length(y);
end
figure(11)
title('Output error versus word-length afrer addition')
xlabel('Word-length after addition')
ylabel('Output error')
hold on
plot(wl_arr, log2(trunction_err), 'b-')
plot(wl_arr, -12, 'ro')
hold off
close all;

%% Q4 %%%%%%%%%%%%%%
% quantization function
quantizer = @(word_len, int_part, x)  floor(x * 2^(word_len - int_part)) / 2^(word_len - int_part);

% Initialization
register = zeros(1,REGISLEN);
y_trans = zeros(1 , length(x_pd));   % initial y[n]

% Transposed form
for i = 1:length(x_pd)
    x_input = x_pd(i);
    
    % get y
    y_trans(i) = register(end) + x_input*h_n(1);    
    if i ~= length(x_pd)
        for k = 1:REGISLEN-1
            register(REGISLEN-k+1) = register(REGISLEN-k) + x_input*h_n(k + 1);
        end
        register(1) = x_input*h_n(end);
    end    
end
close all;
%% Q4-a
% Initialization
register = zeros(1,REGISLEN);
y_n = zeros(1 , length(x_pd));   % initial y[n]
trunction_err = zeros(1 , WLMAX-WLINT+1);   % initial trunction error array

% Input signal trunction error test
for j = wl_arr
    for i = 1:length(x_pd)
        x_input = quantizer(j, WLINT, x_pd(i));

        % get y
        y_n(i) = register(end) + x_input*h_n(1);    
        if i ~= length(x_pd)
            for k = 1:REGISLEN-1
                register(REGISLEN-k+1) = register(REGISLEN-k) + x_input*h_n(k + 1);
            end
            register(1) = x_input*h_n(end);
        end    
    end 
    trunction_err( j-1 ) = sum(abs(y_trans - y_n)) / length(y_trans);
end
figure(12)
title('Output error versus input word-length')
xlabel('Input word-length')
ylabel('Output error')
hold on
plot( wl_arr, log2(trunction_err), 'b-' )
plot( wl_arr, -14, 'ro' )
hold off
close all;


%% Q4-b
% Initialization
register = zeros(1,REGISLEN);
y_n = zeros(1 , length(x_pd));   % initial y[n]
trunction_err = zeros(1 , WLMAX-WLINT+1);   % initial trunction error array

% Coefficient of FIR trunction error test
for j = wl_arr
    h_n_q = quantizer(j, WLINT, h_n);
    for i = 1:length(x_pd)
        x_input = quantizer(19, WLINT, x_pd(i));

        % get y
        y_n(i) = register(end) + x_input*h_n_q(1);    
        if i ~= length(x_pd)
            for k = 1:REGISLEN-1
                register(REGISLEN-k+1) = register(REGISLEN-k) + x_input*h_n_q(k + 1);
            end
            register(1) = x_input*h_n_q(end);
        end    
    end 
    trunction_err( j-1 ) = sum(abs(y_trans - y_n)) / length(y_trans);
end
figure(13)
title('Output error versus coefficient word-length')
xlabel('Coefficient word-length')
ylabel('Output error')
hold on
plot( wl_arr, log2(trunction_err), 'b-')
plot( wl_arr, -14, 'ro')
hold off
close all;
%% Q4-c
% Initialization
register = zeros(1,REGISLEN);
y_n = zeros(1 , length(x_pd));   % initial y[n]
trunction_err = zeros(1 , WLMAX-WLINT+1);   % initial trunction error array

% Multiplication trunction error test
for j = wl_arr
    h_n_q = quantizer(18, WLINT, h_n);
    for i = 1:length(x_pd)
        x_input = quantizer(19, WLINT, x_pd(i));

        % get y
        y_n(i) = register(end) + quantizer(j, WLINT, x_input*h_n_q(1));    
        if i ~= length(x_pd)
            for k = 1:REGISLEN-1
                register(REGISLEN-k+1) = register(REGISLEN-k) + quantizer(j, WLINT, x_input*h_n_q(k + 1));
            end
            register(1) = quantizer(j, WLINT, x_input*h_n_q(end));
        end    
    end 
    trunction_err( j-1 ) = sum(abs(y_trans - y_n)) / length(y_trans);
end
figure(14)
title('Output error versus word-length afrer multiplication')
xlabel('Word-length after multiplication')
ylabel('Output error')
hold on
plot(wl_arr, log2(trunction_err), 'b-')
plot(wl_arr, -14, 'ro')
hold off
fvtool(h_n_q)
close all;
%% Q4-d
% Initialization
register = zeros(1,REGISLEN);
y_n = zeros(1 , length(x_pd));   % initial y[n]
trunction_err = zeros(1 , WLMAX-WLINT+1);   % initial trunction error array

% Addition trunction error test
for j = wl_arr
    h_n_q = quantizer(18, WLINT, h_n);
    for i = 1:length(x_pd)
        x_input = quantizer(19, WLINT, x_pd(i));

        % get y
        y_n(i) = quantizer(j, WLINT, register(end) + quantizer(22, WLINT, x_input*h_n_q(1)));    
        if i ~= length(x_pd)
            for k = 1:REGISLEN-1
                register(REGISLEN-k+1) = quantizer(j, WLINT, register(REGISLEN-k) + quantizer(22, WLINT, x_input*h_n_q(k + 1)));
            end
            register(1) = quantizer( 22, WLINT, x_input*h_n_q(end) );
        end    
    end
    trunction_err( j-1 ) = sum(abs(y_trans - y_n)) / length(y_trans);
end
figure(15)
title('Output error versus word-length afrer addition')
xlabel('Word-length after addition')
ylabel('Output error')
hold on
plot(wl_arr, log2(trunction_err), 'b-')
plot(wl_arr, -14, 'ro')
hold off
close all;


%% Write data(direct form)
x = floor(x_pd*2^(17-2));
h = floor(h_n*2^(17-2));
fid = fopen('input_x.txt', 'w');
fprintf(fid, "%d\n", x);
fid = fopen('h.txt', 'w');
fprintf(fid, "%d\n", h);
fclose(fid);

%% Read data
C = zeros(1,125);
C( 1, :) = textread('D:\graduate_ncu\DCCD_lab\lab_3\Q6\Q6.sim\sim_1\behav\xsim\output_y.txt', '%n');
direct_y_verilog = C(1,:)/2^17;
direct_trunction_err_verilog = log2(sum(abs(y - direct_y_verilog))/length(y));
stem(direct_trunction_err_verilog)
title('Average error')
% xlabel('')
ylabel('Average error(log2)')
%% Write data(transposed form)
x_trans = floor(x_pd*2^(19-2));
h_trans = floor(h_n*2^(18-2));
fid = fopen('trans_input_x.txt', 'w');
fprintf(fid, "%d\n", x_trans);
fid = fopen('trans_h.txt', 'w');
fprintf(fid, "%d\n", h_trans);
fclose(fid);

%% Read data
D = zeros(1,125);
D( 1, :) = textread('D:\graduate_ncu\DCCD_lab\lab_3\Q7\Q7.sim\sim_1\behav\xsim\output_y.txt', '%n');
trans_y_verilog = D(1,:)/2^17;
trans_trunction_err_verilog = log2(sum(abs(y - trans_y_verilog))/length(y));
stem(trans_trunction_err_verilog)
title('Average error')
% xlabel('')
ylabel('Average error(log2)')


%% Transposed form
% % quantization function
% quantizer = @(word_len, int_part, x)  floor(x * 2^(word_len - int_part)) / 2^(word_len - int_part);
% 
% % Initialization
% register = zeros(1,REGISLEN);
% y_trans = zeros(1 , length(x_pd));   % initial y[n]
% trunction_err = zeros(1 , WLMAX-WLINT+1);   % initial trunction error array
% register_ex = zeros(1,REGISLEN);
%
% for i = 1:length(x_pd)
%     x_input =  x_pd(i);
%     % update shift register
%     register( 1:23 ) = register( 2:24 );
%     register( 24 ) = x_input;
% 
%     % get y
%     s =  0;
%     for k = 1:REGISLEN %2:24
%         s = s +  register(REGISLEN - k + 1)*h_n(k);
%     end
%     y_trans(i) = s;
% end
%         
%%
% z = zeros(length(h_n)-1);
%
% y(1) = z(24) + x(1)*h(1);
% z( 24 ) =  z(23) + x(1)*h(1);
% z( 23 ) = z(22) + x(1)*h(2);
% z( 22 ) = z(21) + x(1)*h(3);
%     .
%     .
%     .
% z( 2 ) = z(1) + x(1)*h(24);
% z( 1 ) = x(1)*h(25) + x(1)/h(24) + x(1)*h(23) + ...;











