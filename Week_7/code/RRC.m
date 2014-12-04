function [ID] =RRC(A,Y,rho,gnd)
%Rotational invariant norm based Regression for Classification
%   A:train samples(nSmp*dim)
%   Y:test samples(dim*NSmp)
%   rho:penalty coefficient
%   gnd:label info of A
%   ID:class-label vector predicted by RRC method
%   
%   Reference:  
%   Chuan-Xiao Ren,Dao-Qing Dai,Hong Yan.Robust classification using L2,1
%   norm based regression model.Pattern Recognition,2012.
    if length(gnd)~=size(A)
        error('Number of gnd does not equal training samples');
    end
    [X,iter]=ComputeX(A,Y,rho);
    N=size(Y,2);
    class=unique(gnd);
    classnum=length(class);
    difmatrix=zeros(classnum,N);
    
    for s=1:classnum;
        Xs=zeros(size(X));
        idx=(gnd==class(s));
        Xs(idx,:)=X(idx,:);
        Ys=A'*Xs;
        Ydif=Y-Ys;
        difmatrix(s,:)=sqrt(sum(Ydif.^2));
    end
    
    ID=zeros(N,1);
    mindif=min(difmatrix);
    
    for i=1:N
        pos= find(difmatrix(:,i)==mindif(i));
        ID(i)=class(pos);
    end



%Iteratively compute U until convergence and the first n row of U is the coefficient matrix X
function [X,iter]=ComputeX(A,Y,rho)
    iter=0;
    zeta=0.1;
    [n,d]=size(A);
    N=size(Y,2);
    D=eye(n+d);
    B=[A',rho*eye(d)];
    eps=1e-3;
    Uold=zeros(n+d,N);
    diff=ones(size(Uold));
    num=sum(sum(diff));
    while num>1
        Unew=D\B'/(B/D*B'+zeta*eye(d))*Y;
        for i=1:(n+d)
            ui=sqrt(sum(Unew(i,:).^2));
            D(i,i)=1/(2*ui);
        end
        iter=iter+1;
        diff=abs(Unew-Uold)>eps;
        num=sum(sum(diff));
        Uold=Unew;
    end
    X=Unew(1:n,:);
    
        
    