% Gold code
r = 5;       % Number of flip-flops
N = 2 ^ r-1; % Length of PN sequence
% The coefficients of primitive polynomial of degree represented as 45_oct
% Initial state of LFSR
s4 = 0;
s3 = 0;
s2 = 0;
s1 = 0;
s0 = 1;

% States of LFSR
states = [];
for i = 1:N
    states = [states; s4(i) s3(i) s2(i) s1(i) s0(i)];
    s4(i+1) = s0(i);
    s3(i+1) = s4(i);
    s2(i+1) = s3(i);
    s1(i+1) = xor(s2(i),s0(i));
    s0(i+1) = s1(i);
end

% PN sequence
b = s0(1:N);
b1 = zeros(size(b));
q = 3;
b1(1) = b(1);
i = 1;
while i<N
    ind = mod(i*q,N);
    b1(i+1) = b(ind+1);
    i = i + 1;
end

% Mapping
ind_0 = find(b==0);
ind_1 = find(b==1);
a(ind_0) = 1;
a(ind_1) = -1;
% a1 = zeros(size(b1));  % array a1
ind1_0 = find(b1==0);
ind1_1 = find(b1==1);
a1(ind1_0) = 1;
a1(ind1_1) = -1;

%Cross-correlation
cc = [];
for k = 0:N+1
    a1_shift = circshift(a1,k);
    cc_1 = sum(a.*a1_shift)/N;
    cc = [cc cc_1];
end

figure('Name','Q3 Result','NumberTitle','off');
k = 0:N+1;
plot(k,cc);
xlabel('Shift k');
ylabel('Cross-correlation');

% Generate b2 of m-sequence
s4_75 = 0;
s3_75 = 0;
s2_75 = 0;
s1_75 = 0;
s0_75 = 1;
states_75 = [];
for j = 1:N
    states_75 = [states_75; s4_75(j) s3_75(j) s2_75(j) s1_75(j) s0_75(j)];
    s4_75(j+1) = s0_75(j);
    s3_75(j+1) = xor(s4_75(j),s0_75(j));
    s2_75(j+1) = xor(s3_75(j),s0_75(j));
    s1_75(j+1) = xor(s2_75(j),s0_75(j));
    s0_75(j+1) = s1_75(j);
end

b2 = s0_75(1:N);

% Code book
cb = [];
for d = 0:N-1
    b1_delay = circshift(b1,d);
    cbs = xor(b,b1_delay);
    cb = [cb; cbs];
end
codebook = [b ; b1 ; cb];

% Code book mapping
ind_cd_0 = find(codebook == 0);
ind_cd_1 = find(codebook == 1);
codebook_m(ind_cd_0) = 1;
codebook_m(ind_cd_1) = -1;
codebook_m1 = reshape(codebook_m,N+2,N);

% Full-period cross-correlation of base sequence S1
% with the remaining 32 sequences.
S1 = codebook_m1(1,:);
all_cc = [];
for m = 2:N+2
    cc_2 = sum(S1.*codebook_m1(m,:))/N;
    all_cc = [all_cc cc_2]
end

figure('Name','Q6 Result','NumberTitle','off');
m = 2:N+2
plot(m,all_cc);
xlabel('Sequence Sj, j=2,...,33');
ylabel('Cross-correlation');

% l=4. The (l+2)th sequence and the (l+19)th sequence
cc_l4 = [];
for n = -31:31
    S23_shift = circshift(codebook_m1(23,:),n);
    cc_3 = sum(codebook_m1(6,:).*S23_shift)/N;
    cc_l4 = [cc_l4 cc_3];
end

figure('Name','Q7 Result','NumberTitle','off');
n = -31:31;
plot(n,cc_l4);
xlabel('Shift k');
ylabel('Cross-correlation');