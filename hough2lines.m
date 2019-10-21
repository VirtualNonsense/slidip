function [outmatrix] = hough2lines(houghmatrix,pistep,dstep,d,alpha,picsize)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



linevector = [];

[row,col] = find(houghmatrix ~= 0);

for index = 1:size(row,1)
    linevector = [linevector;
        alpha(row(index)),d(col(index))];
end

[x,y] = size(houghmatrix);
outmatrix = zeros(picsize);

for k = 1:size(linevector,1)
  alpha = linevector(k,1);
  d = linevector(k,2);
  
  for l = 1:size(outmatrix,1)
      for m = 1:size(outmatrix,2)
          if abs((cos(alpha)*l+sin(alpha)*m)-d) < 10
              outmatrix(l,m) = 1;
          end
      end
  end
  
end



end

