function [centers] = detectCircles(im, edges, radius, top_k)

    im = rgb2gray(im);

    quantization_value = 5;

    % initialize hough space bins 
    [h, w] = size(im);
    h_bin = ceil(h/quantization_value);
    w_bin = ceil(w/quantization_value);
    H = zeros(w_bin, h_bin);

    % initialize center matrix
    centers = [];

    % hough transform for circles
    num_edges = length(edges);
    for i = 1:num_edges
        % calculate column and row of hough space
        a = edges(i, 1) - radius * cos(deg2rad(edges(i, 4)));
        b = edges(i, 2) - radius * sin(deg2rad(edges(i, 4)));
        % append a new center (a,b)
        new_center = [a, b];
        % obtain bin indices of a and b
        a_bin = ceil(a/quantization_value);
        b_bin = ceil(b/quantization_value);
        % add vote for according bin
        if (0 < a_bin) && (a_bin <= w_bin) && (0 < b_bin) && (b_bin <= h_bin) 
            H(a_bin, b_bin) = H(a_bin, b_bin) + 1;
        end
    end
    
    % obtain bins with top_k highest votes
    [votes, lin_indices] = maxk(H(:), top_k);
    [row_indices, col_indices] = ind2sub(size(H), lin_indices);
    centers = [row_indices * quantization_value - quantization_value/2, col_indices * quantization_value - quantization_value/2];

    % visualize circles
    figure; imshow(im); viscircles(centers, radius * ones(size(centers, 1), 1));
end
