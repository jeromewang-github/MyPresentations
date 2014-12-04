function prepare_dataset(dataset,k)

%%
load(['data/',dataset]);

if (strcmp(dataset,'Reuters21578'))
    top10CatIdx = find(gnd<=10);  % only use the top 10 categories(categories:1:65)
    trainIdx = intersect(top10CatIdx,trainIdx);%Using intersection of two sets to get the index.
    testIdx  = intersect(top10CatIdx,testIdx);
	%load('data/10Class/13.mat');
	%fea(:,zeroIdx)=[];
%     tempIdx = randperm(size(trainIdx,1));%A random permutation of intergers from 1 to n
%     trainIdx = trainIdx(tempIdx(1:4000));
%     tempIdx = randperm(size(testIdx,1));
%     testIdx = testIdx(tempIdx(1:200));

    [feaTrain,feaTest] = tf_idf(fea(trainIdx,:),fea(testIdx,:));
    feaTrain = normalize(feaTrain);%Normalize all feature vectors to unit length
    feaTest  = normalize(feaTest);
	
    metric = 'Cosine';
    kernel = 'Linear';
end

if (strcmp(dataset,'20Newsgroups'))
%     tempIdx = randperm(size(trainIdx,1));
%     trainIdx = trainIdx(tempIdx(1:1000));
%     tempIdx = randperm(size(testIdx,1));
%     testIdx = testIdx(tempIdx(1:200));
	%Dim=size(fea,2);
	%zeroIdx=randint(1,Dim-10000,Dim);
	%fea(:,zeroIdx)=[];
    [feaTrain,feaTest] = tf_idf(fea(trainIdx,:),fea(testIdx,:));
    feaTrain = normalize(feaTrain);
    feaTest  = normalize(feaTest);
	
	%PCA Processing
	%ReducedDim=4000;
	%P=myPCA(feaTrain,ReducedDim);
	%feaTrain=feaTrain*P;
	%P=myPCA(feaTest,ReducedDim);
	%feaTest=feaTest*P;
	
    metric = 'Euclidean' ;
    %    metric = 'Cosine';
    kernel = 'Linear';
end

if (strcmp(dataset,'USPS'))
    split = 0.6;   % 60 percent training, 40 percent testing
    randIdx = rand(size(fea,1),1);
    trainIdx = find(randIdx <= split);
    testIdx  = find(randIdx >  split);
%     tempIdx = randperm(size(trainIdx,1));
%     trainIdx = trainIdx(tempIdx(1:1000));
%     tempIdx = randperm(size(testIdx,1));
%     testIdx = testIdx(tempIdx(1:200));
    feaTrain = fea(trainIdx,:);
    feaTest = fea(testIdx,:);
    feaTrain = normalize(feaTrain);
    feaTest  = normalize(feaTest);
    metric = 'Cosine';
    kernel = 'Linear';
end

if (strcmp(dataset,'COIL100'))
    split = 0.6;   % 60 percent training, 40 percent testing
    randIdx = rand(size(fea,1),1);
    trainIdx = find(randIdx <= split);
    testIdx  = find(randIdx >  split);
%     tempIdx = randperm(size(trainIdx,1));
%     trainIdx = trainIdx(tempIdx(1:1000));
%     tempIdx = randperm(size(testIdx,1));
%     testIdx = testIdx(tempIdx(1:200));
    feaTrain = fea(trainIdx,:);
    feaTest = fea(testIdx,:);
    feaTrain = normalize(feaTrain);
    feaTest  = normalize(feaTest);
    metric = 'Cosine';
    kernel = 'Linear';
end


if (strcmp(dataset,'TDT2'))
    split = 0.6;   % 60 percent training, 40 percent testing
    randIdx = rand(size(fea,1),1);
    trainIdx = find(randIdx <= split);
    testIdx  = find(randIdx >  split);
%     tempIdx = randperm(size(trainIdx,1));
%     trainIdx = trainIdx(tempIdx(1:1000));
%     tempIdx = randperm(size(testIdx,1));
%     testIdx = testIdx(tempIdx(1:200));
    [feaTrain,feaTest] = tf_idf(fea(trainIdx,:),fea(testIdx,:));
    feaTrain = normalize(feaTrain);
    feaTest  = normalize(feaTest);
    metric = 'Cosine';
    kernel = 'Linear';
end

if (strcmp(dataset,'2k2k'))
    feaTrain = fea(trainIdx,:);
    feaTest = fea(testIdx,:);
    feaTrain = normalize(feaTrain);
    feaTest  = normalize(feaTest);
    metric = 'Euclidean' ;
    %     metric = 'Cosine';
    kernel = 'Linear';
end

if (strcmp(dataset,'PIE'))
    split = 0.6;   % 60 percent training, 40 percent testing
    randIdx = rand(size(fea,1),1);
    trainIdx = find(randIdx <= split);
    testIdx  = find(randIdx >  split);
    tempIdx = randperm(size(trainIdx,1));
    trainIdx = trainIdx(tempIdx(1:5000));
    tempIdx = randperm(size(testIdx,1));
    testIdx = testIdx(tempIdx(1:1000));
    feaTrain = fea(trainIdx,:);
    feaTest = fea(testIdx,:);
    feaTrain = normalize(feaTrain);
    feaTest  = normalize(feaTest);
%     metric = 'Euclidean' ;
    metric = 'Cosine';
    kernel = 'Linear';
end

if (strcmp(dataset,'10kTrain'))
    split = 0.6;   % 60 percent training, 40 percent testing
    randIdx = rand(size(fea,1),1);
    trainIdx = find(randIdx <= split);
    testIdx  = find(randIdx >  split);
%     tempIdx = randperm(size(trainIdx,1));
%     trainIdx = trainIdx(tempIdx(1:1000));
%     tempIdx = randperm(size(testIdx,1));
%     testIdx = testIdx(tempIdx(1:200));
    feaTrain = fea(trainIdx,:);
    feaTest = fea(testIdx,:);
    feaTrain = normalize(feaTrain);
    feaTest  = normalize(feaTest);
    metric = 'Cosine';
    kernel = 'Linear';
end

if (strcmp(dataset,'YaleB_32x32'))
    split = 0.6;   % 60 percent training, 40 percent testing
    randIdx = rand(size(fea,1),1);
    trainIdx = find(randIdx <= split);
    testIdx  = find(randIdx >  split);
%     tempIdx = randperm(size(trainIdx,1));
%     trainIdx = trainIdx(tempIdx(1:1000));
%     tempIdx = randperm(size(testIdx,1));
%     testIdx = testIdx(tempIdx(1:200));
    feaTrain = fea(trainIdx,:);
    feaTest = fea(testIdx,:);
    feaTrain = normalize(feaTrain);
    feaTest  = normalize(feaTest);
    metric = 'Cosine';
    kernel = 'Linear';
end

if (strcmp(dataset,'Yale_32x32'))
    split = 0.6;   % 60 percent training, 40 percent testing
    randIdx = rand(size(fea,1),1);
    trainIdx = find(randIdx <= split);
    testIdx  = find(randIdx >  split);
%     tempIdx = randperm(size(trainIdx,1));
%     trainIdx = trainIdx(tempIdx(1:1000));
%     tempIdx = randperm(size(testIdx,1));
%     testIdx = testIdx(tempIdx(1:200));
    feaTrain = fea(trainIdx,:);
    feaTest = fea(testIdx,:);
    feaTrain = normalize(feaTrain);
    feaTest  = normalize(feaTest);
    metric = 'Cosine';
    kernel = 'Linear';
end

if (strcmp(dataset,'ORL_32x32'))
    split = 0.6;   % 60 percent training, 40 percent testing
    randIdx = rand(size(fea,1),1);
    trainIdx = find(randIdx <= split);
    testIdx  = find(randIdx >  split);
%     tempIdx = randperm(size(trainIdx,1));
%     trainIdx = trainIdx(tempIdx(1:1000));
%     tempIdx = randperm(size(testIdx,1));
%     testIdx = testIdx(tempIdx(1:200));
    feaTrain = fea(trainIdx,:);
    feaTest = fea(testIdx,:);
    feaTrain = normalize(feaTrain);
    feaTest  = normalize(feaTest);
    metric = 'Cosine';
    kernel = 'Linear';
end

if (strcmp(dataset,'Cifar-10'))
    split = 0.6;   % 60 percent training, 40 percent testing
    randIdx = rand(size(fea,1),1);
    trainIdx = find(randIdx <= split);
    testIdx  = find(randIdx >  split);
%     tempIdx = randperm(size(trainIdx,1));
%     trainIdx = trainIdx(tempIdx(1:1000));
%     tempIdx = randperm(size(testIdx,1));
%     testIdx = testIdx(tempIdx(1:200));
    feaTrain = fea(trainIdx,:);
    feaTest = fea(testIdx,:);
    feaTrain = normalize(feaTrain);
    feaTest  = normalize(feaTest);
    metric = 'Cosine';
    kernel = 'Linear';
end

if (strcmp(dataset,'Caltech-256'))
    split = 0.6;   % 60 percent training, 40 percent testing
    fea = fea(1:10000,:);
    gnd = gnd(1:10000,:);
    randIdx = rand(size(fea,1),1);
    trainIdx = find(randIdx <= split);
    testIdx  = find(randIdx >  split);
%     tempIdx = randperm(size(trainIdx,1));
%     trainIdx = trainIdx(tempIdx(1:1000));
%     tempIdx = randperm(size(testIdx,1));
%     testIdx = testIdx(tempIdx(1:200));
    feaTrain = fea(trainIdx,:);
    feaTest = fea(testIdx,:);
    feaTrain = normalize(feaTrain);
    feaTest  = normalize(feaTest);
    metric = 'Cosine';
    kernel = 'Linear';
end
clear fea;
numTrain = size(feaTrain,1);
numTest  = size(feaTest,1);
gndTrain = uint8(gnd(trainIdx));
gndTest  = uint8(gnd(testIdx));


% [nSmp,nFea]=size(feaTrain);
% classLabel=unique(gndTrain);
% calssNum=length(classLabel);
% W=zeros(nSmp,nSmp);
% tmp_data=zeros(nSmp,nFea);
% tmp_gnd=zeros(size(gndTrain));
% pos_start=1;
% for i=1:calssNum
%     idx=find(classLabel(i)==gndTrain);
% 	mk=length(idx);
% 	pos_end=pos_start+mk-1;
% 	W(pos_start:pos_end,pos_start:pos_end)=1/mk;
% 	tmp_data(pos_start:pos_end,:)=feaTrain(idx,:);
% 	tmp_gnd(pos_start:pos_end)=gndTrain(idx);
% 	pos_start=pos_end+1;
% end
% feaTrain=tmp_data;
% gndTrain=tmp_gnd;
% clear tmp_data;
% clear tmp_gnd;

%%

% the ground-truth k nearest neighbours
trueTrainTest = knnMat(EuDist2(feaTrain,feaTest),k,false);
trueTrainTrain = knnMat(EuDist2(feaTrain,feaTrain),k,false);
trueTestTest = knnMat(EuDist2(feaTest,feaTest),k,false);

% the documents in the same category
cateTrainTest = (repmat(gndTrain,1,numTest) == repmat(gndTest,1,numTrain)');
cateTrainTrain = (repmat(gndTrain,1,numTrain) == repmat(gndTrain,1,numTrain)');
cateTestTest = (repmat(gndTest,1,numTest) == repmat(gndTest,1,numTest)');


save(['testbed/',dataset],'feaTrain','feaTest','gndTrain','gndTest','k','metric',...
    'kernel','trueTrainTest','cateTrainTest','trueTrainTrain','cateTrainTrain',...
    'trueTestTest','cateTestTest');
clear;

end
