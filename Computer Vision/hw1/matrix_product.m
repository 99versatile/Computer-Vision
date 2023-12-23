function [C] = matrix_product(A, B)
    [rows_A, cols_A] = size(A);
    [rows_B, cols_B] = size(B);
    
    if cols_A ~= rows_B
        error('Dimension mismatch: cols_A and rows_B should be an identical value.');
    end

    C = zeros(rows_A, cols_B);

    for i = 1:rows_A
        for j = 1:cols_B
            el = 0;
            
            for k = 1:cols_A
                el = el + A(i, k) * B(k, j);
            end

            C(i, j) = el;
        end
    end
end
