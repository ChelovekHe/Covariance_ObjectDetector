%--------------------------------------------------------------------------
% Function:   computeIntegralImage
% Description:  This function takes in a feature image and outputs the
%               integral image of each band. The padding from the integral
%               image is necessary for correct computation of the
%               covariance matrix.
% 
% Inputs:
%
%   F         - Feature image.
% 
% Outputs:         
%
%   P         - W x H x d tensor of integral images
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 22nd April, 2013.
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function P = computeIntegralImage(F)

[m, n, nFeat] = size(F);
P = nan(m + 1, n + 1, nFeat); % Initializing a tensor of integral images.

for i = 1 : nFeat   
    P(:,:,i) = integralImage(F(:,:,i)); % Integral image of a feature dimension.   
end


