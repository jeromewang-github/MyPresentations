function compare
%Comparing the algoriths(Kmeans,PCA,Normalized Cut,NMF and GNMF) in clustering
clear;
addpath(pwd);
dataset={'ORL_32x32','Yale_32x32'};


for i=1:length(dataset)
	if i==1
		load(['data/ORL/',char(dataset(i))]);
	else
		load(['data/Yale/',char(dataset(i))]);
	end
	
	disp(['Dataset:',char(dataset(i))]);
	nClass = length(unique(gnd));
	
	%Preprocessing the data Using the following code
	%===========================================
	[nSmp,nFea] = size(fea);
	for t = 1:nSmp
	fea(t,:) = fea(t,:) ./ max(1e-12,norm(fea(t,:)));
	end
	%===========================================
	%Scale the features (pixel values) to [0,1]
	%===========================================
	maxValue = max(max(fea));
	fea = fea/maxValue;
	%===========================================
	
	splits=20;
	AC=zeros(5,7);
	for k=2:8 %k images were randomly selected as training samples for each individual
		disp([num2str(k),' images were randomly selected as training samples for each individual']);
		for j=1:splits %testing over 20 random splits
			if i==1
				load(['data/ORL/',num2str(k),'Train/',num2str(j)]);
			else 
				load(['data/Yale/',num2str(k),'Train/',num2str(j)]);
			end
			%===========================================
			fea_Train = fea(trainIdx,:);
			fea_Test = fea(testIdx,:);
			gnd_Train = gnd(trainIdx);
			gnd_Test = gnd(testIdx);
			%===========================================
			
			%=============Baseline=============
			%Clustering in the original space
			rand('twister',5489);
			label = litekmeans(fea_Test,nClass,'Replicates',20);
			acc=accuracy(gnd_Test,label);
			AC(1,k-1)=AC(1,k-1)+acc;
			disp(['Clustering in the Baseline. accracy: ',num2str(acc)]);
			
			
			%=============PCA==============
			%PCA learning
			options = [];
			options.ReducedDim=nClass*k-1;
			eigvector = PCA(fea_Train,options);
			Y = fea_Test*eigvector;
			%clustering in PCA 
			rand('twister',5489);
			label = litekmeans(Y,nClass,'Replicates',20);
			acc=accuracy(gnd_Test,label);
			AC(2,k-1)=AC(2,k-1)+acc;
			disp(['Clustering in the PCA. accracy: ',num2str(acc)]);
			

			%==========LDA========
			options = [];
			options.PCARatio=nClass-1;
			[eigvector, eigvalue] = LDA(gnd_Train, options, fea_Train);
			Y = fea_Test*eigvector;
			rand('twister',5489);
			label = litekmeans(Y,nClass,'Replicates',20);
			acc=accuracy(gnd_Test,label);
			AC(3,k-1)=AC(3,k-1)+acc;
			disp(['Clustering in the LDA. accracy: ',num2str(acc)]);

			%===============MFA==============
			options = [];
			options.intraK = 5;
			options.interK = 5;
			options.Regu = 1;
			options.PCARatio=nClass-1;
			[eigvector, eigvalue] = MFA(gnd_Train, options, fea_Train);
			Y = fea_Test*eigvector;
			rand('twister',5489);
			label = litekmeans(Y,nClass,'Replicates',20);
			acc=accuracy(gnd_Test,label);
			AC(4,k-1)=AC(4,k-1)+acc;
			disp(['Clustering in the MFA. accracy: ',num2str(acc)]);

			%==============LSDA============
			options = [];
			options.k = 5;
			[eigvector, eigvalue] = LSDA(gnd_Train, options, fea_Train);
			Y = fea_Test*eigvector;
			rand('twister',5489);
			label = litekmeans(Y,nClass,'Replicates',20);
			acc=accuracy(gnd_Test,label);
			AC(5,k-1)=AC(5,k-1)+acc;
			disp(['Clustering in the LSDA. accracy: ',num2str(acc)]);
		end		
	end
	AC=AC/splits;
	save(['result/',char(dataset(i)),'_compare','.mat'],'AC');
end