%% Lab6 Automated counting of blod cells. 


%
% OBS! INTE TESTAD KOD ENBART ETT KOD SKELLET
%

% Perform thresholding with hysteres
%-----------------------------------
A = getimg('A1');

hist0 = histogram(A);
figure(1), stem(histo);

%
% OBS! Osäker på ordningen på ATL och ATU
%

B = A>50; 
figure(2), imshow(B,[0 1]), colormap(gray), colorbar;

C = A<50; 
figure(3), imshow(C,[0 1]), colormap(gray), colorbar;

E = B.*0;

while B~=E 
E = B;
D = bwmorph(B,'dilate',2);
B = D.*C;
end

newimage (B, 'A2', 5);


