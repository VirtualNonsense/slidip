function [outmatrix] = threshold(inmatrix, threshold)
%   This is a simple filter to reduce the amount of calculations needed in
%   the houghtransformation.
%   It works by setting every value > threshold*maxvalue(inmatrix) 1 and
%   the rest zero
%   Input ########################
%   inmatrix: n*m Matrix
%   threshold: value between 0 and 1
%   Output #######################
%   outmatrix: filtered matrix containing only 1s and 0s

    % creating boolmatrix and converting it into a doublematrix in order to
    % use it in calculations
    outmatrix = double(inmatrix > threshold*max(inmatrix,[],'all'));

end

