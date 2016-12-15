%--------------------------------------------------------------------------
% Function:   bboxFromBoxCoordinates
% Description:  This function takes in the top left coordinates and the
%               width and heights of the box and returns the bbox structure
%               for plotting.
% Inputs:
%   
%   tlc         - [x y] = [col row]
%   
%   whMat       - Vector containing the width and height values. 
%
% Outputs:         
%
%   bbox        - Bounding box.
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
function bbox = bboxFromBoxCoordinates(tlc, whMat)

bbox = [tlc whMat];


