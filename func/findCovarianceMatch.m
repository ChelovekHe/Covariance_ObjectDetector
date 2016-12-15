%--------------------------------------------------------------------------
% Function:   findCovarianceMatch
% Description:  This function takes all the coordinates of the boxes
%               corresponding to the 5 covariance features and compares it
%               to the covariance of the object and outputs a bounding box.
% 
% Inputs:
%   
%   tntlc       - Top number of top left corner coordinates.
%
%   tnbrc       - Top number of bottom right corner coordinates.
%
%   P           - Integral feature image.
%
%   Q           - Second order integral image.
%
%   ocCell      - Cell containing the 5 object covariance matrices.
%
%   ntdboxes    - Number of top detection boxes.  
%
% Outputs:         
%
%   bbox        - Bounding box.
%
%   topBoxes    - Top detection boxes specified by ntdboxes.
%
%   topSorted   - Top sorted distances between covariance matrices
%                 corresponding to the top boxes.
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 29th April,2013
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function [bbox, topBoxes, topSorted] = findCovarianceMatch(tntlc,...
                                                           tnbrc, P, Q,... 
                                                            ocCell,...
                                                            ntdboxes)

ntb = size(tntlc,1); % Number of total boxes.
ncmpb = 5; % Number of covariance matrices per box.
dV = nan(ntb,1); % Distance vector.

% Loop through the boxes. 
for i = 1 : ntb
    
    % Access the tlc and brc associated with the current box.
    ctlc = tntlc(i,:); % Current tlc of the ith box.
    cbrc = tnbrc(i,:); % Current brc of the ith box.
    
    % Get specific coordinates for the 5 covariance matrices of the target.
    ccCellTar = genCoorToSpecCoor(ctlc, cbrc);
    
    % Compute the 5 covariance matrices of the target.
    ctcCell = computeCovarianceMatrixFromCoor(ccCellTar, P, Q);
    
    % Vector of distances between of each of the five covariance matrices of 
    % the object and the target.
    dbecm = nan(1,ncmpb); 
    
    for j = 1 : ncmpb  % Calculate the 5 distances between object and target.
        coc = ocCell{j}; % Current object covariance.
        ctc = ctcCell{j}; % Current target covariance.
        
        % Storing the distances between the covariance matrices.
        dbecm(j) = distanceBetweenCovMat(coc, ctc);
    end
    
    % Sum of the distances between the 5 object and target covariances.
    sumDist = sum(dbecm); 
        
    % Select the max of the 5 covariance distances. 
    [~, m5cdInd] = max(dbecm);
    
    dV(i) = sumDist - m5cdInd; % Max distance removed from the sum.
end

[sortedDv, sortInd] = sort(dV,'ascend'); % Sort the dv.

topSorted = sortedDv(1:ntdboxes);
stntlc = tntlc(sortInd,:); % Apply the sort index to tlcs.
stnbrc = tnbrc(sortInd,:); % Apply the sort index to brcs.

topBoxes = bboxFromTlcAndBrc(stntlc(1:ntdboxes,:), stnbrc(1:ntdboxes,:));

[~, mtdInd] = min(dV); % Min total distance and index.
bbox = bboxFromTlcAndBrc(tntlc(mtdInd,:), tnbrc(mtdInd,:)); % Get bounding box.


    
    
    
        
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    