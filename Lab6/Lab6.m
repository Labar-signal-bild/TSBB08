%%
execute('chooseobject', 'B1', 189, 2, 20);



%% Lab6 Automated counting of blod cells. 
%
% OBS! INTE TESTAD KOD ENBART ETT KOD SKELLET
%

% Perform thresholding with hysteres
%-----------------------------------
A = getimg('A1');
k = 100;
histo = histogram(A);
figure(1), stem(histo);

%
% OBS! Osäker på ordningen på ATL och ATU
%

C = A<150; 
newimage (B, 'BThreshold', 5);

B = A<125; 
newimage (C, 'CThreshold', 5);

E = B.*0;
i = 1;

while sum(sum(E))~=sum(sum(B))
E = B;
D = bwmorph(B,'dilate',1);
B = D.*C;
i = i+1;
end

newimage (B, 'Done', 5);
%figure(4), imshow(B,[0 1]), colormap(gray), colorbar;

%% Find blood cells using correlation

load ../Lab4/phase1.mat
load ../Lab4/phase2.mat
load ../Lab4/phase3.mat
load ../Lab4/phase4.mat

execute('chooseobject', 'A1', 189, 2, 20);

A1 = getimg('A1');
A2 = getimg('A2');

correlated = corrc(A1, A2);
%newimage(correlated, 'Corrc', 2);

%histo = histogram(correlated);
%figure(1), stem(histo);

corrThres = correlated>150;

%newimage(corrThres, 'corrThres', 5);

corrThresDilate = bwmorph(corrThres, 'dilate', 2);

newimage(corrThresDilate, 'corrDilate', 5);

endPoints = logop4(corrThresDilate, 0, -1, 0, phase1, phase2, phase3, phase4);

%newimage(endPoints, 'endPoints', 5);

nrEndPoints = sum(sum(endPoints))


%%

%load /site/edu/bb/mips/7.0/images/blod256.mat

%A1 = imread(blod256.mat);

A1 = getimg('A1');

histo = histogram(A1);
%figure(1), stem(histo);

B = ThreshHys(A1,30,65);

% Perform closing
%----------------
tmp = bwmorph(B,'dilate',1);
Bmorph = bwmorph(tmp,'erode',1);

[Bout, Bnum] = labeling(Bmorph,4);

Barea = zeros(1,length(Bnum));

for i=1:Bnum
    Btmp = find(Bout==i);
    Barea(i) = length(Btmp);
end

BbadAreas = find(Barea<50);

for i=1:length(BbadAreas)
    Btmp = find(Bout==BbadAreas(i));
    Bmorph(Btmp) = 0;
end
    

newimage(Bmorph,'B',5);

[Bout, Bnum] = labeling(Bmorph,4);

Bnum

%figure(2), imshow(Bmorph,[0 1]), colormap(gray), colorbar;

%% The structure tensor




