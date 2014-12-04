function para_weightmode
%compare the performance of GNMF under different weight mode
clc;
clear;
addpath(pwd);
%dataset={'COIL20','PIE_pose27','TDT2'};
%dataset={'COIL20','PIE_pose27'};
dataset={'PIE_pose27'};
mode={'Binary','Cosine','HeatKernel','HeatKernel'};
p=3:10;
AC=zeros(length(mode),length(p));
NMI=zeros(length(mode),length(p));

disp('Changing the weighting mode of GNMF');
for i=1:length(dataset)
	load(char(dataset(i)));
	disp(['Dataset:',char(dataset(i))]);
	nClass = length(unique(gnd));

	%Normalize each data vector to have L2-norm equal to 1  
	fea = NormalizeFea(fea);
	for j=1:length(mode)
		for k=1:length(p)	
			%==============GNMF============
			%GNMF learning
			options = [];
			options.WeightMode = char(mode(j));  
			options.k=p(k);
			if j==3
				options.t=0.2;
			end
			if j==4
				options.t=0.5;
			end
			W = constructW(fea,options);
			options.maxIter = 100;
			options.alpha = 100;
			rand('twister',5489);
			[U,V] = GNMF(fea',nClass,W,options); %'

			%Clustering in the GNMF subspace
			rand('twister',5489);
			label = litekmeans(V,nClass,'Replicates',20);
			acc=accuracy(gnd,label);
			AC(j,k)=acc;
			MIhat = MutualInfo(gnd,label);
		    NMI(j,k)=MIhat;
		end
	end
	save(['result/',char(dataset(i)),'_weightmode','.mat'],'AC','NMI','p');
	
end
