clear all;close all;clc;
%% generate 32 input
S = 1/sqrt(2) * [1+i, 1-i, -1+i, -1-i];
rng('default');
Y = S(randi(4, 1, 32));
x = ifft(Y);

m = 0:1:31;

figure(1)
subplot(211), stem(m, real(Y))
title('Real-part of Y0 ~ Y31')
xlabel('Y0 ~ Y31')
ylabel('real-part')
subplot(212), stem(m, imag(Y))
title('Imaginary-part of Y0 ~ Y31')
xlabel('Y0 ~ Y31')
ylabel('imaginary-part')

figure(2)
subplot(211), stem(m, real(x))
title('Real-part of x0 ~ x31')
xlabel('x0 ~ x31')
ylabel('real-part')
subplot(212), stem(m, imag(x))
title('Imaginary-part of x0 ~ x31')
xlabel('x0 ~ x31')
ylabel('imaginary-part')


%% 32-point fft
f1 = @(a, b, neg) (a + (b*neg));
f2 = @(a, b, neg) (a + (b*neg));
f3 = @(a, b, neg) (a + (b*neg));
f4 = @(a, b, neg) (a + (b*neg));
f5 = @(a, b, neg) (a + (b*neg));

x_in = [x zeros(1, length(x))];

%
s1_w_1 = ones(1,16);
s1_w_n = [exp(-j * 2 * pi / 32 * (0:15)) s1_w_1 exp(-j * 2 * pi / 32 * (0:15)) s1_w_1 ];
w_s1_real_floor = floor(real(s1_w_n) * 2^(13-2));
w_s1_imag_floor = floor(imag(s1_w_n) * 2^(13-2));
%
s2_w_1 = ones(1,8);
s2_w = [exp(-j * 2 * pi / 32 * 0) exp(-j * 2 * pi / 32 * 2)  exp(-j * 2 * pi / 32 * 4)  exp(-j * 2 * pi / 32 * 6)... 
        exp(-j * 2 * pi / 32 * 8) exp(-j * 2 * pi / 32 * 10) exp(-j * 2 * pi / 32 * 12) exp(-j * 2 * pi / 32 * 14)];
s2_w_n = [s2_w s2_w_1 s2_w s2_w_1 s2_w s2_w_1 s2_w s2_w_1];
w_s2_real_floor = floor(real(s2_w_n) * 2^(13-2));
w_s2_imag_floor = floor(imag(s2_w_n) * 2^(13-2));
%
s3_w_1 = ones(1,4);
s3_w = [exp(-j * 2 * pi / 32 * 0) exp(-j * 2 * pi / 32 * 4) exp(-j * 2 * pi / 32 * 8) exp(-j * 2 * pi / 32 * 12)];
s3_w_n = [s3_w s3_w_1 s3_w s3_w_1 s3_w s3_w_1 s3_w s3_w_1 s3_w s3_w_1 s3_w s3_w_1 s3_w s3_w_1 s3_w s3_w_1];
w_s3_real_floor = floor(real(s3_w_n) * 2^(13-2));
w_s3_imag_floor = floor(imag(s3_w_n) * 2^(13-2));
%
s4_w_1 = ones(1,2);
s4_w = [exp(-j * 2 * pi / 32 * 0) exp(-j * 2 * pi / 32 * 8)];
s4_w_n = [s4_w s4_w_1 s4_w s4_w_1 s4_w s4_w_1 s4_w s4_w_1 ...
          s4_w s4_w_1 s4_w s4_w_1 s4_w s4_w_1 s4_w s4_w_1 ...
          s4_w s4_w_1 s4_w s4_w_1 s4_w s4_w_1 s4_w s4_w_1 ...
          s4_w s4_w_1 s4_w s4_w_1 s4_w s4_w_1 s4_w s4_w_1];
w_s4_real_floor = floor(real(s4_w_n) * 2^(13-2));
w_s4_imag_floor = floor(imag(s4_w_n) * 2^(13-2));
s5_w_n = ones(1, 64);
%

s1 = zeros(1,16);
s2 = zeros(1,8);
s3 = zeros(1,4);
s4 = zeros(1,2);
s5 = zeros(1,1);

s1_bypass = ones(1, 16);
s1_butterfly = zeros(1, 16);
s2_bypass = ones(1, 8);
s2_butterfly = zeros(1, 8);
s3_bypass = ones(1, 4);
s3_butterfly = zeros(1, 4);
s4_bypass = ones(1, 2);
s4_butterfly = zeros(1, 2);
s1_bypass_mode = [s1_bypass s1_butterfly s1_bypass s1_butterfly];
s2_bypass_mode = [s2_bypass s2_butterfly s2_bypass s2_butterfly s2_bypass s2_butterfly s2_bypass s2_butterfly];
s3_bypass_mode = [s3_bypass s3_butterfly s3_bypass s3_butterfly s3_bypass s3_butterfly s3_bypass s3_butterfly...
                  s3_bypass s3_butterfly s3_bypass s3_butterfly s3_bypass s3_butterfly s3_bypass s3_butterfly];
s4_bypass_mode = [s4_bypass s4_butterfly s4_bypass s4_butterfly s4_bypass s4_butterfly s4_bypass s4_butterfly...
                  s4_bypass s4_butterfly s4_bypass s4_butterfly s4_bypass s4_butterfly s4_bypass s4_butterfly...
                  s4_bypass s4_butterfly s4_bypass s4_butterfly s4_bypass s4_butterfly s4_bypass s4_butterfly...
                  s4_bypass s4_butterfly s4_bypass s4_butterfly s4_bypass s4_butterfly s4_bypass s4_butterfly];
s5_bypass_mode = [1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 ...
                  1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 ...
                  1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 ...
                  1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0];


s1_butterfly_mode = zeros(1, length(x_in));
s2_butterfly_mode = zeros(1, length(x_in));
s3_butterfly_mode = zeros(1, length(x_in));
s4_butterfly_mode = zeros(1, length(x_in));
s5_butterfly_mode = zeros(1, length(x_in));

s1_bypass_arr = zeros(1,length(x_in));
s2_bypass_arr = zeros(1,length(x_in));
s3_bypass_arr = zeros(1,length(x_in));
s4_bypass_arr = zeros(1,length(x_in));
s5_bypass_arr = zeros(1,length(x_in));

s1_val_out = [];
s2_val_out = [];
s3_val_out = [];
s4_val_out = [];
s5_val_out = zeros(1,length(x_in)); %64
for i = 1:length(x_in)
    
    % stage 1
    s1_pop = s1(end);
    
    if s1_bypass_mode(i) == 1
        % by pass
        s1 = [x_in(i) s1(1:end-1)];
        s1_val = s1_pop;
    else
        % butterfly
        s1_val = f1(s1_pop, x_in(i), 1);
        s1 = [f1(s1_pop, x_in(i), -1) s1(1:end-1)];
        s1_butterfly_mode(i) = 1;
    end
    s1_val = s1_val * s1_w_n(i);
%     s1_val = s1_val;

    s1_val_out = [s1_val_out s1_val];
    floor_s1_out_real = floor(real(s1_val_out) * 2^(13-2));
    floor_s1_out_imag = floor(imag(s1_val_out) * 2^(13-2));
%     floor_s1_out_real = floor(real(s1_val_out) * 2^(12-1));
%     floor_s1_out_imag = floor(imag(s1_val_out) * 2^(12-1));
    
    % stage 2
    s2_pop = s2(end);
    
    if s2_bypass_mode(i) == 1  
        % by pass
        s2_val = s2_pop;
        s2 = [s1_val s2(1:end-1)];
    else
        % butterfly
        s2_val = f2(s2_pop, s1_val, 1);
        s2 = [f2(s2_pop, s1_val, -1) s2(1:end-1)];
        s2_butterfly_mode(i) = 1;
    end
    s2_val = s2_val * s2_w_n(i);
%     s2_val = s2_val;
    
    s2_val_out = [s2_val_out s2_val];
    floor_s2_out_real = floor(real(s2_val_out) * 2^(14-2));
    floor_s2_out_imag = floor(imag(s2_val_out) * 2^(14-2));
% 
% 
    % stage 3
    s3_pop = s3(end);

    if s3_bypass_mode(i) == 1
        % by pass
        s3_val = s3_pop;
        s3 = [s2_val s3(1:end-1)];
    else
        % butterfly
        s3_val = f3(s3_pop, s2_val, 1);
        s3 = [f3(s3_pop, s2_val, -1) s3(1:end-1)];
        s3_butterfly_mode(i) = 1;
    end
    s3_val = s3_val * s3_w_n(i);
    
    s3_val_out = [s3_val_out s3_val];
    floor_s3_out_real = floor(real(s3_val_out) * 2^(15-2));
    floor_s3_out_imag = floor(imag(s3_val_out) * 2^(15-2));
    
    % stage 4
    s4_pop = s4(end);

    if s4_bypass_mode(i) == 1
        % by pass
        s4_val = s4_pop;
        s4 = [s3_val s4(1:end-1)];
    else
        % butterfly
        s4_val = f4(s4_pop, s3_val, 1);
        s4 = [f4(s4_pop, s3_val, -1) s4(1:end-1)];
        s4_butterfly_mode(i) = 1;
    end
    s4_val = s4_val * s4_w_n(i);
%     s4_val = s4_val ;
    
    s4_val_out = [s4_val_out s4_val];
    floor_s4_out_real = floor(real(s4_val_out) * 2^(16-2));
    floor_s4_out_imag = floor(imag(s4_val_out) * 2^(16-2));
    
    % stage 5
    s5_pop = s5;

    if s5_bypass_mode(i) == 1
        % by pass
        s5_val = s5_pop;
        s5 = s4_val;
    else
        % butterfly
        s5_val = f5(s5_pop, s4_val, 1);
        s5 = f5(s5_pop, s4_val, -1);
        s5_butterfly_mode(i) = 1;
    end

    s5_val_out(i) = s5_val;  % M1:1~16; M2:17~32
    
end
% x_ifft_sdf = s5_val_out(1, 8:15);
floor_s5_out_real = floor(real(s5_val_out) * 2^(17-3));
floor_s5_out_imag = floor(imag(s5_val_out) * 2^(17-3));

% bit-reverse
M1 = s5_val_out(32:47);
M2 = s5_val_out(48:63);
x_ifft_bitrev = [];
M_index = [1 9 5 13 3 11 7 15 2 10 6 14 4 12 8 16];
for k = 1:16
    x_ifft_bitrev = [x_ifft_bitrev M1(M_index(k)) M2(M_index(k))];
end

floor_bitrev_out_real = floor(real(x_ifft_bitrev) * 2^(17-3));
floor_bitrev_out_imag = floor(imag(x_ifft_bitrev) * 2^(17-3));


differ_XY = x_ifft_bitrev - Y;

figure(3)
subplot(211), stem(m, real(x_ifft_bitrev))
title('After bit-reverse real-part of X0 ~ X31')
xlabel('X0 ~ X31')
ylabel('real-part')
subplot(212), stem(m, imag(x_ifft_bitrev))
title('After bit-reverse imaginary-part of X0 ~ X31')
xlabel('X0 ~ X31')
ylabel('imaginary-part')
figure(4)
subplot(211), stem(m, real(differ_XY))
title('The difference of real-part between X and Y')
xlabel('index')
ylabel('error')
subplot(212), stem(m, imag(differ_XY))
title('The difference of imaginary-part between X and Y')
xlabel('index')
ylabel('error')

% close all;

%% write data
x_in_real = floor( real(x_in) * 2^(12-1) );
x_in_imag = floor( imag(x_in) * 2^(12-1) );

fid = fopen('inData.txt','w');
for k = 1:length(x_in)
    fprintf(fid, "%d %d\n", x_in_real(k), x_in_imag(k));
end
fclose(fid);

fid = fopen('inReal.txt','w');
for k = 1:length(x_in)
    fprintf(fid, "%d\n", x_in_real(k));
end
fclose(fid);
fid = fopen('inImag.txt','w');
for k = 1:length(x_in)
    fprintf(fid, "%d\n", x_in_imag(k));
end
fclose(fid);

a = zeros(1,200);
for k = 1 : 200
    if (k==2)
        a(k)=1;
    else
        a(k)=0;
    end
end
fid = fopen('rst2fpga.txt','w');
for k = 1:200
    fprintf(fid, "%d \n", a(k));
end
fclose(fid);

b = ones(1,200);
for k = 1 : 200
    if (k==1 || k ==2)
        b(k)=0;
    else
        b(k)=1;
    end
end
fid = fopen('en2fpga.txt','w');
for k = 1:200
    fprintf(fid, "%d \n", b(k));
end
fclose(fid);

%% read data
A = zeros(1, 32);
A( 1, :) = textread('D:\Chiao\DCCDlab\lab_6\lab6_fft32\lab6_fft32.sim\sim_1\behav\xsim\output_real.txt', '%n');
out_real_verilog = A(1,:)/2^14;

B = zeros(1, 32);
B( 1, :) = textread('D:\Chiao\DCCDlab\lab_6\lab6_fft32\lab6_fft32.sim\sim_1\behav\xsim\output_imag.txt', '%n');
out_imag_verilog = B(1,:)/2^14;

error_real = abs(real(x_ifft_bitrev) - out_real_verilog);
error_imag = abs(imag(x_ifft_bitrev) - out_imag_verilog);

figure(6)
subplot(211), stem(m, error_real)
title('The difference of real-part output between Matlab and Verilog')
xlabel('index')
ylabel('error')
subplot(212), stem(m, error_imag)
title('The difference of imaginary-part output between Matlab and Verilog')
xlabel('index')
ylabel('error')

figure(7)
stem(log2(mean(error_real)))
title('The error of real-part output between Matlab and Verilog')
ylabel('error(log2)')
figure(8)
stem(log2(mean(error_imag)))
title('The error of imaginary-part output between Matlab and Verilog')
ylabel('error(log2)')

close all;