% % % % % % % % % % % % % % % % % % %
% Nickolaus White (CSCI380)
% % % % % % % % % % % % % % % % % % %


% Close command window, workspace, and all figure pop-ups
%--------------------------------------------------------------------
clc
clear all
close all

% Load in sample image
%--------------------------------------------------------------------
img0 = imread('cameraman.tif'); % main image
imgd = im2double(img0); % image in double precision

% 1. Define smoothing kernals
%--------------------------------------------------------------------
smoothingFilter3x3 = ones(3,3)/9; % 3x3 smoothing kernal
smoothingFilter7x7 = ones(7,7)/49; % 7x7 smoothing kernal

% 2. Filter images
%--------------------------------------------------------------------
img1 = filter2(smoothingFilter3x3, imgd);
img2 = filter2(smoothingFilter7x7, imgd);

% 3. Output filtered images
%--------------------------------------------------------------------
figure('NumberTitle', 'off', 'Name', 'Figure 1: Computer Vision Lab - Filters');

subplot(1,3,1);
imshow(img0);
title('Original Image');

subplot(1,3,2);
imshow(img1);
title('3x3 Smoothing Kernal');

subplot(1,3,3);
imshow(img2);
title('7x7 Smoothing Kernal');

% 4. Answers to lab questions
%--------------------------------------------------------------------

% Question 1 Answer
fprintf('%s\n','1.) Using an inverse filter or wiener filter you can reverse the convolution of an image. ', ...
'In MatLab you can utilize the deconvwnr function which uses a built-in wiener filter.');

% Example of deconvolution
PSF = fspecial('motion',50,10); % Linear motion across 50 pixels at 10 degrees
imgBlurred = imfilter(imgd,PSF,'conv','circular');
imgRestored = deconvwnr(imgBlurred,PSF); % Restore image based on previous filter values

figure('NumberTitle', 'off', 'Name', 'Figure 2: End of Lab Example 1');

subplot(1,3,1);
imshow(imgd);
title('Orginal');

subplot(1,3,2);
imshow(imgBlurred);
title('Convolution w/ Motion');

subplot(1,3,3);
imshow(imgRestored);
title('Deconvolution');

% Space
fprintf('%s\n','----------------------------------------------------------------------------------------------------------------');

% Question 2 Answer
fprintf('%s\n','2.) Taking the same concept of convolution, running through each and every weighted pixel', ...
'within a kernal matrix, shifting all pixels to the left would result from filtering using the matrix [0,0,0; 1,0,0; 0,0,0].', ...
'This will shift the image left by 1 pixel.'); 
% It looks like the image is shifted right in the example below, but in the example from 
% https://ai.stanford.edu/~syyeung/cvweb/tutorial1.html[0,0,0; 0,0,1;
% 0,0,0] represents shifting right by 1 pixel.

% Example of shifting left by 1 pixel
FilterShiftLeft = [0,0,0; 1,0,0; 0,0,0];
imgShiftLeft = filter2(FilterShiftLeft, imgd);
imshow(imgShiftLeft)

figure('NumberTitle', 'off', 'Name', 'Firgure 3: End of Lab Example 2');

subplot(1,2,1);
imshow(imgd);
title('Orginal');

subplot(1,2,2);
imshow(imgShiftLeft);
title('Image Shifted Left');




