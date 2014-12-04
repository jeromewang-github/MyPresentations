function acc = evaluate_classification(gndTrain, gndTest, Ret)
% evaluate knn classification performance
% Input:
%    gndTrain = the true class labels of training documents
%    gndTest  = the true class labels of testing  documents
%    Ret = retrieved train documents for each test document
% Output:
%    acc = classification accuracy

numTest = length(gndTest);
correct = zeros(1,numTest);

for j = 1:numTest
    class_pred = uint8(mode(single(gndTrain(Ret(:,j)))));%M=mode(X):most frequent value in a sample
    class_true = gndTest(j);
    if (class_pred == class_true)
        correct(j) = 1;
    end
end

acc = mean(correct);

end
