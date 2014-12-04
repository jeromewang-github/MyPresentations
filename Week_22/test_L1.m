function test_L1
nSmp=10000;
nDim=6;
z1=randi([10,15],nSmp,1);
z2=randi([10,15],nSmp,1);
x1=z1+rand(nSmp,1);
x2=-z1+rand(nSmp,1);
x3=z1+rand(nSmp,1);
x4=z2+randn(nSmp,1);
x5=-z2+rand(nSmp,1);
x6=z2+randn(nSmp,1);
X=[x1 x2 x3 x4 x5 x6];
%W=rand(nDim,1);
W=zeros(nDim,1);
Y=5*z1+z2+randn(nSmp,1);
%Y=X*W+rand(nSmp,1)*nDim;

lambda=.67;
beta=0;
nSmp=size(Y,1);

obj_old=inf;
obj_his=[];
w_his=[W];
converge=false;
tolerance=1e-6;
while ~converge
    P=diag(1./max(abs(W),eps))+beta*eye(nDim);
    W=(X'*X+lambda*nSmp*P)\(X'*Y);
    obj_new=objectfun(X,Y,W,P,lambda); 
    diff=obj_new-obj_old;
    fprintf('difference:%f\n',diff);
    if(abs(diff)<tolerance) 
        converge=true;
    end
    obj_old=obj_new;
    obj_his=[obj_his obj_new];
    w_his=[w_his W];
end

figure;
plot(1:length(obj_his),obj_his,'r-','linewidth',3);hold on;
xlabel('#Iteration');
ylabel('Value of Object Function');
title(['Convergence Analysis']);

figure;
colors={'r','g','b','k','c','m','y'};
nPara=size(w_his,1);
legend_list=cell(1,nPara);
for i=1:nPara
    plot(w_his(i,:),'color',colors{i},'linewidth',3);hold on;
    legend_list{i}=['w',num2str(i)];
end
xlabel('#Iteration');
ylabel('Parameters');
legend(legend_list,'location','NorthWest');
title('Parameters Path-LASSO');


function [val]=objectfun(X,Y,W,P,lambda)
    val=sum((Y-X*W).^2)/(2*size(Y,1))+lambda*trace(W'*P*W)/2;
    %val=sum((Y-X*W).^2)/(2*size(Y,1))+lambda*sum(abs(W))/2;