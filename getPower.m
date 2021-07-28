
function [X, Y, Z] = getPower(fname, clip)

if nargin == 1,
    clip = -120;
end

M = dlmread(fname, ' ', 3, 0);

uX = length(unique(M(:, 2)));
uY = length(unique(M(:, 3)));

array_len = uX * uY;
s=size(M(:,2),1);

if array_len > s
   M(s+1,2)=M(s,2); 
end
 
X = reshape(M(1:array_len,2), uX, uY);
Y = reshape(M(1:array_len,3), uX, uY);
Z = reshape(M(1:array_len,6), uX, uY);

Z(Z(:) < clip) = clip;
