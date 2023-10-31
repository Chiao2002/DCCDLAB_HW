clear all;
rng('default');
% Quantization Function %
% round error:
quantizer_round = @(word_len, int_part, x)  round(x * 2^(word_len-int_part)) / 2^(word_len-int_part);
% truncation error:
quantizer_floor = @(word_len, int_part, x)  floor(x * 2^(word_len-int_part)) / 2^(word_len-int_part);

N=8;
Set=1/sqrt(2)*[1+j, 1-j, -1+j, -1-j];
y = Set(randi(length(Set), 1, N));
%word-length of input of stage3: 
%S0.11=12bits
% y_qu=quantizer_floor(12, 1, y);
% y_fixed=y_qu*2^11;
[y_qu, y_fixed]=TruncationError(y, 12, 1);
Y = fft(y);

%stage3
half=N/2; %4
for k=1:half
    twiddle=exp(-i*2*pi/N*(k-1));
    %word-length of twiddle factor: S1.11=13bits
    twiddle_qu(k)=quantizer_round(13, 2, twiddle);
    twiddle8_fixed(k)=twiddle_qu(k)*2^11;
    
    %S0.11+S0.11=S1.11(sign extension):13bits
    g(k)=y_qu(k)+y_qu(k+half);
%     g_qu(k)=quantizer_floor(13, 2, g(k));
%     g_fixed(k)=g_qu(k)*2^11;
    [g_qu(k), g_fixed(k)]=TruncationError(g(k), 13, 2);
    
    %%%%%
    g_temp(k)=y_qu(k)+y_qu(k+half);
    g_temp(k+half)=y_qu(k)-y_qu(k+half);
    %%%%%
    
    %S1.11*S1.11=S3.22 ==13bits==> S1.11
    g(k+half)=(y_qu(k)-y_qu(k+half))*twiddle_qu(k);
%     g_qu(k+half)=quantizer_floor(13, 2, g(k+half));
%     g_fixed(k+half)=g_qu(k+half)*2^11;
    [g_qu(k+half), g_fixed(k+half)]=TruncationError(g(k+half), 13, 2);
end
[g_tmp_qu, g_tmp_fixed]=TruncationError(g_temp, 13, 2);
A=[real(g_tmp_fixed); imag(g_tmp_fixed)];
B=[real(g_fixed); imag(g_fixed)];


%stage2
half=N/2/2; %2
for k=1:half
    twiddle=exp(-i*2*pi/(N/2)*(k-1));
    %word-length of twiddle factor: S1.11=13bits
    twiddle_qu(k)=quantizer_round(13, 2, twiddle);
    twiddle4_fixed(k)=twiddle_qu(k)*2^11;
    
    %S1.11+S1.11=S2.11(sign extension):14bits
    h(k)=g_qu(k)+g_qu(k+half);
%     [h_qu(k), h_fixed(k)]=TruncationError(h(k), 14, 3);
    
    h(k+half)=(g_qu(k)-g_qu(k+half))*twiddle_qu(k);
%     [h_qu(k+half), h_fixed(k+half)]=TruncationError(h(k+half), 14, 3);
    
    h(k+half+2)=g_qu(k+4)+g_qu(k+4+half);
%     [h_qu(k+half+2), h_fixed(k+half+2)]=TruncationError(h(k+half+2), 14, 3);
    
    h(k+half+4)=(g_qu(k+4)-g_qu(k+4+half))*twiddle_qu(k);
%     [h_qu(k+half+4), h_fixed(k+half+4)]=TruncationError(h(k+half+4), 14, 3);

    h_temp(k)=g_qu(k)+g_qu(k+half);
    h_temp(k+half)=g_qu(k)-g_qu(k+half);
    h_temp(k+half+2)=g_qu(k+4)+g_qu(k+4+half);
    h_temp(k+half+4)=g_qu(k+4)-g_qu(k+4+half);

end
[h_qu, h_fixed]=TruncationError(h, 14, 3);
[h_tmp_qu, h_tmp_fixed]=TruncationError(h_temp, 14, 3);
C=[real(h_tmp_fixed); imag(h_tmp_fixed)];
D=[real(h_fixed); imag(h_fixed)];

%stage1
half=N/2/2/2; %1
for k=1:half
    twiddle=exp(-i*2*pi/(N/4)*(k-1));
    %word-length of twiddle factor: S1.11=13bits
    twiddle_qu(k)=quantizer_round(13, 2, twiddle);
    twiddle2_fixed(k)=twiddle_qu(k)*2^11;
    
    %S2.11+S2.11=S3.11(sign extension):15bits
    Y_i(1)=h_qu(k)+h_qu(k+half);
    Y_i(2)=(h_qu(k)-h_qu(k+half))*twiddle_qu(k);
    Y_i(3)=h_qu(k+2)+h_qu(k+2+half);
    Y_i(4)=(h_qu(k+2)-h_qu(k+2+half))*twiddle_qu(k);
    Y_i(5)=h_qu(k+4)+h_qu(k+4+half);
    Y_i(6)=(h_qu(k+4)-h_qu(k+4+half))*twiddle_qu(k);
    Y_i(7)=h_qu(k+6)+h_qu(k+6+half);
    Y_i(8)=(h_qu(k+6)-h_qu(k+6+half))*twiddle_qu(k);
end
[Y_i_qu, Y_i_fix]=TruncationError(Y_i, 15, 4);
Y_dif=bitrevorder(Y_i);
Y_dif_qu=bitrevorder(Y_i_qu);
E=[real(Y_i_fix); imag(Y_i_fix)];

compare=[Y.' Y_dif.' Y_dif_qu.'];

% Verilog simulation %
y_r_i = [[real(y_fixed) zeros(1,N)].' [imag(y_fixed) zeros(1,N)].'];
W_r_i =[real(twiddle8_fixed).' imag(twiddle8_fixed).']; 
g_tmp_r_i=[real(g_tmp_fixed).' imag(g_tmp_fixed).' real(g_fixed).' imag(g_fixed).'];
%
function [Qu, Fixed]=TruncationError(In, WL, IWL)
quantizer_floor = @(word_len, int_part, x)  floor(x * 2^(word_len-int_part)) / 2^(word_len-int_part);
Qu=quantizer_floor(WL, IWL, In);
Fixed=Qu*2^(WL-IWL);
end