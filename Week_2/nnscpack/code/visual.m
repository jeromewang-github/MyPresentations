function visual( A, mag, cols, bgblack, border, minrows )
% visual - display a basis for image patches
%
% A        the basis, with patches as column vectors
% mag      magnification factor
% cols     number of columns (x-dimension of map)
% bgblack  [optional] if this flag is set the background is black
% border   [optional] border pixels (default is 0)
% minrows  [optional] minimum number of rows in plot
%
 
if ~exist('bgblack'), bgblack = 0; end
if ~exist('border'), border = 0; end

% Get maximum absolute value (it represents white or black; zero is gray)
maxi=max(max(abs(A)));
mini=-maxi;

% This is the side of the window
dim = sqrt(size(A,1));

% Helpful quantities
dimm = dim-1;
dimp = dim+1;
rows = ceil(size(A,2)/cols);
if exist('minrows') & rows<minrows,
  rows = minrows;
end


% Initialization of the image
if bgblack, bgval = mini; else bgval = maxi; end
I = bgval*ones(dim*rows+rows-1+(2*border),dim*cols+cols-1+(2*border));

for i=0:rows-1
  for j=0:cols-1
    
    if i*cols+j+1>size(A,2)
      % This leaves it at background color
      
    else
      % This sets the patch
      I(border+i*dimp+1:border+i*dimp+dim, ...
	border+j*dimp+1:border+j*dimp+dim) = ...
          reshape(A(:,i*cols+j+1),[dim dim]);
    end
    
  end
end

I = imresize(I,mag);

colormap(gray(256));
iptsetpref('ImshowBorder','tight'); 
subplot('position',[0,0,1,1]);
imshow(I,[mini maxi]);
truesize;  
drawnow