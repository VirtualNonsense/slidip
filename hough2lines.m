function [outmatrix] = hough2lines(houghmatrix,d,alpha,picsize,maxdistance,weight)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


% linevector = [];
% 
% [row,col] = find(houghmatrix ~= 0);
% 
% for index = 1:size(row,1)
%     linevector = [linevector;
%         alpha(row(index)),d(col(index))];
% end

linevector = getmaxhoughpoints(houghmatrix,maxdistance,weight);

%[x,y] = size(houghmatrix);
outmatrix = zeros(picsize);

for k = 1:size(linevector,1)
  alpha = linevector(k,1);
  d = linevector(k,2);
  
  for l = 1:size(outmatrix,1)
      for m = 1:size(outmatrix,2)
          if abs((cos(alpha)*l+sin(alpha)*m)-d) < 0.5 %an dem Parameter kann man viel rumspielen
              outmatrix(l,m) = 1;
          end
      end
  end
  
end



end

