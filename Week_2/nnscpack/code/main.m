function main( what, algo, seed )
%
% SYNTAX:
% main( what, algo, seed );
%
% what   - 'learn' or 'show'
% algo   - 'nnsc' or 'nmf'
% seed   - random number generator seed [optional]
%

% File to store results in
fname = ['../results/' algo '.mat'];

% Initialize random number generators
if ~exist('seed','var'), seed = 1; end  
randn('seed',seed);
rand('seed',seed);

% Data parameters
wsize = 12; samples = 10000; 
  
% Algorithm options
switch algo,

 case 'nmf',
  p.algorithm = 'nmf';
  p.sources = 72;      % 18, 36, 72, and 144 all give unoriented features
  
 case 'nnsc'
  p.algorithm = 'nnsc';
  p.sources = 72;
  p.lambda = 5;
  p.stepsize = 1;
    
 otherwise,
  error('No such algorithm!');
  
end

% Start learning ('learn') or display one ('show')?
switch what,

 % --- LEARNING A BASIS ---------------------------------------------
 case 'learn',

  % Sample image patches from pre-whitened Olshausen's images
  Z = sampleimages( wsize, samples ); 
  
  % Separate into ON and OFF channels.
  Y = Z; Y(Y<0)=0; Z(Z>0)=0; Z=-Z;
  X = [Y; Z];

  % Normalize each channel to unit mean squared activation
  X = X./(sqrt(mean(X.^2,2))*ones(1,size(X,2)));
  
  % Start the learning (runs forever, must be manually terminated)
  switch p.algorithm,
   
   case 'nmf',
    nmf( X, p, fname );
   
   case 'nnsc',
    nnsc( X, p, fname );
       
  end
    
 % --- DISPLAYING A BASIS -------------------------------------------
 case 'show',
  
  % Load the file
  load(fname);

  % Display magnification
  mag = 2;  
  
  % Number of columns
  cols = 12;
  
  % Show & print the learned basis
  Ap = A(1:(end/2),:);
  An = A(((end/2)+1):end,:);
  ApmAn = Ap-An;
  figure(1); 
  visual( Ap, mag, cols );
  imprint(['../figures/' algo '-pos.eps'],'nonneg');
  figure(2); 
  visual( An, mag, cols );
  imprint(['../figures/' algo '-neg.eps'],'nonneg');
  figure(3); 
  visual( ApmAn, mag, cols );
  imprint(['../figures/' algo '-diff.eps']);    
    
  % Display evolution of objective function
  figure(4);
  if size(objhistory,2)>1, plot(iterhistory(2:end),objhistory(2:end));
  else clf;
  end

  % Display utilization of units (assumes unit-length basis vectors)
  figure(5);
  bar(activations);

  
  
 % --- NEITHER LEARN NOR SHOW, WHAT COULD THAT BE?? -----------------
 otherwise,
  error('No such thing to do!');
  
end

  
