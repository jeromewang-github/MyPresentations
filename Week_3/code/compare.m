function compare
%Comparing the algoriths(Kmeans,PCA,Normalized Cut,NMF and GNMF) in clustering
clear;
addpath(pwd);
%dataset={'COIL20','PIE_pose27','TDT2'};
dataset={'COIL20','PIE_pose27'};

K1=[4 6 8 10 12 14 16 18 20];%COIL20
K2=[10 20 30 40 50 60 68];%PIE_pose27
K3=[5 10 15 20 25 30];%TDT2
K_all={K1,K2,K3};


for i=1:length(dataset)
	load(char(dataset(i)));
	disp(['Dataset:',char(dataset(i))]);
	%nClass = length(unique(gnd));

	%Normalize each data vector to have L2-norm equal to 1  
	fea = NormalizeFea(fea);
	
	K=K_all{i};
	AC=zeros(length(K),5);
	NMI=zeros(length(K),5);
	for k=1:length(K)
	
		nClass=K(k);
		%=============Kmeans=============
		%Clustering in the original space
		rand('twister',5489);
		label = litekmeans(fea,nClass,'Replicates',20);
		acc=accuracy(gnd,label);
		AC(k,1)=acc;
		MIhat = MutualInfo(gnd,label);
		NMI(k,1)=MIhat;
		disp(['Clustering in the Kmeans space. MIhat: ',num2str(MIhat),' accracy: ',num2str(acc)]);
		
		
		%=============PCA==============
		%PCA learning
		eigvector = PCA(fea);
		Y = fea*eigvector;
		%clustering in PCA 
		rand('twister',5489);
		label = litekmeans(Y,nClass,'Replicates',20);
		acc=accuracy(gnd,label);
		AC(k,2)=acc;
		MIhat = MutualInfo(gnd,label);
		NMI(k,2)=MIhat;
		disp(['Clustering in the PCA subspace. MIhat: ',num2str(MIhat),' accracy: ',num2str(acc)]);
		

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
		AC(k,3)=acc;
		MIhat = MutualInfo(gnd,label);
		NMI(k,3)=MIhat;
		disp(['Clustering in the Ncut subspace. MIhat: ',num2str(MIhat),' accracy: ',num2str(acc)]);

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
		AC(k,4)=acc;
		MIhat = MutualInfo(gnd,label);
		NMI(k,4)=MIhat;
		disp(['Clustering in the NMF subspace. MIhat: ',num2str(MIhat),' accracy: ',num2str(acc)]);

		%==============GNMF============
		%GNMF learning
		options = [];
		options.WeightMode = 'Binary';  
		W = constructW(fea,options);
		options.maxIter = 100;
		options.alpha = 100;
		rand('twister',5489);
		[U,V] = GNMF(fea',nClass,W,options); %'

		%Clustering in the GNMF subspace
		rand('twister',5489);
		label = litekmeans(V,nClass,'Replicates',20);
		acc=accuracy(gnd,label);
		AC(k,5)=acc;
		MIhat = MutualInfo(gnd,label);
		NMI(k,5)=MIhat;
		disp(['Clustering in the GNMF subspace. MIhat: ',num2str(MIhat),' accracy: ',num2str(acc)]);
	end
	save(['result/',char(dataset(i)),'_compare','.mat'],'AC','NMI','K');
end