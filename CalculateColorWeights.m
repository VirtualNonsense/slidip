function [UnChangedC1,UnChangedC2] = CalculateColorWeights(ChangedC, UnChangedC1, UnChangedC2)
    leftSpace = 100 - ChangedC;    
    if leftSpace < UnChangedC1 + UnChangedC2
        UnChangedC1 = leftSpace * UnChangedC1/100;
        UnChangedC2 = leftSpace * UnChangedC2/100;
        l = leftSpace - UnChangedC1 - UnChangedC2;
        UnChangedC1 = UnChangedC1 + l/2;
        UnChangedC2 = UnChangedC2 + l/2;
    end
end

