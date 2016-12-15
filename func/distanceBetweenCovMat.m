%--------------------------------------------------------------------------
% Function:   distanceBetweenCovMat
% Description:  This function takes in two covariance matrices and computes
%               the distance between them as a measure of dissimilarity.
% 
% Inputs:
%
%   C1          - Covariance matrrix 1.
% 
%   C2          - Covariance matrrix 2.
%
% Outputs:         
%
%   cDist       - Distance between the covariance matrices.
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 22nd April, 2013.
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function cDist = distanceBetweenCovMat(C1, C2)


% Solving the generalized eigenvalue problem.
eigen = eig(C1,C2);

% Check for Nans and inf, remove them.
% feigen = abs(eigen(isfinite(eigen))); % NEEDS TO BE CHANGED.

feigen = eigen(isfinite(eigen)); % NEEDS TO BE CHANGED.

% Set all zero eigenvalues to a very small number.
smallNum = 1e-10;
feigen(feigen == 0) = smallNum;

% Now take the logs, sum and sqrt.
cDist = sqrt(sum((log(feigen).^2)));




