function [cellKernelsLabeled] = Watershed(Threshold,bw)

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
Dinv(~bw) = -300;

figure(10), imshow(Dinv,[],'InitialMagnification','fit');
title('Complement distance transform of bw');
colormap(jet), colorbar;

% Search for regional min
%------------------------
RegMin = imregionalmin(Dinv,8);

figure(11), imshow(RegMin,[],'InitialMagnification','fit');
title('Complement distance transform of bw');
colormap(jet), colorbar;

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

labelimmin = find(labelim>1); %All the local minimumpixels
A = [labelimmin Dinv(labelimmin)];
falsemin = find(A(:,2)>-50);
Positions=A(falsemin);
NewRegMin = RegMin;
NewRegMin(Positions)=0;




% Perfom opening
%---------------
tmp = bwmorph(NewRegMin,'dilate',5);%Changed from 1
NewRegMinmorph = bwmorph(tmp,'erode',4);



figure(14), imshow(NewRegMinmorph,[],'InitialMagnification','fit');
title('Complement distance transform of bw');

colormap(jet), colorbar;
%histlabelim = hist(labelim);
%figure(20); stem(histlabelim);

%figure(12), imshow(labelim,[],'InitialMagnification','fit');
%colormap(jet), colorbar;
%title('labeling of regional min');

% Perform labeling
%-----------------
labelstruct = bwconncomp(NewRegMinmorph,8); 

% Make a labelimage to look at
%-----------------------------
NumObj = labelstruct.NumObjects;
labelim = zeros(labelstruct.ImageSize);
for no = 1:NumObj 
  labelim(labelstruct.PixelIdxList{no}) = no;
end


% Compute the watershed transform
%--------------------------------
W1 = watershed_meyer(Dinv,8,labelstruct);


W2 = W1;
loc = find(W1==1);
W2(loc) = 0;

W2T = W2>=1;

%figure(9), imshow(W2T,'InitialMagnification','fit'), title('bw');
%colormap(gray), colorbar;

%--------------Tar ut de små cellerna-------------
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

A = find(Dinv<=-Threshold);
B = find(Dinv>-Threshold);
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

cellKernelsLabeled = W1;

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

end

