function x = mergeSort(x)
    n = int32(length(x)/4);
    if n > 1
        L = x(:, 1:int32(n/2)*4);
        R = x(:, int32(n/2)*4+1:end);
        x = merge(mergeSort(L), mergeSort(R));
    else
        x = sort4(x(:,1), x(:,2), x(:,3), x(:,4));
    end
end

function y = merge(L, R)
    y = [];
    while ~isempty(L) && ~isempty(R)
        if L(1,1) > R(1,1)
            y(:, end+1) = R(:,1);
            R(:,1) = [];
        else
            y(:, end+1) = L(:, 1);
            L(:, 1) = [];
        end
    end
    y = [y, L, R];
end