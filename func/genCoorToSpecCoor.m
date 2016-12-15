%--------------------------------------------------------------------------
% Function:   genCoorToSpecCoor
% Description:  This function takes the top left coordinate and the bottom
%               right coordinate and returns the 5 different sets of
%               coordinates corresponding to the 5 covariance matrices.
% 
% Inputs:
%   
%   tlc         - [x y] = [col row]
%
%   brc         - [x y] = [col row]
% 
% Outputs:         
%
%   ccCell      - Covariance coordinate cell which contains the coordinates 
%                 for all 5 forms of the matrices.
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 22nd April, 2013.
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function ccCell = genCoorToSpecCoor(tlc, brc)

% The width and height of the bounding box should be even to ensure that the
% middle column is an odd number or the matrix is evenly split in half by
% the column. The box should always be symmetric.

ccCell = cell(5,2);

xt = tlc(:,1); % x - coordinate of the top left.
yt = tlc(:,2); % y - coordinate of the top left.
xb = brc(:,1); % x - coordinate of the bottom right.
yb = brc(:,2); % y - coordinate of the bottom right.

mw = ceil((xb - xt) / 2); % Middle width.
mh = ceil((yb - yt) / 2); % Middle height.

% C1 coordinates remain the same. 
ccCell{1,1} = tlc;
ccCell{1,2} = brc;

% C2 coordinates only the width changes and tlc remains the same. 
ccCell{2,1} = tlc;
ccCell{2,2} = [(xb - mw) yb];

% C3 coordinates only the width changes and brc remains the same. 
ccCell{3,1} = [(xt + mw) yt];
ccCell{3,2} = brc;

% C4 coordinates only the height changes and tlc remains the same. 
ccCell{4,1} = tlc;
ccCell{4,2} = [xb (yb - mh)];

% C5 coordinates only the height changes and brc remains the same. 
ccCell{5,1} = [xt (yt + mh)];
ccCell{5,2} = brc;