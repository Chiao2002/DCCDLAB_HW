function [I_out, Q_out, phase_out] = cordic_vectoring_stage_fixed(I, Q, phase_in, WL, stage_i)
    phase_element = round(atan(2^(-stage_i)) * 2^(WL-4)) / 2^(WL-4);
    Ki = -sign(Q);  % Ki = 1(anti-clockwise), Ki = -1(clockwise)
    I_out = I - Ki * 2^(-stage_i) * Q;
    Q_out = Ki * 2^(-stage_i) * I + Q;
    % phase accumulation
    phase_out = phase_in - Ki * phase_element;

end