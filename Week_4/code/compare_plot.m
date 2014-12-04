function compare_plot
%Comparing the algoriths(Kmeans,PCA,Normalized Cut,NMF and GNMF) in clustering
clear;
addpath(pwd);
dataset={'ORL_32x32','Yale_32x32'};

for i=1:length(dataset)
	disp(['Dataset:',char(dataset(i))]);
	load(['result/',char(dataset(i)),'_compare','.mat'],'AC');

	%===========ploting=========
	colours = 'bgrkcmy';  % 'bgrcmykw'
	symbols = 'x+^oshd';  % '.ox+*sdv^<>ph'
	linetypes = {'-','-','-','-','-','-','-','-'};  % {'-',':','-.','--'}
	legend_list={'Baseline','PCA','LDA','MFA','LSDA'};
	
	figure;
	for g = 1:5
		plot(2:8, 100*AC(g,:), [colours(g),symbols(g),char(linetypes(g))],'lineWidth',2); 
		hold on;
	end
	xlabel('training samples for each individual');
	ylabel('Accuracy(%)');
	legend(legend_list, 'location', 'SouthEast');
	title(['Clustering performance on ',char(dataset(i))]);
	saveas(gcf,['fig/',char(dataset(i)),'_performance_AC','.fig'],'fig');
end