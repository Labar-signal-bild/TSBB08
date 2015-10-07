% Read original image;
im = double(imread('cmanmod.png'));

figure(1)
colormap(gray(256))
subplot(1,1,1); imagesc(im, [0 256]); colorbar;
axis image; axis off;

% Compute derivative images
df = [1 0 -1; 2 0 -2; 1 0 -1]/8; % sobelx
fx=conv2(im,df, 'valid'); % With valid you get rid of the dark frame
maxv = max(max(abs(fx)))/2;

df2 = df';
fy=conv2(im,df2, 'valid');
maxv2 = max(max(abs(fy)))/2;

figure(2)
colormap(gray(256))
subplot(1,2,1); imagesc(fx, [-maxv maxv]); colorbar('horizontal'); 
axis image; axis off;
title('f_x')
subplot(1,2,2); imagesc(fy, [-maxv2 maxv2]); colorbar('horizontal'); 
axis image; axis off;
title('f_y')


T11 = fx.^2;
maxv = max(max(abs(T11)))/2;
T22 = fy.^2;
maxv2 = max(max(abs(T22)))/2;

figure(3)
colormap(gray(256))
subplot(1,2,1); imagesc(T11, [0 6000]); colorbar('horizontal'); 
axis image; axis off;
title('T11')
subplot(1,2,2); imagesc(T22, [0 6000]); colorbar('horizontal'); 
axis image; axis off;
title('T22')

%%

sigma = 1.5;
lpH=exp(-0.5*([-9:9]/sigma).^2);
lpH=lpH/sum(lpH);
lpV=lpH';

T11Lp=conv2(T11,lpH,'same');
T11Lp=conv2(T11Lp,lpV,'same');

T22Lp=conv2(T22,lpH,'same');
T22Lp=conv2(T22Lp,lpV,'same');

figure(4)
colormap(gray(256));
subplot(1,2,1); imagesc(T11Lp, [0 3000]); colorbar('horizontal'); 
axis image; axis off;
title('T11 after Lp')
subplot(1,2,2); imagesc(T22Lp, [0 3000]); colorbar('horizontal'); 
axis image; axis off;
title('T22 after Lp')


T12 = fx.*fy;
T12Lp = conv2(T12,lpH,'same');
T12Lp = conv2(T12Lp,lpV,'same');

z = (T11-T22) +i*2*T12;
zg = fx + i*fy;

figure(7)
colormap(gray(256))
subplot(1,2,1); imagesc(T11-T22, [-2500 2500]); colorbar('horizontal'); 
axis image; axis off;
title('T11-T22')
subplot(1,2,2); imagesc((2*T12), [-2500 2500]); colorbar('horizontal'); 
axis image; axis off;
title('2*T12')

magimage = abs(z);

angularimage = atan2(2*T12Lp,T11Lp - T22Lp);

for i = 1:254
    for j = 1:254
        if angularimage(i,j) < 0
            angularimage(i,j) = angularimage(i,j)+2*pi;
        end
    end
end

%angularimage=conv2(angularimage,lpH,'same');
%angularimage=conv2(angularimage,lpV,'same');

figure(5)
colormap(gray(256));
imagesc(magimage, [0 4500]); colorbar('horizontal'); 
axis image; axis off;
title('abs(z)')


figure(6)
imagesc(angularimage, [0 6]); colormap(goptab); colorbar('horizontal'); 
axis image; axis off;
title('T22 after Lp')

%HJÄLP!! Dår inte ut något bra på magimage


figure(8)
imagesc(gopimage(z)); colormap(goptab); colorbar('horizontal'); 
axis image; axis off;
title('T22 after Lp')

%%

im = double(rgb2gray(imread('chess.png')));
histo = histogram(im);

figure(15); stem(histo);
%imtmp = im<100;

fx=conv2(im,df, 'valid');
maxv = max(max(abs(fx)))/2;
fy=conv2(im,df2, 'valid');
maxv2 = max(max(abs(fy)))/2;

T11 = fx.^2;
T22 = fy.^2;
T12 = fx.*fy;

maxv = max(max(abs(T11)))/2;
maxv2 = max(max(abs(T22)))/2;

k = 0.1;
cHarris = (T11.*T22-T12.^2) - k*(T11+T22).^2;
maxv = max(max(abs(cHarris)))/2;

histo = histogram(cHarris);
figure(10); stem(histo);

cHarrisNew = -cHarris>100;
maxv2 = max(max(abs(cHarrisNew)))/2;

figure(21)
colormap(gray(256))
imagesc(cHarrisNew, [-maxv2 maxv2]); colorbar('horizontal'); 
axis image; axis off;
title('cHarrisNew')

RegMax = imregionalmax(cHarris, 4);
figure(23)
colormap(gray(256))
imagesc(RegMax, [0 maxv2]); colorbar('horizontal'); 
axis image; axis off;
title('cHarrisNew')


corners = cHarrisNew .* RegMax;
cornerpoints = find(corners == 1);

cornervalues = im(cornerpoints);
cornermatrix = [cornervalues cornerpoints];

filtercornerpoints = cornerpoints;
j = 1;

for i = 1:length(cornervalues)
    if cornermatrix(i,1) < 200
        deletecornerpixels(j) = cornermatrix(i,2);
        j = j + 1;
    end
end

%for i = 1:length(deletecornerpixels)
 %   corners(deletecornerpixels(i)) = 0;
%end
cornerpointx = zeros(length(cornerpoints), 1);
cornerpointy = zeros(length(cornerpoints), 1);

for i = 1:length(cornerpoints)
    cornerpointx(i) = floor(cornerpoints(i)/400)+1;
    cornerpointy(i) = cornerpoints(i) - floor(cornerpoints(i)/100)*100;
end

figure(22)
colormap(gray(256))
imagesc(corners, [0 1]); colorbar('horizontal');
hold on;
axis image; axis off;
title('f_x')


figure(30); imagesc(im); colormap(gray(256))
figure(30);hold('on');plot(cornerpointx,cornerpointy, 'go')





