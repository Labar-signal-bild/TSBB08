
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Watershed exemple, partly from Matlab
% Written  by Maria Magnusson, 2007-05-08
% Modified by Maria Magnusson, 2008-08-11
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Make a binary test image (you do not need to understand this code)
%-------------------------------------------------------------------
lims = [-50 50];
[x,y] = meshgrid(lims(1):lims(2));
center1x = -15;
center1y = -20;
center2x = -5;
center2y = 3;
center3x = 15;
center3y = 20;
radius = 15;
bw1 = sqrt((x-center1x).^2 + (y-center1y).^2) <= radius;
bw2 = sqrt((x-center2x).^2 + (y-center2y).^2) <= radius;
bw3 = sqrt((x-center3x).^2 + (y-center3y).^2) <= radius;
bw = bw1 | bw2 | bw3;
%figure(1), imshow(bw,'InitialMagnification','fit'), title('bw');
colormap(gray), colorbar;

% Compute the distance transform inside the objects
%--------------------------------------------------
D = bwdist(~bw);

figure(13), imshow(D,[],'InitialMagnification','fit');
title('Distance transform of ~bw');
colormap(jet), colorbar;

% Change the sign of the distance transform and 
% set pixels outside the object to the minimum value
%---------------------------------------------------
Dinv = -D;
Dinv(~bw) = min(min(Dinv));

figure(10), imshow(Dinv,[],'InitialMagnification','fit');
title('Complement distance transform of bw');
colormap(jet), colorbar;

% Search for regional min
%------------------------
RegMin = imregionalmin(Dinv,8);

% Perform labeling
%-----------------
labelstruct = bwconncomp(RegMin,8); 

% Make a labelimage to look at
%-----------------------------
NumObj = labelstruct.NumObjects;
labelim = zeros(labelstruct.ImageSize);
for no = 1:NumObj
  labelim(labelstruct.PixelIdxList{no}) = no;
end

%figure(12), imshow(labelim,[],'InitialMagnification','fit');
colormap(jet), colorbar;
title('labeling of regional min');

% Compute the watershed transform
%--------------------------------
W1 = watershed_meyer(Dinv,8,labelstruct);

W2 = W1;
loc = find(W1==1);
W2(loc) = 0;

W2T = W2>=1;

%figure(9), imshow(W2T,'InitialMagnification','fit'), title('bw');
colormap(gray), colorbar;

%--------------Tar ut de sm� cellerna-------------
%-------------------------------------------------
%-------------------------------------------------
%-------------------------------------------------



% Compute the distance transform outside the objects
%--------------------------------------------------
D = bwdist(bw);
figure(2), imshow(D,[],'InitialMagnification','fit');
title('Distance transform of ~bw');
colormap(jet), colorbar;

% Change the sign of the distance transform and 
% set pixels outside the object to the minimum value
%---------------------------------------------------
Dinv = -D;

A = find(Dinv<=-15);
B = find(Dinv>-15);
C = find(W2T==1);
Dinv(A)=1;
Dinv(B)=0;
Dinv(C)=1;

%figure(3), imshow(Dinv,[],'InitialMagnification','fit');
%title('Complement distance transform of bw');
%colormap(jet), colorbar;

% Perform labeling
%-----------------
labelstruct = bwconncomp(Dinv,8); 

% Make a labelimage to look at
%-----------------------------
NumObj = labelstruct.NumObjects;
labelim = zeros(labelstruct.ImageSize);
for no = 1:NumObj
  labelim(labelstruct.PixelIdxList{no}) = no;
end
%figure(5), imshow(labelim,[],'InitialMagnification','fit');
%colormap(jet), colorbar;
%title('labeling of regional min');

% Compute the watershed transform
%--------------------------------
W1 = watershed_meyer(D,8,labelstruct);
%figure(6), imshow(W1,[],'InitialMagnification','fit');
%colormap(jet), colorbar;
%title('Watershed of Dinv');

W2 = W1;
loc = find(W1==1);
W2(loc) = 0;
%figure(7), imshow(W2,[],'InitialMagnification','fit');
%colormap(jet), colorbar;
%title('Fixed Watershed of Dinv')

W2T = W2>=1;
%figure(8), imshow(W2T,[],'InitialMagnification','fit');
%colormap(gray), colorbar;
%title('Final segmentation result')