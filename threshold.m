function [outmatrix] = threshold(inmatrix, threshold)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%outmatrix = zeros(size(inmatrix));
% outmatrix(inmatrix >= threshold*max(max(inmatrix(:,:)))) = ...
%     inmatrix(inmatrix >= threshold*max(max(inmatrix(:,:))));
outmatrix = inmatrix > threshold * max(inmatrix, [], 'all');

end

