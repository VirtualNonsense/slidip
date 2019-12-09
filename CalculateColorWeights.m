function [UnChangedC1,UnChangedC2] = CalculateColorWeights(ChangedC, UnChangedC1, UnChangedC2)
%   This function ensures that the sum of all colorweights is <=1
%   Input ########################
%   ChangedC: Contains the changed weight
%   UnChanged1/2: Contains the unchanged weight
%   Output #######################
%   UnChanged1/2: Contains updated weigh
    
    % calculation remaining space
    leftSpace = 100 - ChangedC;    
    % checking wether changing the other weights is neccesary
    if leftSpace < UnChangedC1 + UnChangedC2
        % sloppy algorithm to distribute the remaining space
        UnChangedC1 = leftSpace * UnChangedC1/100;
        UnChangedC2 = leftSpace * UnChangedC2/100;
        l = leftSpace - UnChangedC1 - UnChangedC2;
        UnChangedC1 = UnChangedC1 + l/2;
        UnChangedC2 = UnChangedC2 + l/2;
    end
end

