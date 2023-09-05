%  Generate a random sequence with 24 elements between -32 and 31.
R = randi([-32,31],1,24);
save('R.mat','R');