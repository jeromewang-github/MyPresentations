function show_F1

data_list={'20Newsgroups','Reuters21578','COIL100','USPS'};
dataset_num=length(data_list);
radius=0:3;
legend_list={'d<=0','d<=1','d<=2','d<=3'};

%%
colours = 'bgrkcmy';  % 'bgrcmykw'
symbols = 'x+^oshd';  % '.ox+*sdv^<>ph'
linetypes = {'-','-','-','-','-','-','-','-'};  % {'-',':','-.','--'}


lambda_arr=0:0.1:1;
for idx_lambda=1:length(lambda_arr)
	for g = 1:dataset_num
		load(['results/',data_list{g},'_','RAW_LDPH','_lambda_',num2str(lambda_arr(idx_lambda)),'.mat']);
	
		%% true F1 measure
		figure;
		for h=1:4
			plot(codeLen, trueF1(:,h), [colours(h),symbols(h),char(linetypes(h))],'lineWidth',2); 
			hold on;
		end
		xlabel('code length');
		ylabel('F_1 measure');
		axis([codeLen(1) codeLen(m) 0 0.8]);
		legend(legend_list, 'location', 'NorthEast');
		title([data_list{g},',\lambda=',num2str(lambda_arr(idx_lambda))]);
		saveas(gcf,['fig/F1/',data_list{g},'_trueF1','_lambda_',num2str(lambda_arr(idx_lambda)),'.fig'],'fig');

		%% cateF1 measure
		figure;
		for h=1:4
			plot(codeLen, cateF1(:,h), [colours(h),symbols(h),char(linetypes(h))],'lineWidth',2); 
			hold on;
		end
		xlabel('code length');
		ylabel('F_1 measure');
		axis([codeLen(1) codeLen(m) 0 0.8]);
		legend(legend_list, 'location', 'NorthEast');
		title([data_list{g},',\lambda=',num2str(lambda_arr(idx_lambda))]);
		saveas(gcf,['fig/F1/',data_list{g},'_cateF1','_lambda_',num2str(lambda_arr(idx_lambda)),'.fig'],'fig');
	end
	close all;
end