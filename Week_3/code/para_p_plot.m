function para_p_plot
%Comparing the algoriths(Kmeans,PCA,Normalized Cut,NMF and GNMF) in clustering
clc;
clear;
addpath(pwd);
%dataset={'COIL20','PIE_pose27','TDT2'};
dataset={'COIL20','PIE_pose27'};

for i=1:length(dataset)
	disp(['Dataset:',char(dataset(i))]);
	load(['result/',char(dataset(i)),'_p','.mat']);
	
	%===========ploting=========
	colours = 'bgrkcmy';  % 'bgrcmykw'
	symbols = 'x+^oshd';  % '.ox+*sdv^<>ph'
	linetypes = {'-','-','-','-','-','-','-','-'};  % {'-',':','-.','--'}
	legend_list={'Kmeans','PCA','NCut','NMF','GNMF'};
	
	figure;
	for g = 1:5
		plot(p, 100*AC(g,:), [colours(g),symbols(g),char(linetypes(g))],'lineWidth',2); 
		hold on;
	end
	xlabel('p');
	ylabel('Accuracy(%)');
	legend(legend_list, 'location', 'SouthEast');
	title([char(dataset(i)),',Adjusting p']);
	saveas(gcf,['fig/',char(dataset(i)),'_p','.fig'],'fig');

end
