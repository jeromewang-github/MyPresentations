function [model , Y]  = DOLSH_learn(feaTrain, gndTrain, k, metric, kernel, maxbits,lambda)
%[signals,P,V] = pca1(data,dim)
% PCA1: Perform PCA using covariance.
% data - MxN matrix of input data,each column vector is a sample.(M dimensions, N trials)
% P - each column is a Principal Component
% V - Mx1 matrix of variances
% dim - the number of Principal Components selected
data = feaTrain';
dim = maxbits;
[M,N] = size(data);
% subtract off the mean for each dimension
mn = mean(data,2);
data = data - repmat(mn,1,N);
[P,V]=eigs(data*data',dim,'lm');
model.P = P;
Y = DOLSH_compress(feaTrain, model, kernel, maxbits);
end