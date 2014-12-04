function M = knnMat(D,k,bSelf)
%knnMat Create the k-nearest-neighbours matrix based on the distance matrix
%   D:  the nTrain x nTest distance matrix
%   k:  the number of nearest neighbours
%   bSelf:  whether self is excluded (default false)

if ~exist('bSelf','var')
    bSelf = false;
end
if (size(D,1) ~= size(D,2))
    bSelf = false;
end

if bSelf
    D(logical(eye(size(D)))) = Inf;
end

[Y,I] = sort(D);

M = false(size(D));
for j = 1:size(D,2)
    M(I(1:k,j),j) = true;
end

end
