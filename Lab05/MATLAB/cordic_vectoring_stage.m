function [I_out, Q_out, phase_out] = cordic_vectoring_stage(I, Q, phase_in, stage_i)
    phase_element = atan(2^(-stage_i));
    Ki = -sign(Q);  % Ki = 1(anti-clockwise), Ki = -1(clockwise)
    I_out = I - Ki * 2^(-stage_i) * Q;
    Q_out = Ki * 2^(-stage_i) * I + Q;
    % phase accumulation
    phase_out = phase_in - Ki * phase_element;

end