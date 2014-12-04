function para_lambda
%Comparing the algoriths(Kmeans,PCA,Normalized Cut,NMF and GNMF) in clustering when the lambda changes
clc;
clear;
addpath(pwd);
%dataset={'COIL20','PIE_pose27','TDT2'};
dataset={'COIL20','PIE_pose27'};

disp('Adjusting the parameter \lambda');
for i=1:length(dataset)
	load(char(dataset(i)));
	disp(['Dataset:',char(dataset(i))]);
	nClass = length(unique(gnd));

	%Normalize each data vector to have L2-norm equal to 1  
	fea = NormalizeFea(fea);
	
	%=============Kmeans=============
	%Clustering in the original space
	rand('twister',5489);
	label = litekmeans(fea,nClass,'Replicates',20);
	acc=accuracy(gnd,label);
	AC(1,1)=acc;
	
	
	%=============PCA==============
	%PCA learning
	options=[];
	options.ReducedDim=nClass;
	[eigvector, eigvalue] = PCA(fea, options);
	Y = fea*eigvector;
	%clustering in PCA 
	rand('twister',5489);
	label = litekmeans(Y,nClass,'Replicates',20);
	acc=accuracy(gnd,label);
	AC(2,1)=acc;
	

	%==========Normalized Cut========
	cd('Ncut_9');
	% compute similarity matrix
	data=fea';
	W = compute_relation(data);
	% clustering graph in
	NcutDiscrete= ncutW(W,nClass);
	%Clustering in the Ncut
	cd('..');
	rand('twister',5489);
	label = litekmeans(NcutDiscrete,nClass,'Replicates',20);
	acc=accuracy(gnd,label);
	AC(3,1)=acc;


	%===============NMF==============
	%NMF learning
	options = [];
	options.maxIter = 100;
	options.alpha = 0;
	%when alpha = 0, GNMF boils down to the ordinary NMF.
	rand('twister',5489);
	[U,V] = GNMF(fea',nClass,[],options); %'

	%Clustering in the NMF subspace
	rand('twister',5489);
	label = litekmeans(V,nClass,'Replicates',20);
	acc=accuracy(gnd,label);
	AC(4,1)=acc;
		
	for k=1:length(lambda)%only GNMF changes
		%==============GNMF============
		%GNMF learning
		options = [];
		options.WeightMode = 'Binary';  
		W = constructW(fea,options);
		options.maxIter = 100;
		options.alpha = lambda(k);
		rand('twister',5489);
		[U,V] = GNMF(fea',nClass,W,options); %'

		%Clustering in the GNMF subspace
		rand('twister',5489);
		label = litekmeans(V,nClass,'Replicates',20);
		acc=accuracy(gnd,label);
		AC(1:4,k)=AC(1:4,1);
		AC(5,k)=acc;
	end
	save(['result/',char(dataset(i)),'_lambda','.mat'],'AC','lambda');	

end
