function compare_plot
%Comparing the algoriths(Kmeans,PCA,Normalized Cut,NMF and GNMF) in clustering
clear;
addpath(pwd);
%dataset={'COIL20','PIE_pose27','TDT2'};
dataset={'COIL20','PIE_pose27'};

for i=1:length(dataset)
	disp(['Dataset:',char(dataset(i))]);
	load(['result/',char(dataset(i)),'_compare','.mat']);

	%===========ploting=========
	colours = 'bgrkcmy';  % 'bgrcmykw'
	symbols = 'x+^oshd';  % '.ox+*sdv^<>ph'
	linetypes = {'-','-','-','-','-','-','-','-'};  % {'-',':','-.','--'}
	legend_list={'Kmeans','PCA','NCut','NMF','GNMF'};
	
	figure;
	for g = 1:5
		plot(K, 100*AC(:,g), [colours(g),symbols(g),char(linetypes(g))],'lineWidth',2); 
		hold on;
	end
	xlabel('K');
	ylabel('Accuracy(%)');
	legend(legend_list, 'location', 'SouthEast');
	title(['Clustering performance on ',char(dataset(i))]);
	saveas(gcf,['fig/',char(dataset(i)),'_performance_AC','.fig'],'fig');
	
	figure;
	for g = 1:5
		plot(K, 100*NMI(:,g), [colours(g),symbols(g),char(linetypes(g))],'lineWidth',2); 
		hold on;
	end
	xlabel('K');
	ylabel('Normalized Mutual Information(%)');
	legend(legend_list, 'location', 'SouthEast');
	title(['Clustering performance on ',char(dataset(i))]);
	saveas(gcf,['fig/',char(dataset(i)),'_performance_NMI','.fig'],'fig');
end