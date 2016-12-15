%--------------------------------------------------------------------------
% Function:   detectObject
% Description:  This function takes in an image and an object covariance
%               matrix and outputs a bounding box of where the object is in
%               that frame.
% 
% Inputs:
%
%   im          - Image.
%
%   ocm         - Object covariance matrix.
%
%   ttlc        - Total number of top left corner coordinates.
%
%   tbrc        - Total number of bottom right corner coordinates.
% 
%   ocCell      - Cell containing the 5 object covariance matrices.
%
%   ntdBoxes    - Number of top detection boxes.
%
% Outputs:         
%
%   tbbox       - Target bounding box.
%
%   topBoxes    - Top detection boxes corresponding to ntdBoxes.
%
%   topSortedDist- Top sorted distances corresponding to the top boxes.
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 29th April,2013
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function [tbbox, topBoxes, topSortedDist] = detectObject(im, ocm, ttlc,...
                                                        tbrc, ocCell, ntdBoxes)

% Calculate P and Q.
[P, Q] = calculatePandQ(im);

ntb = 1000; % Number of top boxes.

% Compute the covariance matrix using the tlc and brc.

% Get the top ntb boxes from using C1.
[tntlc, tnbrc] = getTopBoxesFromCovC1(ttlc,...
                                     tbrc, ocm, P, Q, ntb);
                                 
% Find the covariance match of the target.
[tbbox, topBoxes, topSortedDist] = findCovarianceMatch(tntlc, tnbrc, P, Q,...
                                        ocCell, ntdBoxes);

