function [x, y, scores, Ih, Iv] = extract_keypoints(image)
%% extract_keypoints
% input:
%   image: colored image. Not grayscale or double yet.
% output:
%   x: n x 1 vector of x (col) locations that survive non-maximum suppression. 
%   y: n x 1 vector of y (row) locations that survive non-maximum suppression.
%   scores: n x 1 vector of R scores of the keypoints correponding to (x,y).
%   Ih: x- (horizontal) gradient. Also appeared as Ix in the slides.
%   Iv: y- (vertical) gradient. Also appeared as Iy in the slides.

% The kernels are provided, but you can try other kernels.
Ih_kernel = [1 0 -1; ...
             2 0 -2; ...
             1 0 -1];
Iv_kernel = Ih_kernel';

%% [10 pts] Part A: Setup (Implement yourself)
% set parameters
k = 0.05;
window_size = 5;
half_window_size = 2;

% convert image
image_gray = rgb2gray(image);
image_gray_doubled = double(image_gray);

% compute gradients
Ih = imfilter(image_gray_doubled, Ih_kernel);
Iv = imfilter(image_gray_doubled, Iv_kernel);

% initialize R matrix - size identical to image size
[h, w] = size(image_gray_doubled);
R = zeros(h, w);

%% [15 pts] Part B: R score matrix (Implement yourself)


% compute R score for each pixel
for i = 1:h
    for j = 1:w

        % initialize M
        M = zeros(2, 2);
        
        % compute M matrix
        if ~(i <= 2) && ~(i >= h-2) && ~(j <= 2) && ~(j >= w-2)
            for ir = i-half_window_size:i+half_window_size
                for jc = j-half_window_size:j+half_window_size
                    % assign M matrix values
                    M(1, 1) = M(1, 1) + Ih(ir, jc).^2;
                    M(1, 2) = M(1, 2) + Ih(ir, jc)*Iv(ir, jc);
                    M(2, 1) = M(2, 1) + Ih(ir, jc)*Iv(ir, jc);
                    M(2, 2) = M(2, 2) + Iv(ir, jc).^2;
                end
            end
        end
                
        % compute R score by M matrix
        if (i <= 2) || (i >= h-2) || (j <= 2) || (j >= w-2)
            R(i, j) = -inf;
        else 
            R(i, j) = det(M) - k * (trace(M).^2);
        end
    end
end


%% Part C: Thresholding R scores (Provided to you, do not modify)
% Threshold standards is arbitrary, but for this assignment, I set the 
% value of the 1th percentile R as the threshold. So we only keep the
% largest 1% of the R scores (that are not -Inf) and their locations.
R_non_inf = R(~isinf(R));
top_R = sort(R_non_inf(:), 'descend');
R_threshold = top_R(round(length(top_R)*0.01));
R(R < R_threshold) = -Inf;

%% [15 pts] Part D: Non-maximum Suppression (Implement yourself)
% initialize the desired outputs
scores = [];
x = [];
y = [];

for i = 1:h
    for j = 1:w
        R_value = R(i, j);
        if R_value ~= -inf
            % extract neighbors
            if (i <= 2) || (i >= h-2) || (j <= 2) || (j >= w-2)
                R(i, j) = -inf;
            else
                neighbors = R(i-1:i+1, j-1:j+1);

                if R_value == max(neighbors(:))
                    scores = [scores, R_value];
                    x = [x, j];
                    y = [y, i];
                    R(i-1:i+1, j-1:j+1) = -inf;
                    R(i, j) = R_value;
                end
            end
        end
    end
end


