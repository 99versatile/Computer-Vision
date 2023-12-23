function [outputImg, meanColors, clusterIds] = quantizeRGB(origImg, k)
    [h, w, ~] = size(origImg);
    outputImg = zeros(h, w, 3);
    numpixels = h*w;
    % reshape the original image
    X = reshape(origImg, [numpixels, 3]);
    X = double(X);
    % apply kmeans function
    [clusterIds, meanColors] = kmeans(X, k);
    
    % disp(clusterIds);
    
    for i = 1: numpixels
        [row_index, col_index] = ind2sub([h, w], i);
        outputImg(row_index, col_index, :) = meanColors(clusterIds(i), :)/255;
    end
end
