function nnsc( X, p, fname )
% nnsc - Do nnsc using multiplicative update for S and gradient for A
%
% SYNTAX:
% nnsc( X, p, fname )
%
% INPUT:    
% X       the non-negative data (in columns)
% fname   name of file to write
% p       algorithm options:
%
% p.sources      number of components
% p.lambda       importance of sparseness vs. representation error
% p.stepsize     gradient descent stepsize in learning basis
%

dims = size(X,1);
samples = size(X,2);
sources = p.sources;
lambda = p.lambda;

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
iter = 0;
while 1,

  % Print current iteration
  fprintf('[%d]: ', iter);
  
  % Calculate and print objective
  obj = (0.5*sum(sum((X-A*S).^2)) + lambda*sum(sum(S)))/samples;
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
    
  % Update S with multiplicative step
  S = S.*(A'*X)./(A'*A*S + lambda);
    
  % Update A with gradient descent step
  E = X - A*S;
  dA = E*S'/size(S,2);
  A = A + p.stepsize*dA;
  
  % Prevent negative values from entering A
  A(A<0)=0;

  % Normalize columns of A
  A = A./(ones(size(A,1),1)*sqrt(sum(A.^2)));
        
  % Update iteration counter
  iter = iter+1;
        
end


