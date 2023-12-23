function [energyImage, Ix, Iy] = energy_image(im, Ix_kernel, Iy_kernel)
% convert the image to greyscale by rgb2gray 
I = rgb2gray(im);
% change type of the grayscale image I to double 
I = double(I);
% compute Ix and Iy - gradients in x and y directions
Ix = conv2(I, Ix_kernel, 'same');
Iy = conv2(I, Iy_kernel, 'same');
% compute energyImage using L2 norm
energyImage = sqrt(Ix.^2 + Iy.^2);




