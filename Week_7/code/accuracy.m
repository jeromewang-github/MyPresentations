%Compute the accuracy
function  [ac]=accuracy(ID,gnd)
    if length(ID)~=length(gnd)
        error('the two label vector does not match');
    end
    correct=sum(ID==gnd);
    ac=correct/length(ID);

