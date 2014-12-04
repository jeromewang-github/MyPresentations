function main
    dataset={'Yale_32x32','YaleB_32x32','COIL20','ORL_32x32'};
    len=length(dataset);
    ac=zeros(1,len);
    for i=1:len;
        load(['data/',char(dataset(i))]);
        disp(['Processing dataset:',char(dataset(i))]);
        split = 0.7;   % 70 percent training, 30 percent testing
        randIdx = rand(size(fea,1),1);
        trainIdx = find(randIdx <= split);
        testIdx  = find(randIdx >  split);
        feaTrain = fea(trainIdx,:);
        feaTest = fea(testIdx,:);
        gndTrain = gnd(trainIdx);
        gndTest  = gnd(testIdx);
        ID=RRC(feaTrain,feaTest',3,gndTrain);
        ac(i)=accuracy(ID,gndTest);
        fprintf('%.5f\n',ac(i));
    end
    
    figure;
    bar(ac);
    colormap(cool);
    ylabel('Accuracy');
    title('Accuracy');
    set(gca,'XTickLabel',dataset);
    saveas(gcf,'accuracy.fig','fig');
end

