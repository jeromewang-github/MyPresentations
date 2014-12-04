function [model, B] = STH_learn(X, gnd, k, metric, kernel, maxbits,lambda)

options = [];
options.NeighborMode = 'KNN';
if strcmp(metric,'Cosine')
    options.Metric = 'Cosine';
    options.WeightMode = 'Cosine';
    options.bNormalized = 1;
end
if strcmp(metric,'Euclidean')
    options.Metric = 'Euclidean';
    options.WeightMode = 'HeatKernel';
    options.t = 1; %sqrt(1/length(X));
end
options.bSelfConnected = 0;
options.k = k;

Y = LapEig(X,options,maxbits);

%B = double(Y>0)
Z = repmat(median(Y),size(Y,1),1);
B = double(Y>Z);

% model = cell(1,maxbits);
if strcmp(kernel,'Linear')
    for p = 1:maxbits
%         model(p) = {svmtrain([],B(:,p),X,'-q')};
         model(p) = {svmtrain([],B(:,p),X, '-t 0')};
    end
end
if strcmp(kernel,'Gaussian')
    for p = 1:maxbits
        model(p) = {svmtrain([],B(:,p),X,['-q -c 1 -g ',int2str(length(X))])};
    end
end

end
