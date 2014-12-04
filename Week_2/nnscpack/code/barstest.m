function barstest( algo, sources, lambda, stepsize, seed )
%
% SYNTAX:
% barstest( algo, sources, lambda, stepsize, seed )
%
% algo      - 'nnsc' or 'nmf'
% sources   - assumed dimensionality of hidden sources
% lambda    - importance of sparseness [used in NNSC, not NMF]
% stepsize  - gradient descent stepsize [used in NNSC, not NMF]
% seed      - random number generator seed [optional]
%

% Initialize random number generators
if ~exist('seed'), seed = 1; end
randn('seed',seed);
rand('seed',seed);

% Print results into EPS file?
doprints = 1;

% Visualization options
bgblack = 1;
border = 1;
minrows = 4;

switch algo,
 case 'nnsc',
  if ~exist('lambda'), error('Lambda not specified'); end
  if ~exist('stepsize'), error('Stepsize not specified'); end
 case 'nmf',
  lambda = 0;
end

% Data parameters:
wsize = 3;                  % size of window
doublebars = 'yes';         % include double bars? ('yes' or 'no')
samples = 10000;            % number of data samples
mag = 8; cols = 3;          % basis display parameters

% ---------------------- Generate the data -------------------------

% Create the bars basis
ind = 1;
switch doublebars,
 case 'yes', A = zeros(wsize^2,2*(wsize+(wsize-1)));
 case 'no', A = zeros(wsize^2,2*wsize);
end
for i=1:wsize,
  % horizontal bar
  win = zeros(wsize,wsize); win(i,:) = 1;
  A(:,ind) = reshape(win,[wsize^2 1]); ind = ind+1;
  % vertical bar
  win = zeros(wsize,wsize); win(:,i) = 1;
  A(:,ind) = reshape(win,[wsize^2 1]); ind = ind+1;
  switch doublebars,
   case 'yes',
    if i<wsize,
      % horizontal thick bar
      win = zeros(wsize,wsize); win([i i+1],:) = 1;
      A(:,ind) = reshape(win,[wsize^2 1]); ind = ind+1;
      % vertical thick bar
      win = zeros(wsize,wsize); win(:,[i i+1]) = 1;
      A(:,ind) = reshape(win,[wsize^2 1]); ind = ind+1;
    end
  end
end

% Normalize each column of A to unit norm
dims = size(A,1);
A = A./(ones(dims,1)*sqrt(sum(A.^2)));

% Show basis(original features)
figure(1);
visual( A, mag, cols, bgblack, border, minrows );
if doprints,
  imprint(['../figures/bars-origbasis.eps']);
end

% Generate random sparse sources
S = abs(rand(size(A,2),samples)).^3;
S = S/sqrt(mean(mean(S.^2)));


% Mix
X = A*S;

% Show random samples (normalize each so max is white)
figure(5);
Xshow = X(:,1:12);
Xshow = Xshow./(ones(size(Xshow,1),1)*max(Xshow));
visual( Xshow, mag, cols, bgblack, border, minrows );
title('random samples');
if doprints,
  imprint(['../figures/bars-samples.eps']);
end

% Calculate objective for generating basis and sources
if ~exist('lambda'), lambda = 0; end
origobj = (0.5*sum(sum((X-A*S).^2)) + lambda*sum(sum(S)))/samples;

% Store generating matrices and clear A and S
Aorig = A;
Sorig = S;
clear A S;

% ---------------------- Now, learn the basis  -------------------------

% Random initial values for A and S
A = abs(randn(dims,sources));
A = A./(ones(dims,1)*sqrt(sum(A.^2)));
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
  obj = (0.5*sum(sum((X-A*S).^2)) + lambda*sum(sum(S)))/samples;
  fprintf('%.5f / %.5f\n', obj, origobj);
  
  % Save objective function evolution
  objhistory = [objhistory obj];
  iterhistory = [iterhistory iter];
  
  % Update activity measures
  activations = sqrt(mean(S'.^2));

  % Show progress!
  if rem(iter,10)==0,
    
    % Display basis
    figure(2);
    visual( A, mag, cols, bgblack, border, minrows );
    
    % Display evolution of objective function
    figure(3);
    if size(objhistory,2)>1, plot(iterhistory(2:end),objhistory(2:end));
    else clf;
    end
	title(['evolution of objective function,iter:',num2str(iter)]);

    % Display utilization of units
    figure(4);
    bar(activations);
	title('utilization of units');

    if rem(iter,100)==0 & doprints,
      figure(2);
      imprint(['../figures/bars-' algo '-' num2str(sources) '.eps']);
    end
    
  end  
    
  % Update S with multiplicative step
  S = S.*(A'*X)./(A'*A*S + lambda);
    
  switch algo,
   case 'nnsc',

    % Update A with gradient descent step
    E = X - A*S;
    dA = E*S'/size(S,2);
    A = A + stepsize*dA;
    
    % Prevent negative values from entering A
    A(A<0)=0;
    
    % Normalize columns of A
    A = A./(ones(size(A,1),1)*sqrt(sum(A.^2)));
	
	%====================
	% Update A with multiplicative step
    %A = A.*(X*S')./(A*S*S');

    % Rescale so basis vectors have unit norm
    %scaling = sqrt(sum(A.^2));  
    %A = A./(ones(size(A,1),1)*scaling);
    
   case 'nmf',
    
    % Update A with multiplicative step
    A = A.*(X*S')./(A*S*S');

    % Rescale so basis vectors have unit norm
    scaling = sqrt(sum(A.^2));  
    A = A./(ones(size(A,1),1)*scaling);
    S = S.*(scaling'*ones(1,size(S,2)));      
    
  end
    
  if length(objhistory)>1&&abs(obj-objhistory(end-1))<precision
                            
	% Display evolution of objective function
    figure(3);
    if size(objhistory,2)>1, plot(iterhistory(2:end),objhistory(2:end));
    else clf;
    end
	title(['evolution of objective function,iter:',num2str(iter)]);
	saveas(gcf,['../figures/plot',num2str(iter)],'fig');
	break;
  end
  % Update iteration counter
  iter = iter+1;
        
end

