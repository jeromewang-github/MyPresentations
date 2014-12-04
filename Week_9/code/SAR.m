%% Multi-task learning via low rank
% INTRODUCTORY TEXT
%%
function [Wt,bt] = SAR(data,gnd,para)
% input: data.Xa,data.Xt: d*na, d*nt
%        gnd.Ya,gnd.yt: na*ca, nt*1 
%        para.alpha, para.beta, para.p: parameters.
% output: Wt,bt; d*1, 1*1;
alpha = para.alpha;
beta = para.beta;
p = para.p;
Xa = data.Xa;
Xt = data.Xt;
Ya = gnd.Ya; 
yt = gnd.yt;
[d,na] = size(Xa);
nt = size(Xt,2);
ca = size(Ya,2);
Id = eye(d);
ea = ones(na,1);
et = ones(nt,1);
Ia = eye(na);
It = eye(nt);
Ha = Ia-ea*ea'/na;
Ht = It-et*et'/nt;
Wa = rand(d,ca);
ba = rand(1,ca);
Wt = rand(d,ct);
bt = rand(1,1);
W = [Wa,Wt];
iter = 0;
obji = 1;
while 1  
    Za = Xa'*Wa + ea*ba - Ya;
    da = 0.5./sqrt(sum(Za.*Za,2)+eps);
    Da = diag(da);
    Zt = Xt'*Wt + et*bt - yt;
    dt = 0.5./sqrt(sum(Zt.*Zt,2)+eps);
    Dt = diag(dt);
    d = (p/2)./(sqrt(sum(W.*W,2)+eps).^(2-p));
    D = diag(d);
    Wa = (Xa*Ha*Da*Ha*Xa'+alpha*D+beta*Id)\(Xa*Ha*Da*Ha*Ya);
    ba = (ea'*Ya-ea'*Xa'*Wa)/na;
    Wt = (Xt*Ht*Dt*Ht*Xt'+alpha*D+beta*Id)\(Xt*Ht*Dt*Ht*yt);
    bt = (et'*yt-et'*Xt'*Wt)/nt;
    W = [Wa,Wt];
    obj = sum(sqrt(sum((Xa'*Wa + ea*ba - Ya).*(Xa'*Wa + ea*ba - Ya),2)+eps)) + sum(sqrt(sum((Xt'*Wt + et*bt - yt).*(Xt'*Wt + et*bt - yt),2)+eps)) ...
        + alpha*sum(sqrt(sum(W.*W,2)+eps).^(2-p)) + beta*norm(W,'fro').^2;
    cver = abs((obj-obji)/obji);
    obji = obj; 
    iter = iter+1;
    if (cver < 10^-3 && iter > 2) || iter == 30,
    break, end
end