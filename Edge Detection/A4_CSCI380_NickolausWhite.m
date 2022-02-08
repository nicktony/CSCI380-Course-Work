% % % % % % % % % % % % % % % % % % %
% Nickolaus White (CSCI380)
% % % % % % % % % % % % % % % % % % %


% Close command window, workspace, and all figure pop-ups
%--------------------------------------------------------------------
clc
clear all
close all

% Load in image (differs based on your file location)
%--------------------------------------------------------------------
image = imread('TestImage.jpg');
BWimage = rgb2gray(image); % Convert image to grayscale

% Create x and y gradient filters (Sobel)
%--------------------------------------------------------------------
Sx = [1 0 -1; 2 0 -2; 1 0 -1];
Sy = [1 2 1; 0 0 0; -1 -2 -1];

% Convert images to double and convolve
%--------------------------------------------------------------------
sobelXImage = conv2(double(BWimage), Sx, 'same');
sobelYImage = conv2(double(BWimage), Sy, 'same');

% Display original and x/y gradient filtered images
%--------------------------------------------------------------------
figure('NumberTitle', 'off', 'Name', 'Figure 1: Original Image and Gradients');

subplot(1,3,1);
imshow(BWimage)
title('Original Image');

subplot(1,3,2);
imshow(uint8(sobelXImage));
title('X Gradient');

subplot(1,3,3);
imshow(uint8(sobelYImage));
title('Y Gradient');

% Calculate magnitude of gradients
%--------------------------------------------------------------------
edgeDetectedImage = sqrt(sobelXImage.*sobelXImage + sobelYImage.*sobelYImage);

% Create images with thresholds
%--------------------------------------------------------------------
threshold = 50;
edgeDetectedImage1 = (uint8(edgeDetectedImage) > threshold) * 255;

threshold = 100;
edgeDetectedImage2 = (uint8(edgeDetectedImage) > threshold) * 255;

threshold = 150;
edgeDetectedImage3 = (uint8(edgeDetectedImage) > threshold) * 255;

threshold = 200;
edgeDetectedImage4 = (uint8(edgeDetectedImage) > threshold) * 255;

% Display thresholded images
%--------------------------------------------------------------------
figure('NumberTitle', 'off', 'Name', 'Figure 2: 50 Threshold');
imshow(edgeDetectedImage1)
title('50 Threshold');

figure('NumberTitle', 'off', 'Name', 'Figure 3: 100 Threshold');
imshow(edgeDetectedImage2)
title('100 Threshold');

figure('NumberTitle', 'off', 'Name', 'Figure 4: 150 Threshold');
imshow(edgeDetectedImage3)
title('150 Threshold');

figure('NumberTitle', 'off', 'Name', 'Figure 5: 200 Threshold');
imshow(edgeDetectedImage4)
title('200 Threshold')





