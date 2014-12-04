function B = STH_compress(X, model, kernel, maxbits)

Nsamples = size(X,1);

U = zeros(Nsamples,maxbits);
y = zeros(Nsamples,1);

if strcmp(kernel,'Linear')
    for p = 1:maxbits
        U(:,p) = svmpredict(y,X,model{p});
    end
end
if strcmp(kernel,'Gaussian')
    for p = 1:maxbits
        U(:,p) = svmpredict(y,X,model{p});
    end
end

B = (U>0.5);

end
