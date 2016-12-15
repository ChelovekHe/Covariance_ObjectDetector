%--------------------------------------------------------------------------
% Function:   getTopBoxesFromCovC1
%
% Description:  This function takes all the possible boxes that would scan
%               the image and it computes a covariance matrix for each box.
%               It then compares this covariance matrix to that of the
%               object and returns only the top number of boxes based on 
%               the distance between the covariance matrices. The number
%               of boxes is chosen by the user. 
% 
% Inputs:
%
%   ttlc        - Total number of top left corner coordinates.
%
%   tbrc        - Total number of bottom right corner coordinates.
%
%   co1         - Covariance matrix C1 of the object.
%
%   P           - Integral feature image.
%
%   Q           - Second order integral image.
%
%   ntb         - Number of top boxes.
%
% Outputs:         
%
%   tntlc        - Top number of top left corner coordinates.
%
%   tnbrc        - Top number of bottom right corner coordinates.
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 22nd April, 2013.
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function [tntlc, tnbrc] = getTopBoxesFromCovC1(ttlc, tbrc, co1, P, Q, ntb)
                                 
% Number of boxes.
nBoxes = size(ttlc,1);

% Initialize distance vector.
dVec = zeros(nBoxes,1);

% Loop through the boxes.
for i = 1 : nBoxes

    % Compute the covariance of the box.
    cm = computeCovarianceMatrix(P, Q, ttlc(i,:), tbrc(i,:));

    % Compute the distance to co1.
    dVec(i) = distanceBetweenCovMat(co1, cm);
end

% Sort the distance vector and return the sorting index.
[~, sInd] = sort(dVec, 'ascend');

% Index check.
lngdVec = length(dVec);
if (ntb > lngdVec)
    ntb = lngdVec;
end

tntlc = ttlc(sInd, :); % Sort with the sorting index.
tntlc = tntlc(1:ntb, :); % Get the top n boxes.

tnbrc = tbrc(sInd, :); % Sort with the sorting index.
tnbrc = tnbrc(1:ntb, :); % Get the top n boxes.
    
    
    
   



















                                 