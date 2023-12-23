function [p2] = apply_homography(p1, H) 

    p2 = zeros(1, 2);
    p_prime = H * [p1'; 1];

    p2(1, 1) = p_prime(1, 1) / p_prime(3, 1);
    p2(1, 2) = p_prime(2, 1) / p_prime(3, 1);
end