%--------------------------------------------------------------------------
% Function:   TrainCovarianceObjectDetector
% Description:  This function trains the covariance object detector and
%               outputs the covariance matrix of the object you selected,
%               the coordinate of the all box sizes that scan the image,
%               the bounding box of the OI (object of interest) and the 5
%               covariance matrices of the object.
% 
% Inputs:
%
%   firstFrame      - Frame to select object in.
%
%   ovl             - Overlap in x and y direction as a percentage [x y].
% 
% Outputs:         
%
%   ocm             - Object covariance matrix.
%
%   ttlc            - Total number of top left corner coordinates.
%
%   tbrc            - Total number of bottom right corner coordinates.
%
%   obbox           - Object bounding box.
%
%   ocCell          - Cell containing the 5 covariance matrices of the
%                     object.
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 29th April,2013
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function [ocm, ttlc, tbrc, obbox, ocCell] = ...
                                TrainCovarianceObjectDetector(firstFrame, ovl)
                             
disp('Crop the object you want to detect');

% Crop the image and return the bbox. 
[~, obbox] = imcrop(firstFrame);

% Ensure that the bbox is even using the odd function.(Will be changed
% later).
% Check that the bounding box are integers and the size is odd.
obbox = ensureBboxIsEven(obbox);

% Use the bbox to get the tlc and brc.
% Obtain the tlc and brc of the object. tlc - top left corner, blc - bottom
% righ corner. 
[tlc, brc, obs] = bboxCoorForTlcBrc(obbox);

% Calculate P and Q.
[P, Q] = calculatePandQ(firstFrame);

% Compute the covariance of the object.
ocm = computeCovarianceMatrix(P, Q, tlc, brc);

% ovl = [1 1]; % Overlap as a percentage.
rp = 0.85; % Reduction factor. 
ep = 1.15; % Expandsion factor.
[r, c, ~] = size(firstFrame);
is = [r, c]; % Image size.

% Get all the information for the bounding boxes using C1.
[ttlc, tbrc] = getAllBoundingBoxesInfo(obs, rp, ep, ovl, is);

% Get specific coordinates for the 5 covariance matrices of the object.
ccCellObj = genCoorToSpecCoor(tlc, brc);

% Compute the 5 covariance matrices of the object.
ocCell = computeCovarianceMatrixFromCoor(ccCellObj, P, Q);


