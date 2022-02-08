% % % % % % % % % % % % % % % % % % %
% Nickolaus White (CSCI380)
% % % % % % % % % % % % % % % % % % %


% Close command window, workspace, and all figure pop-ups
%--------------------------------------------------------------------
clc
clear all
close all

% Create directories for images (differs based on your file location)
%--------------------------------------------------------------------
if ~exist('./Images', 'dir')
    mkdir Images
end
if ~exist('./modifiedImages', 'dir')
    mkdir modifiedImages
end

% Load in video (differs based on your file location)
%--------------------------------------------------------------------
filename_mp4 = fullfile('baseball.mp4');

% Seperate video into images (run only once)
%--------------------------------------------------------------------
if ~exist('Images/bwImage1.jpg', 'file')
    % Load in images from video frames
    mov = VideoReader(filename_mp4);
    for i=1:mov.NumFrames
     img = read(mov,i);
     bwImage = rgb2gray(img);
     outputFileName = sprintf('Images/bwImage%d.jpg',i);
     imwrite(bwImage, outputFileName, 'jpg');
    end
end

% Grab size of image, create 1080x1920x10 matrix
%--------------------------------------------------------------------
bwImage = imread('Images/bwImage1.jpg');
[verticalP, horizontalP, ~] = size(bwImage); % 3rd dimension is ignored
avgPixels = zeros(verticalP, horizontalP, 10);

% Read first 10 images and calculate the average pixels
%-------------------------------------------------------------------- 
for i = 1:10
  nextImage = imread("Images/bwImage" + i + ".jpg");
  avgPixels(:,:,i) = nextImage;
end

% Loop through images
%--------------------------------------------------------------------
numOfFrames = 360; % Number taken from assignment directions
for i = 1:numOfFrames
    % Update current image path
    filename_jpg = "Images/bwImage" + i + ".jpg";
    currentImage = imread(filename_jpg);
    currentImage = double(currentImage); % Convert to double to modify pixel values
    tempImage = currentImage; % Create a temp image
    
    % Calculate pixel difference
    avg = sum(avgPixels,3) / 10;
    pixelDifference = abs(avg - tempImage);
    
    % Apply thresholds
    tempImage(pixelDifference>20) = 255;
    tempImage(pixelDifference<20) = 0;
    
    % Upload current image
    outputFileName = sprintf('modifiedImages/bwImage%d.jpg',i);
    imwrite(tempImage, outputFileName, 'jpg');
    
    % Update list of 10 images, shift and replace oldest image
    avgPixelsTemp(:,:,1) = currentImage;
    for j = 2:10
     avgPixelsTemp(:,:,j) = avgPixels(:,:,j-1);
    end
    avgPixels = avgPixelsTemp;
end

% Create video from modified images
%--------------------------------------------------------------------
mov = VideoReader('baseball.mp4');
totalImages = 360; % Number taken from assignment directions
videoFrameRate = mov.FrameRate;
videoHeight = mov.Height;
videoWidth = mov.Width;
outputVideo = VideoWriter('baseballModified.avi');
outputVideo.FrameRate = videoFrameRate;
open(outputVideo);

for i=11:totalImages
 outputFileName = sprintf('modifiedImages\\bwImage%d.jpg', i);
 myImage = imread(outputFileName);
 writeVideo(outputVideo, myImage);
end
close(outputVideo);

% End of program
%--------------------------------------------------------------------
fprintf('Code Compiled, Check Folder For Modified .avi File.\n\n');




