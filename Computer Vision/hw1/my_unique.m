function [N] = my_unique(M)
    m = size(M, 1);
    N = M(1, :); 

    for i = 2:m
        row_duplicate_tf = false;
        n = size(N, 1);

        for j = 1:n
            if isequal(M(i, :), N(j, :))
                row_duplicate_tf = true;
                break;
            end
        end

        if ~row_duplicate_tf
            N = [N; M(i, :)];
        end
    end
end
