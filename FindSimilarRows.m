function [filteredlinevektor] = FindSimilarRows(linevector, angularwindow, stepwindow)
%FINDSIMILARLINES Summary of this function goes here
%   Detailed explanation goes here
    
    if angularwindow >= 0 && stepwindow >= 0
       q = find(abs(linevector(2:end,1) - linevector(1:end-1, 1))< angularwindow);
       k = find(abs(linevector(2:end,2) - linevector(1:end-1, 2))< stepwindow);
       filteredlinevektor = unique(linevector(intersect(k, q), :), 'rows');
    elseif angularwindow >= 0
       q = find(abs(linevector(2:end,1) - linevector(1:end-1, 1))< angularwindow);
       filteredlinevektor = unique(linevector(q, :), 'rows');
    elseif stepwindow >= 0
       k = find(abs(linevector(2:end,2) - linevector(1:end-1, 2))< stepwindow);
       filteredlinevektor = unique(linevector(k, :), 'rows');
    else
        filteredlinevektor = linevector;
    end

end

