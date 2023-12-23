% keble
img1 = imread('keble1.png');
img2 = imread('keble2.png');
 
save_filename = 'keble_mosaic.png';

% keble1
PA = [165, 78; ...
      154, 186; ...
      327, 106; ...
       354, 170; ...
       340, 14; ...
       271, 43];
% keble2
PB = [68, 88; ...
      55, 198; ...
      229, 123; ...
      252, 186; ...
      243, 34; ...
      177, 57];

% % uttower
% % your image example
% img1 = imread('uttower1.jpeg');
% img2 = imread('uttower2.jpeg');
% 
% save_filename = 'uttower_mosaic.png';
% 
% % uttower1
% PA = [481, 310; 328, 510; 106, 507; 108, 619; 56, 176; 129, 483; 526, 537; 375, 293];
% % uttower2
% PB = [928, 331; 782, 540; 569, 545; 578, 652; 505, 232; 585, 519; 998, 567; 816, 322];

%%

H = estimate_homography(PA, PB);

%%
% transform all PA to PA_transformed using the estimated homography
PA_transformed = [];
for i=1:size(PA, 1)
    p1 = PA(i,:);
    p2 = apply_homography(p1, H);
    PA_transformed = [PA_transformed; p2];
end

% If our homography H is accurate, then PA_transformed should be similar to
% PB which are the true correspondences. Check this yourself by outputting
% the values or by plotting below.
figure;
subplot(1,2,1); hold on; 
imshow(img1); plot(PA(:,1), PA(:,2), 'g.', 'MarkerSize', 20);
title('PA shown in Image 1');
subplot(1,2,2); hold on; 
imshow(img2); plot(PA_transformed(:,1), PA_transformed(:,2), 'r.', 'MarkerSize', 20);
title('PA transformed and shown in Image 2');

%%
nr = size(img2, 1);
nc = size(img2, 2);
canvas = uint8(zeros(3*nr, 3*nc, 3));
canvas(nr:2*nr-1, nc:2*nc-1, :) = img2;

for i = 1:nr
    for j = 1:nc
        p1 = [j, i];
        p2 = apply_homography(p1, H);

        r = p2(1, 2) + nr;
        c = p2(1, 1) + nc;

        canvas(ceil(r), ceil(c), :) = img1(i, j, :);
        canvas(ceil(r), floor(c), :) = img1(i, j, :);
        canvas(floor(r), ceil(c), :) = img1(i, j, :);
        canvas(floor(r), floor(c), :) = img1(i, j, :);
    end
end

imwrite(canvas, save_filename)
