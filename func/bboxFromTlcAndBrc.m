%--------------------------------------------------------------------------
% Function:   bboxFromTlcAndBrc
% Description:  This function takes in the top left coordinates and the
%               bottom right coordinates and outputs the bbox.
% Inputs:
%   
%   tlc         - [x y] = [col row]
%   
%   brc         - [x y] = [col row]
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
function bbox = bboxFromTlcAndBrc(tlc, brc)

xt = tlc(:,1); % x - coordinate of the top left.
yt = tlc(:,2); % y - coordinate of the top left.
xb = brc(:,1); % x - coordinate of the bottom right.
yb = brc(:,2); % y - coordinate of the bottom right.

bbox = [tlc , (xb - xt), (yb - yt)];