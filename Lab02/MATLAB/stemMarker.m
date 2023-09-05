function stemMarker(ind, arr, s)
%  stem set
%  s: title name
    stem(arr)
    title(s)
    xlabel('time')
    ylabel('value')
    N = length(arr);
    for k = 1 : N
        if mod(k,2) == 0
            delta = 2;
        else
            delta = -2;
        end
        text(k, arr(1,k)-delta, ['[', int2str(arr(k)), ',' , int2str(ind(k)), ']'])
    end
end