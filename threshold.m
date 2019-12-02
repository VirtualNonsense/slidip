function [outmatrix] = threshold(inmatrix, threshold)
%inmatrix: n*m Matrix
%threshold: value between 0 and 1

%creating n*m Matrix, same size as inmatrix
outmatrix = zeros(size(inmatrix)); 

%copying the values of inmatrix greater than threshold*maxValue in
%inmatrix to outmatrix
outmatrix = double(inmatrix > threshold*max(inmatrix,[],'all'));

end

