function [maximahough] = GetLocalMaxima(houghmatrix,houghtresholdmatrix, neighbours)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    maximahough = double(imregionalmax(houghmatrix.*houghtresholdmatrix, neighbours));
end
