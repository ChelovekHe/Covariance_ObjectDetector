%--------------------------------------------------------------------------
% Function:   covarianceTesting
%
% Description:  This function takes in bounding boxes and computes the
%               covariance matrix using matlab's cov function and checks 
%               for non positive semi-definite matrices. 
% 
% Inputs:
%
%   tntlc        - Top number of top left corner coordinates.
%
%   tnbrc        - Top number of bottom right corner coordinates. 
%
%   F            - Feature Tensor
%
% Outputs:         
%
%   covCheck     - Binary vector indicating a non positive semi-definite 
%                  matrix with a value of 1.
%
%   covMatAll    - All the covariance matrices of the boxes.
%
% Usage: This function is used in the DESDA tracker. 
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 22nd April, 2013.
%--------------------------------------------------------------------------
function [covCheck, covMatAll] = covarianceTesting(tntlc, tnbrc, F)

% Number of boxes. 
nBoxes = size(tntlc,1);

covMatAll = cell(nBoxes,1); % Storing the covariance matrices.
covCheck = nan(nBoxes,1);   % Checking for covariance compliance.
[m, n, d] = size(F);
nFeat = d;

for i = 1 : nBoxes
    
    ctlc = tntlc(i,:); % Current tlc.
    cbrc = tnbrc(i,:); % Current brc. 
    
    % Get bbox from tlc and brc. 
    bbox = bboxFromTlcAndBrc(ctlc, cbrc);

    % Get linear indices for the box.
    [rVec, cVec] = bboxToLinearIndCov(bbox, [m n]);
    
    nr = numel(rVec);
    nc = numel(cVec);
    
    % Matrix to store the feature values for covariance computation. The
    % box sizes are different so a dynamic structure is needed to compute
    % store the values in a N x d format.
    cFMat = zeros(nr*nc, nFeat);
    
    for j = 1 : nFeat
        % Pull out each band (matrix).
        band = F(rVec, cVec, j);
        
        % Collapse to a vector.
        cFMat(:,j) = band(:);
    end
    
    covMat = cov(cFMat); % Compute the covariance matrix.
    covMatAll{i} = covMat; % Storing the covariance matrices.
    ecm = eig(covMat); % Get the eigenvalues of covMat.
      
    eigenThresh = 1e-10;
    % Setting the eigenvalues within the threshold to zero.
    ecm(abs(ecm) < eigenThresh) = 0; 
    
    eigchk = sum(ecm < 0); % Check if the eigenvalues are negative. 
  
    
    % Store the check in a vector.
    if (eigchk > 0)
        covCheck(i) = 1;
        disp('Matrix is not semi positve definite');
    else
        covCheck(i) = 0;
    end
end