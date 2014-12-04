function [res]=accuracy(gnd,label)
%========Calculating the accuracy===========
	if length(gnd)~=length(label)
		error('length(gnd) must == length(label)');
	end
	right=0;
	nSmp=length(gnd);
	K=max(label);
	for k=1:K
		tmp=gnd(find(label==k));%find the data having the same label
		%find the gnd-value most frequently occurring in a cluster(the right gnd value the cluser should have)
		[n,xout]=hist(tmp,sort(tmp));
		NumXout=xout(find(n==max(n)));
		%NumXout=mode(tmp);%return the smalles value when there are more than one element most frequently occurs.
		for j=1:length(NumXout)
			right=right+sum(tmp==NumXout(j));
		end
	end
	res=right/nSmp;
end