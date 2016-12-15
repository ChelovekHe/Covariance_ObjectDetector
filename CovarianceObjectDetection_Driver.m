% Covariance Testing.
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%   Information Characterization and Exploitation (ICE) Lab
%   http://research2.fit.edu/ice/
%
% Date : Wednesday 27th April, 2013.
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
% -------------------------------------------------------------------------
% 
% Usage: 
% This script allows the user to train the covariance object detector and
% test it on a test image. When the script is run the training image will
% be shown and you must draw a bounding box around the target, try to keep
% only the pixels from the object of interest. Double click to finish
% selection. 
%
% Uncomment the section with the image you want to run as an example. 
% 
% After the double click, the test image will be shown and you must choose
% a search region if the variable cropSR = 1; otherwise the entire image
% will be chosen as the search region.
% 
% The number of detection boxes will show the top number of detections that
% you select. Top means the most similar in terms of distance.
%
% If you decide to experiment with features simply edit the
% computeImageFeatures function.
% -------------------------------------------------------------------------
clc; clear; close all;
addpath('.\func\');
addpath('.\imgs\');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Choose an example number to load. 
exampleNum = 3; % 1 - Snakes, 2 - cats, 3 - Ms. Universe
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch exampleNum
    case 1
        trainImageName = 'snakes.jpg'; 
        testImageName = 'snakes.jpg';
        obbox = [16, 75, 24, 14]; 
        ntdBoxes = 25; 
    case 2
        trainImageName = 'cats3.jpg'; 
        testImageName = 'cats3.jpg';
        obbox = [ 66, 394, 52, 54];
        ntdBoxes = 40; 
    otherwise 
        trainImageName = 'missUniverseTraining.jpg'; 
        testImageName = 'missUniverseTesting_3.jpg';
        obbox = [400, 23, 56, 56];
        ntdBoxes = 3; 
end    
   
% Number of top detection boxes to return. To see more objects return more
% boxes. 
% ntdBoxes = 25;  

% Load crop flag. 1 - Load a crop, 0 - User selects region. 
loadCrop = 1; 

% This is similar to a sliding window shift parameter when doing
% convolution. The more overlap the longer the image takes to scan the
% image. 
ovl = [0.75 0.75]; % Overlap as a percentage in the x and y direction.

% Load the image.
trainImage = imread(trainImageName); % First image to train. 
testImage = imread(testImageName); % Image to detect on.

if (loadCrop == 1)
    % Training the detector with a loaded crop. This returns the object 
    % covariance matrix from the crop.
    [ocm, ttlc, tbrc, obbox, ocCell] = TrainCovarianceObjectDetector_LoadCrop...
                                        (trainImage, ovl, obbox);
else
    % Training the detector. This returns the object covariance matrix from the
    % crop.
    [ocm, ttlc, tbrc, obbox, ocCell] = TrainCovarianceObjectDetector(trainImage, ovl);
end

% Crop the search region or not. Used to detect an object in a subset of
% the image.
cropSR = 0; % 1 - to crop, 0 - set to image size.
if (cropSR == 1)
    [~, srchRegBox] = imcrop(testImage);
else
    % Set to the size of im2.
    [im2h, im2w, ~] = size(testImage);
    srchRegBox = [1 1 im2w im2h];
end

% Floor is necessary because the values are used to index into matrices.
srchRegbox = floor(srchRegBox); 
                                
% Find the boxes that are contained in the search image.
[srttlc, srtbrc] = findAllBoxesForSR(ttlc, tbrc, srchRegBox);

[~, detBoxes, detDists]= detectObject(testImage, ocm, srttlc, srtbrc, ocCell, ntdBoxes);

% Chosen detection box plotted on frame.
annFrame = insertObjectAnnotation(testImage, 'rectangle', detBoxes,...
          'Best Match' , 'TextBoxOpacity', 0.9, 'FontSize', 10,...
         'Color',[200 0 0]); 
annFrame = insertObjectAnnotation(annFrame, 'rectangle', detBoxes(2:end,:),...
          2:size(detBoxes,1), 'TextBoxOpacity', 0.9, 'FontSize', 10,...
         'Color',[200 0 200]);      

% Show training image.
fTrain = figure; movegui(fTrain, 'west');

trainImAnn = insertObjectAnnotation(trainImage, 'rectangle', obbox,...
          'Original Crop', 'TextBoxOpacity', 0.9, 'FontSize', 10,...
         'Color',[150 0 200]);
imshow(trainImAnn);

% Show test image. 
fTest = figure; movegui(fTest, 'east');
imshow(annFrame);


