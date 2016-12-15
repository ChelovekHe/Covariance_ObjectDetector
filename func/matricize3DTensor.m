%--------------------------------------------------------------------------
% Function:   matricize3DTensor
% Description:  This function takes in a 3 dimensional tensor and with two
%               coordinates, the function returns the vector.
% 
% Inputs:
%
%   P           - W x H x d tensor of the integral feature images.
%
%   c           - [x, y] = [col, row];
%
% Outputs:         
%
%   pv          - p vector.
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 22nd April, 2013.
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function pv = matricize3DTensor(P, c)

% Create a d x d matrix Qp.

[~, ~, d3] = size(P);
x = c(1);
y = c(2); 
pv = nan(d3,1);  % Initializing pv.
for i = 1 : d3 
    pv(i) = P(y,x,i);      
end