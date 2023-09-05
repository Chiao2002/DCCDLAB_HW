% PN sequence(M-sequence) generation
m = 4;       % Number of flip-flops
N = 2 ^ m-1; % Length of PN sequence

% Initial state of LFSR
s3 = 1;
s2 = 0;
s1 = 0;
s0 = 0;

% States of LFSR
states = [];
for i = 1:N
    states = [states; s3(i) s2(i) s1(i) s0(i)];
    s3(i+1) = s0(i);
    s2(i+1) = s3(i);
    s1(i+1) = s2(i);
    s0(i+1) = xor(s1(i),s0(i));
end

% PN sequence
pn = s0(1:N);

figure;
stem(pn);

% Mapping
ind_0 = find(pn==0);
ind_1 = find(pn==1);
pn_1(ind_0) = 1;
pn_1(ind_1) = -1;

% Periodic Autocorrelation
ac = [];
for k=-1:N+1
    pn_shift = circshift(pn_1,k);
    ac_1 = sum(pn_1.*pn_shift)/N;
    ac = [ac ac_1];
end

figure;
k=-1:N+1;
plot(k,ac);
xlabel('Shift k');
ylabel('Periodic Autocorrelation');
