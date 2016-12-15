% Covariance Object detection on a video.
%
%   This driver file allows the user to imput a video and track and object
%   throughout that video. When the video is first loaded, the user will be
%   prompted to crop the region of interest. For the example video, do a
%   tight crop of the car to get the best detection. 
%
% Function list. If you want to edit a function just click on the function
% and press ctrl+d and the function will open. Instead of looking for them
% all over the place.
%
% computeImageFeatures
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%   Information Characterization and Exploitation (ICE) Lab
%   http://research2.fit.edu/ice/
%
% Date : Wednesday 20th March, 2013.
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
% -------------------------------------------------------------------------
clc; clear; close all;

% Load the video. 
vidName = 'flight2tape2_8';
vidExt = '.avi';
vidFold = '.\video\';
testNum = 1; % Test number for naming videos.
loadCrop = 1; % 1 - Crop is loaded, 0 - User interactively defines crop.
obbox = [420, 217, 48, 30];

% Set up video writer.
vidObj = VideoWriter([vidFold, vidName, 'DetectionTest', num2str(testNum)]);

% Video reader object set for RGB.
vfrRGB = vision.VideoFileReader([vidFold, vidName, vidExt],...
                                    'VideoOutputDataType', 'uint8');

% Step the first frame.
firstFrame = step(vfrRGB);

% Compute the covariance matrices of the object.
ovl = [0.75 0.75]; % Overlap as a percentage in the x and y direction.

if (loadCrop == 1)
    % Training the detector with a loaded crop. This returns the object 
    % covariance matrix from the crop.
    [ocm, ttlc, tbrc, obbox, ocCell] = TrainCovarianceObjectDetector_LoadCrop...
                                        (firstFrame, ovl, obbox);
else
    % Training the detector. This returns the object covariance matrix from the
    % crop.
    [ocm, ttlc, tbrc, obbox, ocCell] = TrainCovarianceObjectDetector(...
                                            firstFrame, ovl);
end

% reset(vfrRGB); % Reset the video player.
open(vidObj);
k = 0;
ntdBoxes = 5; % Number of top boxes to return.

% Loop through the video frames.
while (~isDone(vfrRGB))
    k = k + 1;
    cFrame = step(vfrRGB); % Current frame. 
    
    % Detect object. 
    [~, detBoxes, detDists]= detectObject(cFrame, ocm, ttlc, tbrc, ocCell, ntdBoxes);
   
    % Chosen detection box plotted on frame.
    annFrame = insertObjectAnnotation(cFrame, 'rectangle', detBoxes,...
              1:size(detBoxes,1), 'TextBoxOpacity', 0.9, 'FontSize', 10,...
             'Color',[200 0 200]); 
             
    imshow(annFrame);
         
    % Write each frame to the file.
    currentFrame = getframe;
    writeVideo(vidObj,currentFrame);
end

close(vidObj);

