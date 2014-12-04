function Sparseness_study(nClass)

clear;
addpath(pwd);
dataset={'COIL20'};%,'PIE_pose27','TDT2'};

if ~exist('nClass','var')
	nClass=36;
end


for i=1:length(dataset)
	load(char(dataset(i)));
	disp(['Dataset:',char(dataset(i))]);

	%Normalize each data vector to have L2-norm equal to 1  
	fea = NormalizeFea(fea);

	%===============NMF==============
	%NMF learning
	options = [];
	options.maxIter = 100;
	options.alpha = 0;
	%when alpha = 0, GNMF boils down to the ordinary NMF.
	rand('twister',5489);
	[U,V] = GNMF(fea',nClass,[],options); %'
	%Draw the basis on a square picture
	dim=size(U,1)^0.5;%root of the dimension of each basis
	col=nClass^0.5;
	figure;
	map=zeros(dim+2,dim+2,col,col);
	for j=1:nClass
		for k=1:nClass
			map(1:dim,1:dim,j,k=reshape(U(:,j),dim,dim);
	end
	saveas(gcf,['fig/',char(dataset(i)),'_sparseness_NMF','.fig'],'fig');

	%==============GNMF============
	%GNMF learning
	options = [];
	options.WeightMode = 'Binary';  
	W = constructW(fea,options);
	options.maxIter = 100;
	options.alpha = 100;
	rand('twister',5489);
	[U,V] = GNMF(fea',nClass,W,options); %'
	
	%Draw the basis on a square picture
	dim=size(U,1)^0.5;%root of the dimension of each basis
	col=nClass^0.5;
	figure;
	for j=1:nClass
		tmp=reshape(U(:,j),dim,dim);
		subplot(col,col,j);
		imshow(tmp);
	end
	saveas(gcf,['fig/',char(dataset(i)),'_sparseness_GNMF','.fig'],'fig');
end
