function time_bar

alg_list={'STH','DOLSH','LSDA','LSDAm'};
alg_num=length(alg_list);
dataset_list={'Yale_32x32','ORL_32x32'};
dataset_num=length(dataset_list);
legend_list={'STH','DOLSH','LSDA','LSDAm'};

timeTrain=zeros(dataset_num,alg_num);
timeTest=zeros(dataset_num,alg_num);

for i=1:dataset_num
	for j=1:alg_num
		load(['time/',dataset_list{i},'_',alg_list{j},'.mat']);
		timeTrain(i,j)=timeTrainAvg;
		timeTest(i,j)=timeTestAvg;
	end
end

figure;
bar(timeTrain);
colormap(cool);
ylabel('Time Consumed(S)');
title('Training Time');
legend(legend_list,'location', 'NorthEastOutside');
set(gca,'XTickLabel',dataset_list);
saveas(gcf,'fig/TrainingTime.fig','fig');

figure;
bar(timeTest);
colormap(cool);
title('Average Query Response Time');
legend(legend_list,'location', 'NorthEastOutside');
set(gca,'XTickLabel',dataset_list);
saveas(gcf,'fig/QueryingTime.fig','fig');

end