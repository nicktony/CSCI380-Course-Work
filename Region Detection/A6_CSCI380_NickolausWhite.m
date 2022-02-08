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
I = imread('TestImage.jpg');
I = imbinarize(I,'global'); % Convert to binary image
I = im2double(I); % Convert to double for editable pixel values

% Main call to region detector functions
%--------------------------------------------------------------------
I = RegionLabeling(I);

% Display implemented algorithm
%--------------------------------------------------------------------
fprintf('%s\n','Algorithm: I decided to implement the recursive flood fill function alongside', ...
'the region labeling from the textbook and modified the recursion to test diagonals.');
fprintf('%s\n','');

% Display matrix with identified blobs
%--------------------------------------------------------------------
fprintf('%s\n','Matrix with identified blobs:');
disp(I); % Output binary image matrix to console

% Display number of blobs
%--------------------------------------------------------------------
numOfBlobs = max(I(:));
fprintf('%s','Number of blobs detected in image: ');
fprintf('%d\n\n',numOfBlobs - 1); % Subtract 1 becuase blobs start at 2

% Display blobs
%--------------------------------------------------------------------
figure('NumberTitle', 'off', 'Name', 'Figure 1: Blobs Identified in Binary Image');
for i = 2:numOfBlobs
    % Apply thresholds to blob matrix
    Itemp = I;
    Itemp(Itemp>i) = 0;
    Itemp(Itemp<i) = 0;
    Itemp = imbinarize(Itemp,'global'); % Convert to binary image
    
    % Crop blob matrix
    [rows, columns] = find(Itemp);
    row1 = min(rows) - 1;
    row2 = max(rows) + 1;
    col1 = min(columns) - 1;
    col2 = max(columns) + 1;
    Itemp = Itemp(row1:row2, col1:col2); % Crop image.
    
    % Plot blob
    subplot(numOfBlobs,1,i);
    imshow(Itemp);
    title('');
    
    % Output area of blobs
    areaOfBlob = bwarea(Itemp);
    fprintf('%s','Area of blob(identifier = ');
    fprintf('%d',i);
    fprintf('%s','): ');
    fprintf('%d\n',areaOfBlob);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Region Labeling Function
%--------------------------------------------------------------------
function I = RegionLabeling(I)
height = size(I, 1);
width = size(I, 2);
label = 2; 

for u = 1:height
 for v = 1:width
    if (I(u,v) == 1)
        I = FloodFill(I, u, v, label);
        label = label + 1;
    end
 end
end

end

% FloodFill Function (Recursive)
%--------------------------------------------------------------------
function I = FloodFill(I, u, v, label)
height = size(I, 1);
width = size(I, 2);

if (u <= height && u >= 1 && v <= width && v >= 0 && I(u,v) == 1)
    I(u,v) = label;
    
    % Four Directions
    I = FloodFill(I, u+1, v, label);
    I = FloodFill(I, u, v+1, label);
    I = FloodFill(I, u, v-1, label);
    I = FloodFill(I, u-1, v, label);
    
    % Diagonals (added this in to indentify the diagonal blob)
    I = FloodFill(I, u+1, v+1, label);
    I = FloodFill(I, u+1, v-1, label);
    I = FloodFill(I, u-1, v+1, label);
    I = FloodFill(I, u-1, v-1, label);
end

end




