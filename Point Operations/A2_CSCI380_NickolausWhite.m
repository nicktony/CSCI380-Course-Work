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
downloadFolder = "C:\Users\white\Desktop";
filename = fullfile(downloadFolder,"JetSkiAir.jpg");
image = imread(filename);
BWimage = rgb2gray(image);

% Increase brightness of image
%--------------------------------------------------------------------
modifiedImage = image + 30;
brightImage = image + 30;

% Invert image color
%--------------------------------------------------------------------
modifiedImage = imcomplement(modifiedImage); 
invertedImage = imcomplement(image); 

% Convert image to grayscale
%--------------------------------------------------------------------
modifiedImage = rgb2gray(modifiedImage);
grayscaleImage = rgb2gray(image);

% Threshold image based on integer value
%--------------------------------------------------------------------
modifiedImage = zeros(size(modifiedImage));
modifiedImage(modifiedImage < 64) = 255; % Will white-out the image

thresholdImage = zeros(size(grayscaleImage));
thresholdImage(grayscaleImage < 64) = 255;

% Display image changes
%--------------------------------------------------------------------
figure('NumberTitle', 'off', 'Name', 'Figure 1: Part One, Point Operations');

subplot(2,3,1);
imshow(image)
title('Original Image')

subplot(2,3,2);
imshow(brightImage)
title('Increased Brightness by 30')

subplot(2,3,3);
imshow(invertedImage)
title('Inverted Image')

subplot(2,3,4);
imshow(grayscaleImage)
title('Grayscale Image')

subplot(2,3,5);
imshow(thresholdImage)
title('Threshold = 64')

subplot(2,3,6);
imshow(modifiedImage)
title('Everything Combined')

% Auto-contrast image
%--------------------------------------------------------------------
figure('NumberTitle', 'off', 'Name', 'Figure 2: Part Two, nwhite26 Auto Contrast');

image = autocontrast(image); % Call to function
imshow(image), title('Auto-Contrast Image');


% % % % % % % % % % % % % % % % % % %
% Functions
% % % % % % % % % % % % % % % % % % %
function autoContrast = autocontrast(image)
    autoContrast = imadjust(image,[0.2 0.8]); 
end




