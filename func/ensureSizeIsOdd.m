%--------------------------------------------------------------------------
% Function:   ensureSizeIsOdd
%
% Description:  This function takes the bounding box size and checks to see
%               whether it is odd, if it is the function corrects it.
% 
% Inputs:
%
%   bs          - box size. [w h] 
%
% Outputs:         
%
%   bs         - New box size.
%
% Usage: This function is used in the DESDA tracker. 
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 22nd April, 2013.
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function bs = ensureSizeIsOdd(bs)

bs = floor(bs);

% Ensure that the box is no smaller than 5x5.
leastW = 5;
leastH = 5;
if (bs(1) < leastW)
    % Set the width to the leastW.
    bs(1) = leastW;
end

if (bs(2) < leastH)
    % Set the height to the least H.
    bs(2) = leastH;
end

mc1 = mod(bs(1),2); % Checking if the width is even.
mc2 = mod(bs(2),2); % Checking if the height is even.

if (mc1 == 0) 
    bs(1) = bs(1) + 1; % Make it odd.
end

if (mc2 == 0)
    bs(2) = bs(2) + 1; % Make is odd.
end


    
    