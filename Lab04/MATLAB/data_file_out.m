%% reset signal data
rst = zeros(1,246);
rst(1,2) = 1;

file_name = 'rst2fpga.txt';
fid = fopen('rst2fpga.txt','w');
fprintf(fid, '%d \n', rst);
fclose(fid);

%% mu value data
mu = [0 1/6 2/6 3/6 4/6 5/6];
mu_q = floor(mu*2^11);

file_name = 'mu2fpga.txt';
fid = fopen('mu2fpga.txt','w');
for k = 1 : 41
    fprintf(fid, '%d \n', mu_q);
end
fclose(fid);

