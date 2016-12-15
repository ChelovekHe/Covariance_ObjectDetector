%--------------------------------------------------------------------------
% Function:   findAllBoxesForSR
% Description:  This function finds all the bounding boxes within a search 
%               region which is a subset of the original image. 
% 
% Inputs:
%
%   ttlc        - Total number of top left corner coordinates.
%
%   tbrc        - Total number of bottom right corner coordinates.
% 
%   srbbox      - Search region bounding box.
%
% Outputs:         
%
%   srttlc      - Search region total number of top left corner coordinates.
%
%   srtbrc      - Search region total number of bottom right corner coordinates.
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 29th April,2013
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function [srttlc, srtbrc] = findAllBoxesForSR(ttlc, tbrc, srbbox)

% Get the tlc and brc of the search region.
srbbox = floor(srbbox);
[srtlc, srbrc, ~] = bboxCoorForTlcBrc(srbbox);

srxt = srtlc(1); % xt search region.
sryt = srtlc(2); % yt search region.

srxb = srbrc(1); % xb search region.
sryb = srbrc(2); % yb search region.

ttlcx = ttlc(:,1); % All xts.

% Find all the boxes whose xt > xtsr.
xtInd = find(ttlcx > srxt);

% Pull out all the coordinates associated with xtInd.
ttlcTemp1 = ttlc(xtInd,:); % Tlc coordinates.
tbrcTemp1 = tbrc(xtInd,:); % Brc coordinates.

% Access that new xb.
xbTemp1 = tbrcTemp1(:,1); % xb coordinates. 

% Now check for boxes whose xb < xbsr.
xbInd = find(xbTemp1 < srxb);

% Pull out the boxes from temp 1s that correspond to this index.
ttlcTemp2 = ttlcTemp1(xbInd,:); 
tbrcTemp2 = tbrcTemp1(xbInd,:);

% Now search for the y conditions.
% Access the new column of yts.
ytTemp2 = ttlcTemp2(:,2); % yts.

% Find all the boxes in Temp2 whose yt > sryt.
ytInd = find(ytTemp2 > sryt);

% Pull out the boxes associated with ytInd
ttlcTemp3 = ttlcTemp2(ytInd,:);
tbrcTemp3 = tbrcTemp2(ytInd,:);

% Now access the new column of ybs.
ybTemp3 = tbrcTemp3(:,2);

% Find all the boxes in Temp 3 whose yb < styb.
ybInd = find(ybTemp3 < sryb);

% Pull out the boxes associated with ybInd.
srttlc = ttlcTemp3(ybInd,:);
srtbrc = tbrcTemp3(ybInd,:);
