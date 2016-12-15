%--------------------------------------------------------------------------
% Function:   computeImageFeatures
% Description:  This function takes in an image and computes the several
%               features on the image.
% 
% Inputs:
%
%   I           - Image to compute the features on.
% 
% Outputs:         
%
%   F           - Feature image, M x N x #Features.
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 22nd April, 2013.
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function F = computeImageFeatures(I)

nFeat = 9;
[M, N, ~] = size(I);
grI = rgb2gray(I); % Gray image.

F = zeros(M, N, nFeat);

% Image gradients.
[gx, gy] = imgradientxy(grI);

% Second partial in X.
[gxx, ~] = imgradientxy(gx);

% Second partial in Y.
[~, gyy] = imgradientxy(gy);

% Get row and column index.
[Y, X] = ind2sub([M, N], reshape(1 : M*N, M, N));
% 
% F(:,:,1) = X; % X - Coordinates (column).
% F(:,:,2) = Y; % Y - Coordinates (row).
% 
F(:,:,1) = (X - repmat(mean(X,2),1,N)) ./ repmat(std(X,0,2),1,N); % X - Coordinates (column).
F(:,:,2) = (Y - repmat(mean(Y),M,1)) ./ repmat(std(Y,0,1),M,1); % Y - Coordinates (row).

F(:,:,3) = I(:,:,1); % Red.
F(:,:,4) = I(:,:,2); % Green.
F(:,:,5) = I(:,:,3); % Blue.
F(:,:,6) = abs(gx); 
F(:,:,7) = abs(gy); 
F(:,:,8) = abs(gxx); 
F(:,:,9) = abs(gyy); 

F = double(F);







