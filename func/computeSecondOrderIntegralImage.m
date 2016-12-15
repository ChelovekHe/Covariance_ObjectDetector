%--------------------------------------------------------------------------
% Function:   computeSecondOrderIntegralImage
% Description:  This function takes in a feature image and second order 
%               integral image 
% 
% 
% Inputs:
%
%   F           - Feature image.
% 
% Outputs:         
%
%   Q           - W x H x d x d tensor of second order integral images.
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 22nd April, 2013.
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function Q = computeSecondOrderIntegralImage(F)

[m, n, nFeat] = size(F);
Q = nan(m + 1, n + 1, nFeat, nFeat); % Keeping the padding.

for i = 1 : nFeat
    for j = 1 : nFeat
        Q(:,:,i,j) = integralImage(F(:,:,i) .* F(:,:,j));   
    end
end
    