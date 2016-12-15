%--------------------------------------------------------------------------
% Function:   matricizeTensor
% Description:  This function takes in a 4 dimensional tensor and with two
%               coordinates, the function returns the plane.
% 
% Inputs:
%
%   Q           - Second order integral image.
%
%   c           - [x, y] = [col, row];
% Outputs:         
%
%   Qp          - Q plane.
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 22nd April, 2013.
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function Qp = matricizeTensor(Q, c)

% Create a d x d matrix Qp.

[~, ~, d3, d4] = size(Q);
x = c(1);
y = c(2);
Qp = nan(d3,d4); 
for i = 1 : d3 
    for j = 1 : d4
        Qp(i,j) = Q(y,x,i,j);      
    end
end
