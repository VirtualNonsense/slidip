function [outmatrix] = threshold(inmatrix, threshold)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
outmatrix = zeros(size(inmatrix));
outmatrix = double(inmatrix > threshold*max(inmatrix,[],'all'));

end

