%--------------------------------------------------------------------------
% Function:   bboxToLinearIndCov
%
% Description:  This function takes in bounding boxes and returns the
%               linear indices into the bigger matrix.
% 
% Inputs:
%
%   bbox         - Bounding box.
%
%   imSize       - Image size. [r c]
%
% Outputs:         
%
%   rVec         - Linear indices of row vectors.
%
%   cVec         - Linear indices of the column vector.
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 22nd April, 2013.
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function [rVec, cVec] = bboxToLinearIndCov(bbox,imSize)

x = bbox(1);
y = bbox(2);
w = bbox(3);
h = bbox(4);

rVec = y : y + h;
cVec = x : x + w;

% Check if the box is within the image but it would most likely never happen.
rVec(rVec > imSize(1)) = []; % Any value greater than the size of the image is removed.

cVec(cVec > imSize(2)) = []; % Any value greater than the size of the image is removed.