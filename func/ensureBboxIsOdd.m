%--------------------------------------------------------------------------
% Function:   ensureBboxIsOdd
%
% Description:  This function takes the bounding box makes sure that the
%               top left coordinate (tlc) and bottom right coordinate
%               create an odd numbered sub image in both the width and
%               height.
% 
% Inputs:
%
%   bbox        - Bounding box.
%
% Outputs:         
%
%   bbox       - New bounding box.
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 22nd April, 2013.
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function bbox = ensureBboxIsOdd(bbox)

% Actually making the bounding boxes even.

bbox = floor(bbox);

if (bbox(1) < 1) % Ensuring I have no zero index.
    bbox(1) = 1;
end

if (bbox(2) < 1) % Ensuring I have no zero index.
    bbox(2) = 1;
end

% Check to make sure the result of subtrating the tlc from the brc is odd
% so that means that the width and height are odd then we are able to have
% centers located at a column.

% Check that the width is odd.
wchk = mod(bbox(3),2);
if (wchk ~= 0) % If W is even, make it odd.
%     bbox(3) = bbox(3) + 1;
    bbox(3) = bbox(3) - 1;
end

% Check that the height is odd.
hchk = mod(bbox(4),2);
if (hchk ~= 0) % If H is even, make it odd.
%     bbox(4) = bbox(4) + 1;
    bbox(4) = bbox(4) - 1;
end


    
    