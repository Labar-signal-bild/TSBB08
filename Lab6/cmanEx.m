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

sigma = 1.5;
lpH=exp(-0.5*([-9:9]/sigma).^2);
lpH=lpH/sum(lpH);
lpV=lpH';

T11Lp=conv2(T11,lpH,'same');
T11Lp=conv2(T11Lp,lpV,'same');

T22Lp=conv2(T22,lpH,'same');
T22Lp=conv2(T22Lp,lpV,'same');

figure(4)
colormap(gray(256))
subplot(1,2,1); imagesc(T11Lp, [0 3000]); colorbar('horizontal'); 
axis image; axis off;
title('T11 after Lp')
subplot(1,2,2); imagesc(T22Lp, [0 3000]); colorbar('horizontal'); 
axis image; axis off;
title('T22 after Lp')


T12 = fx*fy;
z= T11 - T22 +i*2*T12;
zg = fx + i*fy

magimage = abs(z);
angularimage = arg(z);



figure(5)
colormap(gray(256))
subplot(1,2,1); imagesc(magimage, [0 3000]); colorbar('horizontal'); 
axis image; axis off;
title('T11 after Lp')
subplot(1,2,2); imagesc(T22Lp, [0 3000]); colorbar('horizontal'); 
axis image; axis off;
title('T22 after Lp')











