function nmf( X, p, fname )
% nmf - Do NMF using Lee & Seung algorithm (NIPS*2000)
%
% SYNTAX:
% nmf( X, p, fname )
%
% INPUT:    
% X       the non-negative data (in columns)
% fname   name of file to write
% p       algorithm options:
%
% p.sources      number of components
%

dims = size(X,1);
samples = size(X,2);
sources = p.sources;

% Initializing A
A = abs(randn(dims,sources));
A = A./(ones(dims,1)*sqrt(sum(A.^2)));

% Initializing S
S = abs(randn(sources,samples));
S = S./(sqrt(sum(S.^2,2))*ones(1,samples));

% These will store the history of the objective function
objhistory = [];
iterhistory = [];

% Loop indefinitely
precision=1e-5;
iter = 0;
while 1,

  % Print current iteration
  fprintf('[%d]: ', iter);
  
  % Calculate and print objective
  obj = sum(sum((X-A*S).^2))/samples;
  fprintf('%.3f\n', obj);
  
  % Save objective function evolution
  objhistory = [objhistory obj];
  iterhistory = [iterhistory iter];
  
  % Update activity measures
  activations = sqrt(mean(S'.^2));

  % Save basis (only every 10th iteration)
  if rem(iter,10)==0,
    fprintf(['\nSaving file: ' fname '...']);
    save(fname,'p','A','objhistory','iterhistory','activations');
    fprintf('DONE!\n');
  end  
    
  % Update S and A with multiplicative steps
  S = S.*(A'*X)./(A'*A*S);
  A = A.*(X*S')./(A*S*S');
  
  % Normalize columns of A (and scale rows of S correspondingly)
  scaling = sqrt(sum(A.^2));  
  A = A./(ones(size(A,1),1)*scaling);
  S = S.*(scaling'*ones(1,size(S,2)));      
  
  if length(objhistory)>1&&abs(obj-objhistory(end-1))<precision
	break;
  end
  % Update iteration counter
  iter = iter+1;
        
end

