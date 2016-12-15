%--------------------------------------------------------------------------
% Function:   computeCovarianceMatrixFromCoor
% Description:  This function takes all the coordinates of the boxes
%               corresponding to the 5 covariance features, computes the 5
%               covariance matrices and returns them in a cell.
% 
% Inputs:
%   
%   ccCell      - Covariance coordinate cell which contains the coordinates 
%                 for all 5 forms of the matrices.
%
%   P           - Integral feature image.
%
%   Q           - Second order integral image.
%
% Outputs:         
%
%   covCell     - Cell of covariance matrices. 
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 29th April,2013
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function covCell = computeCovarianceMatrixFromCoor(ccCell, P, Q)

ncms = size(ccCell,1); % Number of covariance matrices.
covCell = cell(ncms,1); % Storing the 5 covaraince matrices.

for i = 1 : ncms
    
    % Compute the covariance of each cell.
    ctlc = ccCell{i, 1}; % Current tlc.
    cbrc = ccCell{i, 2}; % Current brc.
    
    % Compute the covariance matrix of each box.
    covCell{i} = computeCovarianceMatrix(P, Q, ctlc, cbrc);
end