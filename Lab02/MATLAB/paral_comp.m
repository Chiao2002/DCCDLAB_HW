function [min, max] = paral_comp(A,B)
%  Parallel comparator
if A(1,1) < B(1,1)
    flag = 1;
else
    flag = 0;
end
if flag == 1
    min = A;
    max = B;
else
    min = B;
    max = A;
end