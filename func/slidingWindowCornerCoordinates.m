%--------------------------------------------------------------------------
% Function:   slidingWindowCornerCoordinates
%
% Description:  This function takes the overall image size and the bounding
%               box size and returns the top left coordinates(tlc) and
%               bottom right coordinates(brc) of all the boxes that would
%               occur in a window based on the overlap value.
% 
% 
% Inputs:
%
%   is          - Image size.[H W]
%
%   bs          - Bounding box size(odd sizes). [w h]
%
%   ovl         - Overlap value for x and y direction as a percentage. [ox oy] 
%
% Outputs:         
%
%   tlc         - Top left corner coordinates.
%
%   brc         - Bottom right corner coordinates.
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 22nd April, 2013.
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function [tlc, brc] = slidingWindowCornerCoordinates(is, bs, ovl)

% 100 percent overlap is where the edge of one box lies on the center of
% the next box. So 50 % overlap is half of the flap of the matrix.

% Defining points.
H = is(1);  % Height of original image.
W = is(2);  % Width of original image.
w = bs(1) + 1;  % Width or number of rows of bbox.
h = bs(2) + 1;  % Height of number of columns of bbox.

xc1 = ceil(w/2);   % x center coordinate of the bbox.
yc1 = ceil(h/2);   % y center coordinate of the bbox.

% Width of the flap of the bbox. Distance from edge to center.0
dw = xc1 - 1;

% Height of the flap of the bbox. Distance from edge to center.
dh = yc1 - 1;

ox = ceil(ovl(1)*2*dw); % Overlap in x direction.
oy = ceil(ovl(2)*2*dh); % Overlap in y direction.

xce = W - dw;   % x coordinate of the box center at the end of image.
yce = H - dh;   % y coordinate of the box center at the end of image.

% Making sure the overlap is less than 2*widthbox + 1.
ovlxCheck = ox < (2*dw + 1);
if (ovlxCheck ~= 1)
    ox = 2*dw + 1; % Maximum overlap with the centers only dw + 1 apart.
end

% Making sure the overlap is less than 2*heigtbox + 1.
ovlyCheck = oy < (2*dh + 1);
if (ovlyCheck ~= 1)
    oy = 2*dh + 1; % Maximum overlap with the centers only dw + 1 apart.
end

dxc = 2*dw + 1 - ox;     % Distance to the next x center. 
dyc = 2*dh + 1 - oy;     % Distance to the next y center. 

% Find the number of centers that fit in the width of the box.
nciw = xc1 : dxc : xce;    
% Find the number of centers that fit in the width of the box.
ncih = yc1 : dyc : yce;    

c1xCheck = nciw(end) == xce; % Case 1 x check.
% Case 1: The last value is not equal to the xend center.
if (c1xCheck ~= 1)
    % Add a center value equal to the last center value.
    nciw(end + 1) = xce; 
end

c1yCheck = ncih(end) == yce; % Case 1 y check.
% Case 1: The last value is not equal to the yend center.
if (c1yCheck ~= 1)
    % Add a center value equal to the last center value.
    ncih(end + 1) = yce;
end

% The flap is the half of the box from the center column.
% Now with the center value and width of the flap get xtop coordinate.
xt = nciw - dw;
% Now with the center value and width of the flap get xbottom coordinate.

% To keep the size of the bouding box we need to add one to the
% coordinates.
xb = nciw + dw;

% Now with the center value and the height of the flap get ytop coordinate.
yt = ncih - dh;
% Now with the center value and the height of the flap get ybottom
% coordinate.
yb = ncih + dh;

[xtm, ytm] = meshgrid(xt,yt); % tlc coordinates.
tlc = [xtm(:) ytm(:)];

[xbm, ybm] = meshgrid(xb,yb); % brc coordinates.
brc = [xbm(:) ybm(:)];


