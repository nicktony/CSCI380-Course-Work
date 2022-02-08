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
imageO = imread('Penguins.jpg');

% Alter image
%--------------------------------------------------------------------
image = rgb2gray(imageO); % Convert to grayscale
image = double(image); % Convert to double

% Create x & y dervivative filters
%--------------------------------------------------------------------
dxFilter = [-1 0 -1; -1 0 1; -1 0 1];
dyFilter = dxFilter'; 

% Create x & y dervivative images
%--------------------------------------------------------------------
myImageDerivativeX = conv2(image, dxFilter, 'same');
myImageDerivativeY = conv2(image, dyFilter, 'same');

% Calculate A, B, & C
%--------------------------------------------------------------------
A = myImageDerivativeX .^2;
B = myImageDerivativeY .^2;
C = myImageDerivativeX .* myImageDerivativeY;

% Apply gaussian filter
%--------------------------------------------------------------------
gaussianFilter = fspecial('gaussian');

smoothedA = conv2(A, gaussianFilter, 'same');
smoothedB = conv2(B, gaussianFilter, 'same');
smoothedC = conv2(C, gaussianFilter, 'same');

% Compute corner response function
%--------------------------------------------------------------------
alpha = 0.04;
cornerResponseFunction = (smoothedA .* smoothedB - smoothedC.^2) ...
    - alpha * (smoothedA + smoothedB).^2;

% Loop through matrix & check for valid corners
%--------------------------------------------------------------------
threshold = 200000;
totalCorners = 0;
height = size(cornerResponseFunction, 1);
width = size(cornerResponseFunction, 2);

for u = 1:height
 for v = 1:width
    if (cornerResponseFunction(u, v) > threshold && isLocalMax(cornerResponseFunction, u, v))
        totalCorners = totalCorners + 1; %increment totalCorners
        
        % Add corner to list
        cornerList(totalCorners).x = v;
        cornerList(totalCorners).y = u;
        cornerList(totalCorners).q = cornerResponseFunction(u,v);
    end
 end
end

% Output total valid corners
fprintf('%s','Total number of valid corners: ');
fprintf('%d\n',totalCorners);
 
% Sort list of corners based on q values descending
%--------------------------------------------------------------------
T = struct2table(cornerList); %convert struct to table
sortedT = sortrows(T, 'q', 'descend'); %sort table descending by q
cornerListSorted = table2struct(sortedT); %convert back to struct

% Step through corners and remove ones that are too close
%--------------------------------------------------------------------
goodCorners = [];
minDistance = 10;

%I've redone this section to better represent the book. This will loop
%through each corner, calculate the distance between the points, and then
%compare the distance to the minimum distance. For some reason my q was not
%giving the correct results so I attempted to redisign the algorithm.
while(size(cornerListSorted,1) > 1)
 cl = cornerListSorted(1);
 cornerListSorted = cornerListSorted(2:end);
 
 goodCorners = [goodCorners cl];
 
 cornersToRemove = [];
 
 for i = 1:size(cornerListSorted,1)
    % Calculate the distance between corners
    tempx = cornerListSorted(i).x;
    tempy = cornerListSorted(i).y;
    distance = sqrt((cl.x - tempx).^2 + (cl.y - tempy).^2);
    
    % Compare distance to minimum
    if(distance < minDistance)
        cornersToRemove = [cornersToRemove i];
    end
 end
 cornerListSorted(cornersToRemove) = []; %remove the corners that are too close
end

% Output total valid corners
fprintf('%s','Total number of good corners: ');
fprintf('%d\n',size(goodCorners, 2));

% Mark good corners, display original image w/ marked corners
%--------------------------------------------------------------------
imshow(imageO);
title('Harris Corner Detection');
hold on
for i = 1:size(goodCorners, 2)
    plot(goodCorners(i).x,goodCorners(i).y,'g+');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Corner response function
%--------------------------------------------------------------------
function [myBool] = isLocalMax(harrisMatrix, u, v)
 height = size(harrisMatrix, 1);
 width = size(harrisMatrix, 2);

 if(u <= 1 || u >= height || v <= 1 || v >= width)
    myBool = false;
 else
    pix = reshape(harrisMatrix, height*width, 1); %return the image as a 1 dimensional array
    i0 = (v-1)*height+u;
    i1 = v*height+u;
    i2 = (v+1)*height+u;

    cp = pix(i1);

    myBool = (cp > pix(i0-1) && cp > pix(i0) && cp > pix(i0+1) ...
        && cp > pix(i1-1) && cp > pix(i1+1) && cp > pix(i2-1) ...
        && cp > pix(i2) && cp > pix(i2+1));
 end
end




