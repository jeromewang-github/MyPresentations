function para_weightmode_plot
%Comparing the algoriths(Kmeans,PCA,Normalized Cut,NMF and GNMF) in clustering
clc;
clear;
addpath(pwd);
%dataset={'COIL20','PIE_pose27','TDT2'};
dataset={'COIL20','PIE_pose27'};
mode={'Binary','Cosine','HeatKernel','HeatKernel'};

for i=1:length(dataset)
	disp(['Dataset:',char(dataset(i))]);
	load(['result/',char(dataset(i)),'_weightmode','.mat']);%,'AC','NMI','p');

	
	%===========ploting=========
	colours = 'bgrkcmy';  % 'bgrcmykw'
	symbols = 'x+^oshd';  % '.ox+*sdv^<>ph'
	linetypes = {'-','-','-','-','-','-','-','-'};  % {'-',':','-.','--'}
	legend_list={'0-1 weighting','Dot-product weighting','Heat kernel weighting(\sigma=0.2)','Heat kernel weighting(\sigma=0.5)'};
	
	figure;%Accuracy
	for g = 1:length(mode)
		plot(p, 100*AC(g,:), [colours(g),symbols(g),char(linetypes(g))],'lineWidth',2); 
		hold on;
	end
	xlabel('p');
	ylabel('Accuracy(%)');
	legend(legend_list, 'location', 'SouthEast');
	title([char(dataset(i)),',Adjusting weigthing scheme']);
	saveas(gcf,['fig/',char(dataset(i)),'_weightmode_AC','.fig'],'fig');
	
	figure;%NMI
	for g = 1:length(mode)
		plot(p, 100*NMI(g,:), [colours(g),symbols(g),char(linetypes(g))],'lineWidth',2); 
		hold on;
	end
	xlabel('p');
	ylabel('Normalized mutual Information(%)');
	legend(legend_list, 'location', 'SouthEast');
	title([char(dataset(i)),',Adjusting weigthing scheme']);
	saveas(gcf,['fig/',char(dataset(i)),'_weightmode_NMI','.fig'],'fig');
end
