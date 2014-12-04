function para_lambda_plot
%Comparing the algoriths(Kmeans,PCA,Normalized Cut,NMF and GNMF) in clustering
clc;
clear;
addpath(pwd);
%dataset={'COIL20','PIE_pose27','TDT2'};
dataset={'COIL20','PIE_pose27'};
%lambda=10.^[0 (1-0.2) (1+0.2) (2-0.2) (2+0.2) (3-0.2) (3+0.2) (4-0.2) (4+0.2)];
%AC=zeros(5,length(lambda));

for i=1:length(dataset)
	disp(['Dataset:',char(dataset(i))]);
	load(['result/',char(dataset(i)),'_lambda','.mat']);

	%===========ploting=========
	colours = 'bgrkcmy';  % 'bgrcmykw'
	symbols = 'x+^oshd';  % '.ox+*sdv^<>ph'
	linetypes = {'-','-','-','-','-','-','-','-'};  % {'-',':','-.','--'}
	legend_list={'Kmeans','PCA','NCut','NMF','GNMF'};
	figure;
	for g = 1:5
		semilogx(lambda, 100*AC(g,:), [colours(g),symbols(g),char(linetypes(g))],'lineWidth',2); 
		hold on;
	end
	xlabel('\lambda');
	ylabel('Accuracy(%)');
	%axis([x(1) x(m)  0 100]);
	legend(legend_list, 'location', 'SouthEast');
	title([char(dataset(i)),',Adjusting \lambda']);
	saveas(gcf,['fig/',char(dataset(i)),'_lambda','.fig'],'fig');

end
