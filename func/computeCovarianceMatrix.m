%--------------------------------------------------------------------------
% Function:   computeCovarianceMatrix
% Description:  This function takes in a feature image and second order 
%               integral image 
% 
% 
% Inputs:
%
%   P           - Integral feature image.
%
%   Q           - Second order integral image.
%
%   tlc         - Top left coordinate. [x',y'] = [col, row]
%
%   brc         - Bottom right coordinate. [x',y'] = [col, row]
% 
% Outputs:         
%
%   cm          - Covariance matrix.
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 29th April,2013
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function cm = computeCovarianceMatrix(P, Q, tlc, brc)

x1 = tlc(1);    % x'
y1 = tlc(2);    % y'
x2 = brc(1) + 1;   % x''.  we added + 1 to ensure proper indexing.
y2 = brc(2) + 1;   % y''   we added + 1 to ensure proper indexing.

% -------------------------------------------------------------------------
% Pulling out matrices.
Qx2y2 = squeeze(Q(y2,x2,:,:)); 
Qx1y1 = squeeze(Q(y1,x1,:,:));
Qx2y1 = squeeze(Q(y1,x2,:,:));
Qx1y2 = squeeze(Q(y2,x1,:,:));

% Pulling out vectors.
Px2y2 = squeeze(P(y2,x2,:,:));
Px1y1 = squeeze(P(y1,x1,:,:));
Px1y2 = squeeze(P(y2,x1,:,:));
Px2y1 = squeeze(P(y1,x2,:,:));

h = Px2y2 + Px1y1 - Px1y2 - Px2y1;
n = (x2 - x1)*(y2 - y1);    % The n includes the +1 from x2 and y2.

% Covariance matrix.
cm = (1/(n-1))* (Qx2y2 + Qx1y1 - Qx2y1 - Qx1y2 - (1/n)*(h*h'));

% -------------------------------------------------------------------------

% Symmetry condition test.
symCheck = cm' == cm;
if (symCheck ~= 1)
    disp('Covariance matrix is not symmetric');
%     pause;
end

% Check for positive semi-definiteness.
eigen = eig(cm);

eigenThresh = 1e-10;
% Setting the eigenvalues within the threshold to zero.
eigen(abs(eigen) < eigenThresh) = 0; 

if ((sum(eigen < 0)) > 0)
    disp('covariance matrix is not positive semi-definite');
end