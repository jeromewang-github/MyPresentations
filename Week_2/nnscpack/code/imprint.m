function imprint( fname, nonneg )
% Prints the current figure of an image to an EPS file, with OK positioning
%
% optional nonneg flag makes zero gray, for printing non-negative bases
%

fprintf(['Printing: ' fname '...']);
pdata = get(get(get(gcf,'Children'),'Children'),'CData');
if size(pdata,2)==1, 
  pdata = reshape(pdata,[sqrt(size(pdata,1)) sqrt(size(pdata,1)) 3]);
end
if max(max(pdata))>=0 & min(min(pdata))>=0 & ~exist('nonneg'),
  pdata = uint8(pdata/max(max(pdata))*255);
else
  pdata = uint8(pdata/max(max(abs(pdata)))*127 + 127);
end
imwrite(pdata,'tempfile.tiff','tiff');
eval(['!rm ' fname]);
eval(['!tiff2ps -e tempfile.tiff >' fname]);
!rm tempfile.tiff
fprintf('DONE!\n');

return;
