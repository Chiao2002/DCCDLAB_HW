clear;clc;
load R;
r = R;
data_in = [r;1:24];
N = length(r);

%% Q1
% Serial comparator
reg_min = [10;10];
for n = 1 : N
    if data_in(1,n) < reg_min(1,n)
        reg_min(:,n+1) = data_in(:,n);
    else
        reg_min(:,n+1) = reg_min(:,n);
    end
end
reg_min(:,1) = [];

% figure
figure(1);
stemMarker(data_in(2,:), data_in(1,:), 'Random data');
saveas(gcf,'./pic/q1_1.png')

figure(2);
stemMarker(reg_min(2,:), reg_min(1,:), 'Serial comparator data');
saveas(gcf,'./pic/q1_2.png')
close all
pause(1)


%% Q2
% Parallel comparison
for i = 1 : 12
    reg2_min(1:2,i) = paral_comp(data_in(:,i*2-1),data_in(:,i*2));
end
for i = 1 : 6
    reg2_min(3:4,i) = paral_comp(reg2_min(1:2,i*2-1),reg2_min(1:2,i*2));
end
for i = 1 : 3
    reg2_min(5:6,i) = paral_comp(reg2_min(3:4,i*2-1),reg2_min(3:4,i*2));
end
reg2_min(7:8,1) = paral_comp(reg2_min(5:6,1),reg2_min(5:6,2));
reg2_min(9:10,1) = paral_comp(reg2_min(7:8,1),reg2_min(5:6,3));

% figure
figure(3)
stemMarker(reg2_min(2,:), reg2_min(1,:), 'layer 1');
saveas(gcf,'./pic/q2_1.png')
figure(4)
stemMarker(reg2_min(4,:), reg2_min(3,:), 'layer 2');
saveas(gcf,'./pic/q2_2.png')
figure(5)
stemMarker(reg2_min(6,:), reg2_min(5,:), 'layer 3');
saveas(gcf,'./pic/q2_3.png')
figure(6)
stemMarker(reg2_min(8,:), reg2_min(7,:), 'layer 4');
saveas(gcf,'./pic/q2_4.png')
figure(7)
stemMarker(reg2_min(10,:), reg2_min(9,:), 'layer 5');
saveas(gcf,'./pic/q2_5.png')
close all
pause(1)


%% Q4
G1 = sort4(data_in(:,1), data_in(:,2), data_in(:,3), data_in(:,4));
% figure: inputs of sort4
figure(8)
stemMarker(data_in(2,1:4), data_in(1,1:4), 'Input of sort4');
saveas(gcf,'./pic/q4_1.png')

% figure: outputs of sort4
figure(9)
stemMarker(G1(2,:), G1(1,:), 'Output of sort4');
saveas(gcf,'./pic/q4_2.png')
close all
pause(1)


%% Q5
M = 8;
sort_out = mergeSort(data_in);
[~, ind] = sort(r);
matlab_sort = data_in(:,ind); 

figure(10)
stemMarker(sort_out(2,1:M), sort_out(1,1:M), 'SelectTop8');
saveas(gcf,'./pic/q5_1.png')

figure(11)
stem(matlab_sort(1,:))
title('Matlab Sort')
xlabel('time')
ylabel('value')
    for k = 1 : N
        if mod(k,2) == 0
            delta = 4;
        else
            delta = -4;
        end
        text(k-1, matlab_sort(1,k)+delta, ['[', int2str(matlab_sort(2,k)), ',' , int2str(matlab_sort(1,k)), ']'])
    end
saveas(gcf,'./pic/q5_2.png')

figure
plot(sort_out(1,:), 'b-', 'LineWidth', 1)
title('Sorted array Comparison')
xlabel('time')
ylabel('value')
hold on
plot(matlab_sort(1,:), 'r--', 'LineWidth', 1)
legend('my solution', 'matlab solution')
hold off
saveas(gcf,'./pic/q5_3.png')
close all
pause(1)
