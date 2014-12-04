function show_results(dataset,h)

%%
if nargin < 2
    h = 1;
end
j = h+1;  % hamming ball radius <= h

lambda_arr=0:0.2:1;
for idx_lambda = 1: length(lambda_arr)
	%% Load Experimental Results
	alg_list = {'STH','DOLSH','LSDA','LSDAm'};
	alg_num = length(alg_list);
	
	trueP_list = cell([1,alg_num]);
	trueR_list = cell([1,alg_num]);
	trueF1_list = cell([1,alg_num]);
	cateP_list = cell([1,alg_num]);
	cateR_list = cell([1,alg_num]);
	cateF1_list = cell([1,alg_num]);
	cateA_list = cell([1,alg_num]);
	for g = 1:alg_num
		if g==3||g==4
			load(['result/',dataset,'_',alg_list{g},'_lambda_',num2str(lambda_arr(idx_lambda)),'.mat']);
		else 
			load(['result/',dataset,'_',alg_list{g},'.mat']);
		end
		trueP_list{g} = trueP;
		trueR_list{g} = trueR;
		trueF1_list{g} = trueF1;
		clear trueP trueR trueF1;
		cateP_list{g} = cateP;
		cateR_list{g} = cateR;
		cateF1_list{g} = cateF1;
		clear cateP cateR cateF1;
		cateA_list{g} = cateA;
		clear cateA;
	end

	%%
	colours = 'bgrkcmy';  % 'bgrcmykw'
	symbols = 'x+^oshd';  % '.ox+*sdv^<>ph'
	linetypes = {'-','-','-','-','-','-','-','-'};  % {'-',':','-.','--'}

	%%
	legend_list={'STH','DOLSH','LSDA','LSDAm'};
	alg_num = length(alg_list);

	%% true F1 measure
	j = h+1;
	figure;
	for g = 1:alg_num
		plot(codeLen, trueF1_list{g}(:,j), [colours(g),symbols(g),char(linetypes(g))],'lineWidth',2); 
		hold on;
	end
	xlabel('code length');
	ylabel('F_1 measure');
	axis([codeLen(1) codeLen(m) 0 1]);
	legend(legend_list, 'location', 'NorthEast');%Show the legend(ͼ��)
	title([dataset,',\lambda=',num2str(lambda_arr(idx_lambda))]);
	saveas(gcf,['fig/',dataset,'_trueF1_measure','_lambda_',num2str(lambda_arr(idx_lambda)),'_r_',num2str(h),'.fig'],'fig');

	%% true Precision-Recall curve
	figure; 
	for g = 1:alg_num
		plot(trueR_list{g}(:,j), trueP_list{g}(:,j), [colours(g),symbols(g),char(linetypes(g))],'lineWidth',2);
		hold on;
	end
	xlabel('recall');
	ylabel('precision');
	axis([0 1 0 1]);
	legend(legend_list, 'location', 'NorthEast');
	title([dataset,',\lambda=',num2str(lambda_arr(idx_lambda))]);
	set(gcf, 'PaperPositionMode', 'manual');
	set(gcf, 'PaperUnits', 'inches');
	set(gcf, 'PaperPosition', [0.25,2.5,4,3]);
	% saveas(gcf,['fig/truePR_',dataset,'.eps'],'epsc');
	saveas(gcf,['fig/',dataset,'_truePR','_lambda_',num2str(lambda_arr(idx_lambda)),'_r_',num2str(h),'.fig'],'fig');

	%%
	%% cate F1 measure
	figure;
	for g = 1:alg_num
		plot(codeLen, cateF1_list{g}(:,j), [colours(g),symbols(g),char(linetypes(g))],'lineWidth',2); 
		hold on;
	end
	xlabel('code length');
	ylabel('F_1 measure');
	axis([codeLen(1) codeLen(m) 0 1]);
	legend(legend_list, 'location', 'NorthEast');
	title([dataset,',\lambda=',num2str(lambda_arr(idx_lambda))]);
	saveas(gcf,['fig/',dataset,'_cateF1_measure','_lambda_',num2str(lambda_arr(idx_lambda)),'_r_',num2str(h),'.fig'],'fig');

	%% cate Precision-Recall curve
	figure; 
	for g = 1:alg_num
		plot(cateR_list{g}(:,j), cateP_list{g}(:,j), [colours(g),symbols(g),char(linetypes(g))],'lineWidth',2);
		hold on;
	end
	xlabel('recall');
	ylabel('precision');
	axis([0 1 0 1]);
	legend(legend_list, 'location', 'NorthEast');
	title([dataset,',\lambda=',num2str(lambda_arr(idx_lambda))]);
	set(gcf, 'PaperPositionMode', 'manual');
	set(gcf, 'PaperUnits', 'inches');
	set(gcf, 'PaperPosition', [0.25,2.5,4,3]);
	% saveas(gcf,['fig/catePR_',dataset,'.eps'],'epsc');
	saveas(gcf,['fig/',dataset,'_catePR','_lambda_',num2str(lambda_arr(idx_lambda)),'_r_',num2str(h),'.fig'],'fig');

	%% cate Accuracy
	figure;
	for g = 1:alg_num
		plot(codeLen, cateA_list{g}(:,j), [colours(g),symbols(g),char(linetypes(g))],'lineWidth',2); 
		hold on;
	end
	xlabel('code length');
	ylabel('accuracy');
	axis([codeLen(1) codeLen(m) 0 1]);
	legend(legend_list, 'location', 'NorthEast');
	title([dataset,',\lambda=',num2str(lambda_arr(idx_lambda))]);
	set(gcf, 'PaperPositionMode', 'manual');
	set(gcf, 'PaperUnits', 'inches');
	set(gcf, 'PaperPosition', [0.25,2.5,4,3]);
	% saveas(gcf,['fig/cateA_',dataset,'.eps'],'epsc');
	saveas(gcf,['fig/',dataset,'_cateA','_lambda_',num2str(lambda_arr(idx_lambda)),'_r_',num2str(h),'.fig'],'fig');
end

end
