%% 1.1

f = getactive;
h0 = ones(5,5)/25;
h1 = 1;
g = circconv(f,h1,1);
snr = 20;
h = addnoise(g,snr);
rho = 0.80;
r = 1;
fhat = wiener(h,h0,snr,rho,r);

figure(90), colormap(gray)
imagesc(f,[0 255]), axis image
figure(91), colormap(gray)
imagesc(h,[0 255]), axis image
figure(92), colormap(gray)
imagesc(fhat,[0 255]), axis image

%% 1.2

f = getactive;
h2 = ones(7,7)/49;
h3 = ones(11,11)/121;
g2 = circconv(f,h2,1);
g3 = circconv(f,h3,1);
snr = 40;
h22 = addnoise(g2,snr);
h33 = addnoise(g3,snr);
rho = 0.80;
r = 0;
fhat2 = wiener(h,h2,snr,rho,r);
fhat3 = wiener(h,h3,snr,rho,r);


figure(90), colormap(gray)
imagesc(f,[0 255]), axis image
figure(91), colormap(gray)
imagesc(h22,[0 255]), axis image
figure(92), colormap(gray)
imagesc(fhat2,[0 255]), axis image


figure(93), colormap(gray)
imagesc(h33,[0 255]), axis image
figure(94), colormap(gray)
imagesc(fhat3,[0 255]), axis image

%% 1.3

f = getactive;
h2 = ones(7,7)/49;
snr = 5;
h = addnoise(g,snr);
rho = 0.80;
r = 1;
fhat = wiener(h,h2,snr,rho,r);

figure(90), colormap(gray)
imagesc(f,[0 255]), axis image
figure(91), colormap(gray)
imagesc(h,[0 255]), axis image
figure(92), colormap(gray)
imagesc(fhat,[0 255]), axis image









