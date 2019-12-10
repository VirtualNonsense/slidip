function [filteredlinevektor] = FindSimilarRows(linevector, angularwindow, stepwindow)
%FINDSIMILARLINES Summary of this function goes here
%   Detailed explanation goes here
    
    if angularwindow >= 0 && stepwindow >= 0
       q = find(abs(linevector(2:end,1) - linevector(1:end-1, 1))< angularwindow);
       k = find(abs(linevector(2:end,2) - linevector(1:end-1, 2))< stepwindow);
       filteredlinevektor = linevector(intersect(k, q), :);
    elseif angularwindow >= 0
       q = find(abs(linevector(2:end,1) - linevector(1:end-1, 1))< angularwindow);
       filteredlinevektor = linevector(q, :);
    elseif stepwindow >= 0
       k = find(abs(linevector(2:end,2) - linevector(1:end-1, 2))< stepwindow);
       filteredlinevektor = linevector(k, :);
    else
        filteredlinevektor = linevector;
    end

end

