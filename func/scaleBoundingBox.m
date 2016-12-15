%--------------------------------------------------------------------------
% Function:   scaleBoundingBox
%
% Description:  This function takes the bounding box size, some scaling
%               parameters and outputs 4 smaller and 4 bigger boxes. The
%               minimum size box that can be inputed is a 12 x 12. Any
%               number below 12 results in repeated numbers. 
% 
% Inputs:
%
%   bs          - box size. [w h] 
%
%   rp          - Reduction factor.
%
%   ep          - Enlargement factor.
%
% Outputs:         
%
%   obs         - Output box sizes.
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 22nd April, 2013.
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function obs = scaleBoundingBox(bs, rp, ep)

bs = ensureSizeIsOdd(bs); % Making sure size is odd.

nr = 9;
nc = 2;
obs = zeros(nr,nc);

% Smaller boxes.
sb4 = ensureSizeIsOdd(bs*rp);
sb3 = ensureSizeIsOdd(sb4*rp);
sb2 = ensureSizeIsOdd(sb3*rp);
sb1 = ensureSizeIsOdd(sb2*rp);

% Bigger boxes.
bb1 = ensureSizeIsOdd(bs*ep);
bb2 = ensureSizeIsOdd(bb1*ep);
bb3 = ensureSizeIsOdd(bb2*ep);
bb4 = ensureSizeIsOdd(bb3*ep);

obs(1,:) = bb4;
obs(2,:) = bb3;
obs(3,:) = bb2;
obs(4,:) = bb1;
obs(5,:) = bs;
obs(6,:) = sb4;
obs(7,:) = sb3;
obs(8,:) = sb2;
obs(9,:) = sb1;









