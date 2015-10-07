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
z = (T11-T22) +i*2*T12;
zg = fx + i*fy;

figure(7)
colormap(gray(256))
subplot(1,2,1); imagesc(T11-T22, [-2500 2500]); colorbar('horizontal'); 
axis image; axis off;
title('T11-T22')
subplot(1,2,2); imagesc((2*T12), [-2500 2500]); colorbar('horizontal'); 
axis image; axis off;
title('2*T22')



magimage = abs(z);
magimage=conv2(magimage,lpH,'same');
magimage=conv2(magimage,lpV,'same');


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
imagesc(magimage, [0 5000]); colorbar('horizontal'); 
axis image; axis off;
title('T11 after Lp')


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

fx=conv2(im,df, 'valid');
maxv = max(max(abs(fx)))/2;
fy=conv2(im,df2, 'valid');
maxv2 = max(max(abs(fy)))/2;

tmp = [fx fy];

T = tmp'*tmp;
T11 = fx.^2;
T22 = fy.^2;
T12 = fx.*fy;

maxv = max(max(abs(T11)))/2;
maxv2 = max(max(abs(T22)))/2;

cHarris = (T11*T22-T12^2) - 0.05*(T11+T22)^2;
maxv = max(max(abs(cHarris)))/2;

histo = histogram(cHarris);
figure(10); stem(histo);

cHarrisNew = -cHarris>25000000;
maxv2 = max(max(abs(cHarrisNew)))/2;

figure(21)
colormap(gray(256))
imagesc(-cHarris, [-maxv maxv]); colorbar('horizontal'); 
axis image; axis off;
title('f_x')

RegMax = imregionalmax(-cHarris, 4);

corners = cHarrisNew .* RegMax;
cornerpoints = find(corners == 1);

cornervalues = cHarris(cornerpoints);




figure(22)
colormap(gray(256))
imagesc(corners, [0 1]); colorbar('horizontal'); 
axis image; axis off;
title('f_x')








