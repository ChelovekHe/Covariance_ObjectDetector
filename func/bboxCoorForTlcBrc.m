%--------------------------------------------------------------------------
% Function:   bboxCoorForTlcBrc
% Description:  This function takes in a bounding box and returns the top
%               left coordinates and the bottom right coordinates. 
% Inputs:
%   
%   bbox        - Bounding box.
% 
% Outputs:         
%
%   tlc         - [x y] = [col row]
%
%   brc         - [x y] = [col row]
% 
%   bs          - box size. [w h] 
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 22nd April, 2013.
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function [tlc, brc, bs] = bboxCoorForTlcBrc(bbox)

% The size of the width and height must be odd before coming into this
% function.

x = bbox(1);
y = bbox(2);
W = bbox(3);
H = bbox(4);

% Top left coordinate [xt yt].
tlc = [x, y];

% Top right coordinate [xb yb].
brc = [(x + W), (y + H)];

bs = [W, H]; % Box size.