function [I1, Q1, phase_out] = cordic_vectoring_first(I, Q)
    % CORDIC first stage
    %  second or third
    if I < 0
        I1 = -I;
        Q1 = -Q;
        phase_out = pi;
    else
        I1 = I;
        Q1 = Q;
        phase_out = 0;
    end
end