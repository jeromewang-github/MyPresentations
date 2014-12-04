function iterator_plot
%Comparing the algoriths(Kmeans,PCA,Normalized Cut,NMF and GNMF) in clustering
clear;
addpath(pwd);
dataset={'COIL20','PIE_pose27','TDT2'};


for i=1:length(dataset)
	load(char(dataset(i)));
	disp(['Dataset:',char(dataset(i))]);
	nClass = length(unique(gnd));

	%Normalize each data vector to have L2-norm equal to 1  
	fea = NormalizeFea(fea);

	%===============NMF==============
	%NMF learning
	options = [];
	options.maxIter = 100;
	options.alpha = 0;
	%when alpha = 0, GNMF boils down to the ordinary NMF.
	rand('twister',5489);
	[U,V,nIter_final,objhistory_final] = GNMF(fea',nClass,[],options); %'
	
	%===========ploting=========	
	figure;
	plot(1:nIter_final, objhistory_final,'lineWidth',2); 
	xlabel('Iteration#');
	ylabel('Objective function value');
	title([char(dataset(i)),',Convergence']);
	saveas(gcf,['fig/',char(dataset(i)),'_iter_NMF','.fig'],'fig');


	%==============GNMF============
	%GNMF learning
	options = [];
	options.WeightMode = 'Binary';  
	W = constructW(fea,options);
	options.maxIter = 100;
	options.alpha = 100;
	rand('twister',5489);
	[U,V,nIter_final, objhistory_final] = GNMF(fea',nClass,W,options); %'
	
	%===========ploting=========	
	figure;
	plot(1:nIter_final, objhistory_final,'lineWidth',2); 
	xlabel('Iteration#');
	ylabel('Objective function value');
	title([char(dataset(i)),',Convergence']);
	saveas(gcf,['fig/',char(dataset(i)),'_iter_GNMF','.fig'],'fig');
end

end

%========Calculating the accuracy===========
function [res]=accuracy(gnd,label)
	if length(gnd)~=length(label)
		error('length(gnd) must == length(label)');
	end
	nSmp=length(gnd);
	all=sum(gnd==label);
	res=all/nSmp;
end