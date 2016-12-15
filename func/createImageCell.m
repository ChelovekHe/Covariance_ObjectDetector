%--------------------------------------------------------------------------
% Function:   createImageCell
% Description:  This function takes in an image and gives the various
%               images made as combinations of the gray and RGB color
%               bands. This outputs the a cell with the images.
% 
% Inputs:
% 	im        - Input image.
%
%   nCooc     - Number of cocurrence matrices.
%
% Outputs:         
%
%   combCell  - Cell containing all the images. 
%               
%
% Usage: This function is used in the DESDA tracker. The second image is
%        padded in each case so that the mask will be able to move over the
%        image.
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%--------------------------------------------------------------------------
function [imComb, probImCell]  = createImageCell(im, nCooc)

[r, c, D] = size(im);

if (D ~= 1)
    grayIm = rgb2gray(im); % Grayscaling the image.
else % The image is grayscale.
    grayIm = im; % Grayscale image.
    % Adding bands to the image.
    im = ones(r, c, 3);
end

padVal = 256;

% Pad the second image with -1's.
padWidth = 1; % Width to add to one side.
pSGray = padVal * ones(r + (2 * padWidth), c + (2 * padWidth));
newr = r + 1; 
newc = c + 1;

pSGray((2 : newr), (2 : newc)) = grayIm;  % Gray.

pSRed = padVal * ones(r + (2 * padWidth), c + (2 * padWidth)); % Red.
pSRed((2 : newr), (2 : newc)) = im(:,:,1); % Padded red.

pSGreen = padVal * ones(r + (2 * padWidth), c + (2 * padWidth)); % Green.
pSGreen((2 : newr), (2 : newc)) = im(:,:,2); % Padded Green.

pSBlue = padVal * ones(r + (2 * padWidth), c + (2 * padWidth)); % Blue.
pSBlue((2 : newr), (2 : newc)) = im(:,:,3); % Padded Blue.

% Create a cell for the image combinations.
imComb = cell(nCooc, 2);
imComb{1,1} = grayIm;           imComb{1,2} = pSGray;       % Gray.
imComb{2,1} = im(:,:,1);        imComb{2,2} = pSRed;        % Red.
imComb{3,1} = im(:,:,2);        imComb{3,2} = pSGreen;      % Green.
imComb{4,1} = im(:,:,3);        imComb{4,2} = pSBlue;       % Blue.
imComb{5,1} = im(:,:,1);        imComb{5,2} = pSGreen;      % Red/Green.
imComb{6,1} = im(:,:,1);        imComb{6,2} = pSBlue;       % Red/Blue.
imComb{7,1} = im(:,:,3);        imComb{7,2} = pSGreen;      % Blue/Green.

% % Probability image cell.
% prGrIm = zeros(r, c);
% prRedRed = zeros(r,c);
% prGrGr = zeros(r,c);
% prBlBl = zeros(r,c);
% prRedGr = zeros(r,c);
% prRedBl = zeros(r,c);
% prBlGr = zeros(r,c);

% Filling in the probability image cell.
probImCell = cell(nCooc, 2);
% probImCell{1,1} = prGrIm;               
% probImCell{2,1} = prRedRed;            
% probImCell{3,1} = prGrGr;              
% probImCell{4,1} = prBlBl;              
% probImCell{5,1} = prRedGr;             
% probImCell{6,1} = prRedBl;              
% probImCell{7,1} = prBlGr;              

probImCell{1,2} = 'prGrIm';           
probImCell{2,2} = 'prRedRed';
probImCell{3,2} = 'prGrGr';
probImCell{4,2} = 'prBlBl';
probImCell{5,2} = 'prRedGr';
probImCell{6,2} = 'prRedBl';
probImCell{7,2} = 'prBlGr';


