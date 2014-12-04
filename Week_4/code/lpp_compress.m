function B = LDPH_compress(X, model, kernel, maxbits)
% X(n*m) is a matrix of training data,each row vector is a smaple.
% model.P(m*d) is the projection matrix.
B = X * model.P;
medianB= mean(B);%each row vector of Y is a data point
B = (B>repmat(medianB,size(B,1),1));%Get the binary code of B.
end