function doExperiment(dataset, alg)
% doExperiment: Learning to Hash
% Dell Zhang
% Birkbeck, University of London

addpath(pwd);
addpath('./libsvm-mat-weights-3.0-1/');

timeTrainAll=0;
timeTestAll=0;

lambda=0:0.2:1;
for idx=1:length(lambda)
	%% 
	load(['testbed/',dataset]);
	f_learn = eval(['@',alg,'_learn']);%Using function handle.
	f_compress = eval(['@',alg,'_compress']);


	%%
	codeLen = 10:2:32;
	hammRadius = 0:3;
	maxbits = codeLen(end);

	tic;
	[model, codeTrain] = f_learn(feaTrain, gndTrain, k, metric, kernel, maxbits,lambda(idx));%Training
	timeTrain = toc;
	timeTrainAll=timeTrainAll+timeTrain;

	tic;
	codeTest = f_compress(feaTest, model, kernel, maxbits);%Predicting
	timeTest = toc;
	timeTestAll=timeTestAll+timeTest;
	disp([timeTrain, timeTest]);

	%%
	m = length(codeLen);
	n = length(hammRadius);
	trueP = zeros(m,n);
	trueR = zeros(m,n);
	cateP = zeros(m,n);
	cateR = zeros(m,n);
	cateA = zeros(m,n);
	for i = 1:m
		nbits = codeLen(i);
		disp(nbits);
		%Compacting the binary string,every 8 chars constitute a 'uint8' word
		cbTrain = compactbit(codeTrain(:,1:nbits));
		cbTest  = compactbit(codeTest(:,1:nbits));
		hammTrainTest  = hammingDist(cbTest,cbTrain)';%Calclulate the hamming distance.
		for j = 1:n
			Ret = (hammTrainTest <= hammRadius(j)+0.00001);%retrieved train documents for each test document
			[trueP(i,j), trueR(i,j)] = evaluate_macro(trueTrainTest, Ret);%According to KNN
			[cateP(i,j), cateR(i,j)] = evaluate_macro(cateTrainTest, Ret);%According to category infomation.
			cateA(i,j) = evaluate_classification(gndTrain, gndTest, Ret);
		end
	end
	trueF1 = F1_measure(trueP, trueR);
	cateF1 = F1_measure(cateP, cateR);

	%%
	clear feaTrain feaTest;
	clear gndTrain gndTest;
	clear trueTrainTest cateTrainTest;
	clear hammTrainTest Ret;
	save(['result/',dataset,'_',alg,'_lambda_',num2str(lambda(idx)),'.mat']);
end
timeTrainAvg=timeTrainAll/length(lambda);
timeTestAvg=timeTestAll/length(lambda);
save(['time/',dataset,'_',alg,'.mat'],'timeTrainAll','timeTestAll','timeTrainAvg','timeTestAvg');

clear;
end
