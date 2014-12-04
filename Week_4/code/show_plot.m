function show_plot(dataset,alg)

%% Load Experimental Results
load(['results/',dataset,'_',alg]);

%%
colours = 'ckbm';  % 'bgrcmykw'
symbols = '*ods';  % '.ox+*sdv^<>ph'
linetypes = {'-','-','-','-'};  % {'-',':','-.','--'} 

%%
figure;
S = cell(size(hammRadius));
for j = 1:n
    plot(codeLen, cateA(:,j), [colours(j),symbols(j),char(linetypes(j))]);
    S(j) = {['d<=',int2str(hammRadius(j))]};
    hold on;
end
xlabel('code length');
ylabel('accuracy');
axis([codeLen(1) codeLen(m) 0 1.0]);
legend(S, 'location', 'NorthEast');
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25,2.5,4,3]);
% saveas(gcf,['fig/cateA_',dataset,'_',alg,'.eps'],'epsc');
saveas(gcf,['fig/cateA_',dataset,'_',alg,'.fig'],'fig');

%%
max_cateA = max(cateA);
for j = 1:n
    h = hammRadius(j);
    fprintf('Hamming distance<=%d:\tmax_cateA=%.4f\n', h, max_cateA(j));
end

%%
%%return;

%%
figure;
S = cell(size(hammRadius));
for j = 1:n
    plot(codeLen, trueF1(:,j), [colours(j),symbols(j),char(linetypes(j))]);
    S(j) = {['d<=',int2str(hammRadius(j))]};
    hold on;
end
xlabel('code length');
ylabel('F1 measure');
axis([codeLen(1) codeLen(m) 0 0.8]);
legend(S, 'location', 'NorthEast');
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25,2.5,4,3]);
% saveas(gcf,['fig/trueF1_',dataset,'_',alg,'.eps'],'epsc');
saveas(gcf,['fig/trueF1_',dataset,'_',alg,'.fig'],'fig');

%%
max_trueF1 = max(trueF1);
for j = 1:n
    h = hammRadius(j);
    fprintf('Hamming distance<=%d:\tmax_trueF1=%.4f\n', h, max_trueF1(j));
end

%%
figure;
S = cell(size(hammRadius));
for j = 1:n
    plot(codeLen, cateF1(:,j), [colours(j),symbols(j),char(linetypes(j))]);
    S(j) = {['d<=',int2str(hammRadius(j))]};
    hold on;
end
xlabel('code length');
ylabel('F1 measure');
axis([codeLen(1) codeLen(m) 0 0.8]);
legend(S, 'location', 'NorthEast');
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0.25,2.5,4,3]);
% saveas(gcf,['fig/cateF1_',dataset,'_',alg,'.eps'],'epsc');
saveas(gcf,['fig/cateF1_',dataset,'_',alg,'.fig'],'fig');

%%
max_cateF1 = max(cateF1);
for j = 1:n
    h = hammRadius(j);
    fprintf('Hamming distance<=%d:\tmax_cateF1=%.4f\n', h, max_cateF1(j));
end

end
