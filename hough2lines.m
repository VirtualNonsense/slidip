function [outmatrix] = hough2lines(houghmatrix,picsize,pistep, dstep)
%UNTITLED Summary of this function goes here

%linevector = getmaxhoughpoints(houghmatrix,maxdistance,weight);
[row,col] = find(houghmatrix~=0);
linevector = [row,col];

%[x,y] = size(houghmatrix);
%colormap white
%imagesc(outmatrix(:,:));

tmax = (picsize(1)+picsize(2))*pi;
tmin = -tmax;
outmatrix = zeros(size(linevector,1),2,2);
for k = 1:size(linevector,1)
  alpha = linevector(k,1)*pistep;
  d = linevector(k,2)*dstep;
  minpoint = [cos(alpha)*d + tmin*sin(alpha),sin(alpha)*d+tmin*cos(alpha)];
  outmatrix(k,:,1) = minpoint;
  maxpoint = [cos(alpha)*d + tmax*sin(alpha), sin(alpha)*d+tmax*cos(alpha)];
  outmatrix(k,:,2) = maxpoint;
end



end

