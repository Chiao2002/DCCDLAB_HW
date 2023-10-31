% rng('default');
% N=8;
% Set=1/sqrt(2)*[1+j, 1-j, -1+j, -1-j];
% y = Set(randi(length(Set), 1, N));
% Y = fft(y);
%FFT 8-points
%Number of input y = 8
function Y_dif=fft8_dif_radix2(y)
N=8;
%stage3
half=N/2; %4
for k=1:half
    twiddle=exp(-i*2*pi/N*(k-1));
    g(k)=y(k)+y(k+half);
    g(k+half)=(y(k)-y(k+half))*twiddle;
end

%stage2
half=N/2/2; %2
for k=1:half
    twiddle=exp(-i*2*pi/(N/2)*(k-1));
    h(k)=g(k)+g(k+half);                               %1:1-3, 2:2-4
    h(k+half)=(g(k)-g(k+half))*twiddle;           %3:1-3, 4:2-4
    h(k+half+2)=g(k+4)+g(k+4+half);             %5:5-7, 6:6-8
    h(k+half+4)=(g(k+4)-g(k+4+half))*twiddle;%7:5-7, 8:6-8
end

%stage1
half=N/2/2/2; %1
for k=1:half
    twiddle=exp(-i*2*pi/(N/4)*(k-1));
    Y_i(1)=h(k)+h(k+half);
    Y_i(2)=(h(k)-h(k+half))*twiddle;
    Y_i(3)=h(k+2)+h(k+2+half);
    Y_i(4)=(h(k+2)-h(k+2+half))*twiddle;
    Y_i(5)=h(k+4)+h(k+4+half);
    Y_i(6)=(h(k+4)-h(k+4+half))*twiddle;
    Y_i(7)=h(k+6)+h(k+6+half);
    Y_i(8)=(h(k+6)-h(k+6+half))*twiddle;
end
Y_dif=bitrevorder(Y_i);
end




