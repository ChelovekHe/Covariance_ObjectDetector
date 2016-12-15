%--------------------------------------------------------------------------
% Function:   getAllBoundingBoxes
%
% Description:  This function takes the 9 sizes of bounding boxes, the
%               image size and returns all the relevant coordinates
%               describing the boxes. 
%               [w h xc yc tlcx tlcy brcx brcy]
% 
% Inputs:
%
%   bs          - box size. [w h] 
%
%   rp          - Reduction factor.
%
%   ep          - Enlargement factor.
%
%   ovl         - Overlap value for x and y direction. [ox oy] 
%
%   is          - Image size.[H W]
% 
% Outputs:         
%
%   ttlc        - Total number of top left corner coordinates.
%
%   tbrc        - Total number of bottom right corner coordinates.
%
% Usage: This function is used in the DESDA tracker. 
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 22nd April, 2013.
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function [ttlc, tbrc] = getAllBoundingBoxesInfo(bs, rp, ep, ovl, is)

obs = scaleBoundingBox(bs, rp, ep); % Get all the bounding boxes. 
nBoxes = size(obs,1); % Number of boxes.

ttlc = [];
tbrc = [];

% Loop through the box sizes to get all the coordinates.
for i = 1 : nBoxes
    
    cbs = obs(i,:); % Current box size.
    
    % Get all the bounding boxes in the image.
    [tlc, brc] = slidingWindowCornerCoordinates(is, cbs, ovl);
    
    % Storing the coordinates for all size boxes.
    ttlc = [ttlc; tlc];
    tbrc = [tbrc; brc];
end


    

























