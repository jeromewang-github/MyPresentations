function B = LSDAm_compress(X, model, kernel, maxbits)

B = X * model.P;
medianB= mean(B);%each row vector of Y is a data point
B = (B>repmat(medianB,size(B,1),1));

end