%--------------------------------------------------------------------------
% Function:   calculatePandQ
% Description:  This function takes in an image, computes the features and
%               outputs the P and Q needed to compute the covariance
%               matrix.
% 
% Inputs:
%
%   im          - Image to compute the features on.
% 
% Outputs:         
%  
%   P           - W x H x d tensor of integral images
%
%   Q           - W x H x d x d tensor of second order integral images.
%
% Usage: This function is used in the DESDA tracker. 
%
% Authors(s):
%   Mark Moyou(mmoyou@my.fit.edu)
%
% Date: Monday 29th April,2013
%
% Paper implemented : Region Covariance: A Fast Descriptor for Detection
% and Classification by Oncel Tuzel, Fatih Porikli and Peter Meer.
%--------------------------------------------------------------------------
function [P, Q] = calculatePandQ(im)

F = computeImageFeatures(im);   % Compute the features. 
P = computeIntegralImage(F);    % Compute P.
Q = computeSecondOrderIntegralImage(F);  % Compute Q.