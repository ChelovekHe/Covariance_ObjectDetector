% Sliding window coordinates test.
%
% This driver shows the user the size of the box generated and how it fits
% over the image. You can adjust the overlap and size parameters, to
% observe how the boxes are fitting. When the driver is run just press
% enter to see the next box appear on the plot.
%
% Author : Mark Moyou (mmoyou@my.fit.edu)
%
% Affiliation: ICE Lab, Florida Institute of Technology.
%   http://research2.fit.edu/ice/
%
% Date: 8th May, 2013.
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
% -------------------------------------------------------------------------

clc; clear; close all;

ovl = [0.5 0.5]; % Overlap as a percentage.
bs = [30 40]; % Bounding box size [w h].
is = [200 200]; % Image size.

% Getting the top left and bottom right coordinates of the box.
[tlc, brc] = slidingWindowCornerCoordinates(is, bs, ovl);

% Number of boxes obtained.
nBoxes = size(tlc,1);

% Obtain the bboxes from the tlcs and brcs.
bboxs = bboxFromTlcAndBrc(tlc, brc);

% Creat a dummy image.
im = zeros(is);

imshow(im);
hold on;

for i = 1 : nBoxes

    currBox = bboxs(i,:);   
    % Insert rectangle.
    rectangle('Position',currBox,'LineWidth',1,'EdgeColor',[1 1 0]);
    pause;
end
    
    