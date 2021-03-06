%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% An example about how to read images,
% how to do binary manipulation 
% and how to overlay a pattern.
% Written by Maria Magnusson, 2007-05-08
% Updated by Maria Magnusson, 2008-08-11
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read a colour image
%--------------------
im1 = double(imread('C9minpeps2.bmp'));
figure(1), imshow(im1/255);

% Look at the three colour components RGB
%----------------------------------------
im1r=im1(:,:,1); im1g=im1(:,:,2); im1b=im1(:,:,3);
%figure(2), imshow(im1r,[0 255]), colormap(gray), colorbar;
%figure(3), imshow(im1g,[0 255]), colormap(gray), colorbar;
figure(4), imshow(im1b,[0 255]), colormap(gray), colorbar;

% Compute the histogram of the blue image and do threshholding
%-------------------------------------------------------------
histo = hist(im1b(:),[0:255]);
%figure(5), stem(histo);
im1bT = im1b>50; %Changed from 80
figure(6), imshow(im1bT,[0 1]), colormap(gray), colorbar;

% Perfom opening
%---------------
tmp = bwmorph(im1bT,'erode',2);%Changed from 1
tmp = bwmorph(tmp,'dilate',2);

% Perform closing
%----------------
tmp = bwmorph(tmp,'dilate',1);
im1bTmorph = bwmorph(tmp,'erode',1);

figure(7), imshow(im1bTmorph,[0 1]), colormap(gray), colorbar;

CellKernels = Watershed(100,im1bTmorph);


CellKernelLines = find(CellKernels==0);
CellKernelArea  = find(CellKernels~=6);

im1rNoLines = im1r;
im1gNoLines = im1g;
im1bNoLines = im1b;

% Make the yellow line
im1r(CellKernelLines) = 255;
im1g(CellKernelLines) = 255;
im1b(CellKernelLines) = 0;

ImDone = im1;

ImDone(:,:,1)=im1r;
ImDone(:,:,2)=im1g;
ImDone(:,:,3)=im1b;

%figure(14), imshow(ImDone/255);

% Take out the area 6
imArea = im1;

im1rNoLines(CellKernelArea) = 0;
im1gNoLines(CellKernelArea) = 0;
im1bNoLines(CellKernelArea) = 0;

imArea(:,:,1) = im1rNoLines;
imArea(:,:,2) = im1gNoLines;
imArea(:,:,3) = im1bNoLines;

%figure(15), imshow(imArea/255);


% Overlay a pattern
%------------------
immask1 = zeros(1000,1000);
immask1(200:800,200:800) = 1;
immask2 = zeros(1000,1000);
M = [ 1 1 0 0 0 0 0 0 0 0 1 1;
      1 1 1 0 0 0 0 0 0 1 1 1;
      1 1 1 1 0 0 0 0 1 1 1 1;
      1 1 0 1 1 0 0 1 1 0 1 1;
      1 1 0 0 1 1 1 1 0 0 1 1;
      1 1 0 0 0 1 1 0 0 0 1 1;
      1 1 0 0 0 0 0 0 0 0 1 1;
      1 1 0 0 0 0 0 0 0 0 1 1;
      1 1 0 0 0 0 0 0 0 0 1 1;
      1 1 0 0 0 0 0 0 0 0 1 1;
      1 1 0 0 0 0 0 0 0 0 1 1;
      1 1 0 0 0 0 0 0 0 0 1 1];
immask2(500:511,500:511) = 255*M; 

imny = zeros(1000,1000,3);
imny(:,:,1) = max(im1r, immask2);
imny(:,:,2) = max(im1g, immask2);
imny(:,:,3) = max(im1b, immask2);
imny(:,:,1) = imny(:,:,1) .* immask1;
imny(:,:,2) = imny(:,:,2) .* immask1;
imny(:,:,3) = imny(:,:,3) .* immask1;

%figure(8), imshow(imny/255);

%%

sobely = [1 2 1; 0 0 0; -1 -2 -1];
 sobelx = sobely';
 
 xx = conv2(sobelx, sobelx, 'full');
 yy = conv2(sobely, sobely, 'full');
 
sobelfilter = -xx -yy;

padimage=conv2(imArea(:,:,1), sobelfilter, 'same');
%figure(10), imshow(padimage/255,[]);colorbar;

histo = hist(padimage,[0:255]);
%figure(9), stem(histo);

im1rT = padimage>1500; 
%figure(11), imshow(im1rT,[0 1]), colormap(gray), colorbar;

im1rM = im1rT.*padimage;
%figure(12), imshow(im1rM,[0 1]), colormap(gray), colorbar;

padlockmatrix= imregionalmax(im1rM);
%figure(13), imshow(padlockmatrix,[0 1]), colormap(gray), colorbar;

numPadlock = sum(sum(padlockmatrix))

%----------------------------------------------------------------------
% Make rings around the red padlocks
%----------------------------------------------------------------------

padlockpixels = find(padlockmatrix == 1);
padlockpixelsxy= zeros(length(padlockpixels), 2);

for i = 1:length(padlockpixels)
    padlockpixelsxy(i,1) = floor(padlockpixels(i)/1000)+1;
    padlockpixelsxy(i,2) = padlockpixels(i)-(floor(padlockpixels(i)/1000)*1000);
    
end

% Overlay a pattern
%------------------
immask1 = zeros(1000,1000);
immask1(1:1000,1:1000) = 1;
immask2 = zeros(1000,1000);
immask2r = zeros(1000,1000);
M = [ 0 0 0 0 1 1 1 1 0 0 0 0;
      0 0 0 1 1 1 1 1 1 0 0 0;
      0 0 1 1 0 0 0 0 1 1 0 0;
      0 1 1 0 0 0 0 0 0 1 1 0;
      1 1 0 0 0 0 0 0 0 0 1 1;
      1 1 0 0 0 0 0 0 0 0 1 1;
      1 1 0 0 0 0 0 0 0 0 1 1;
      1 1 0 0 0 0 0 0 0 0 1 1;
      0 1 1 0 0 0 0 0 0 1 1 0;
      0 0 1 1 0 0 0 0 1 1 0 0;
      0 0 0 1 1 1 1 1 1 0 0 0;
      0 0 0 0 1 1 1 1 0 0 0 0];
  
  
  
for i = 1:length(padlockpixels)
    immask2((padlockpixelsxy(i,2)-5):(padlockpixelsxy(i,2)+6),(padlockpixelsxy(i,1)-5):(padlockpixelsxy(i,1)+6)) = 255*M; 
    immask2r((padlockpixelsxy(i,2)-5):(padlockpixelsxy(i,2)+6),(padlockpixelsxy(i,1)-5):(padlockpixelsxy(i,1)+6)) = 0*M;
    
    imny = zeros(1000,1000,3);
    imny(:,:,1) = max(im1r, immask2r);
    imny(:,:,2) = max(im1g, immask2);
    imny(:,:,3) = max(im1b, immask2);
    imny(:,:,1) = imny(:,:,1) .* immask1;
    imny(:,:,2) = imny(:,:,2) .* immask1;
    imny(:,:,3) = imny(:,:,3) .* immask1;
    
end




%figure(22), imshow(imny/255);

%---------------------------------------------------------------


for i = 1:length(padlockpixels)
    immask2((padlockpixelsxy(i,2)-5):(padlockpixelsxy(i,2)+6),(padlockpixelsxy(i,1)-5):(padlockpixelsxy(i,1)+6)) = 255*M; 
    immask2r((padlockpixelsxy(i,2)-5):(padlockpixelsxy(i,2)+6),(padlockpixelsxy(i,1)-5):(padlockpixelsxy(i,1)+6)) = 0*M;
    
    imny = zeros(1000,1000,3);
    imny(:,:,1) = max(im1rNoLines, immask2r);
    imny(:,:,2) = max(im1gNoLines, immask2);
    imny(:,:,3) = max(im1bNoLines, immask2);
    imny(:,:,1) = imny(:,:,1) .* immask1;
    imny(:,:,2) = imny(:,:,2) .* immask1;
    imny(:,:,3) = imny(:,:,3) .* immask1;
    
end




%figure(23), imshow(imny/255);

