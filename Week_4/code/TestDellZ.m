function TestDellZ
% ----------------------------------------------------------------
% Self-Taught Hashing for Fast Similarity Search
% ----------------------------------------------------------------
% Dell Zhang
% 
% Matlab
%
clc; clear;

datasetName = {'Yale_32x32','ORL_32x32','USPS'};
algSet = {'STH','DOLSH','LSDA','LSDAm'};

path(path,'libsvm-mat-weights-3.0-1');

%Preparing the dataset for learning and testing
for i=1:length(datasetName)
	%prepare_dataset(char(datasetName(i)),25);
	disp(['Preparing the dataset:',datasetName{i},' finished!']);
end

for i = 1:length(datasetName)
    for j = 1:length(algSet)
       % switch(upper(algSet{i}))
         %   case 'NPH'
           %     doExperiment_NMF(char(datasetName(j)),char(algSet(i)));
        %    otherwise
		doExperiment(char(datasetName(i)),char(algSet(j)));
		disp(['Experiment of ',algSet{j},' on dataset ',datasetName{i},' finished!']);
    end
end

for r=0:3
	for j=1:length(datasetName)
		show_results(char(datasetName(j)),r);
		close all;
	end
end

time_bar;
close all;

show_F1;
close all;

show_plot;
close_all;
end
