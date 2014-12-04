function Y = LapEig(X, options, d)
% Laplacian Eigenmap

W = constructW(X,options);

D = sparse(diag(sum(W)));

L = D - W;

options = [];
options.disp = 0;
[eigVecs,eigVals] = eigs(L,D,1+d,'sa',options);
Y = eigVecs(:,2:end);

end
