function H = estimate_homography(PA, PB)

    [N, t] = size(PA);
    
    % initialize matrix A
    A = zeros(2*N, 9);

    % setting system of equations A
    for i = 1:N
        x = PA(i, 1);
        y = PA(i, 2);
        x_prime = PB(i, 1);
        y_prime = PB(i, 2);
        A(2*i-1, :) = [-x, -y, -1, 0, 0, 0, x*x_prime, y*x_prime, x_prime];
        A(2*i, :) = [0, 0, 0, -x, -y, -1, x*y_prime, y*y_prime, y_prime];
    end

    [~, ~, V] = svd(A); 
    h = V(:, end); 
    H = reshape(h, 3, 3)';
end