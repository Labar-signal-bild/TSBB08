%% TSBB08 Lab2 

%% 2 Image shearing

Im  = double(imread('baboon.tif'));     % load image
T1   = [1 -1/3; 0 1];                    % assign shear matrix
T2   = [1 -5; 0 1];

figure(1); colormap gray;
shearIm = shearimage(Im,T1);
subplot(121); imagesc (Im); axis image; colorbar;
subplot(122); imagesc (shearIm); axis image; colorbar;

figure(2); colormap gray;
shearIm = shearimage(Im,T2);
subplot(121); imagesc (Im); axis image; colorbar;
subplot(122); imagesc (shearIm); axis image; colorbar;

%% 2 Image shearing

Im  = double(imread('baboon.tif'));     % load image
T   = [1 -1/3; 0 1];                    % assign shear matrix

tic
shearimage(Im,T);
toc

tic
shearIm = shearimageFast(Im,T);
toc

%% 3 Image rotation a)
Im  = double(imread('baboon.tif')); 
theta = pi/6;

figure(1); colormap gray;
rotIm = rotateimage(rotIm,-theta,'nearest')
subplot(121); imagesc (Im); axis image; colorbar;
subplot(122); imagesc (rotIm); axis image; colorbar;

%% 3 Image rotation b)
Im  = double(imread('logo.tif')); 
theta = pi/6;

rotIm = rotateimage(Im,theta,'nearest');
nIm = rotateimage(rotIm,-theta,'nearest');

figure(3); colormap gray;
subplot(3,1,1); imagesc (Im); axis image; colorbar;
subplot(3,1,2); imagesc (rotIm); axis image; colorbar;
subplot(3,1,3); imagesc (nIm); axis image; colorbar;

[Ny, Nx] = size(Im);
N = min(min(Nx,Ny));
[x, y] = meshgrid(-ceil((Nx-1)/2):floor((Nx-1)/2), -ceil((Ny-1)/2):floor((Ny-1)/2));
mask = (x.^2 + y.^2)<((N-1)/2)^2;
Im = Im.* mask;

rotIm = rotateimage(Im,theta,'nearest');
nIm = rotateimage(rotIm,-theta,'nearest');

figure(4); colormap gray;
subplot(3,1,1); imagesc (Im); axis image; colorbar;
subplot(3,1,2); imagesc (rotIm); axis image; colorbar;
subplot(3,1,3); imagesc (nIm); axis image; colorbar;

figure(5); colormap gray;
imagesc(nIm-Im);axis image; axis off; colorbar;

ErrorEnergyNearest = sum(sum((nIm-Im).*(nIm-Im)))


%% 3 Image rotation c) comment

Im  = double(imread('logo.tif')); 
theta = pi/6;

rotIm = rotateimage(Im,theta,'nearest');
nIm = rotateimage(rotIm,-theta,'nearest');

fIm  = fftshift(fft2(ifftshift(Im)));
fnIm = fftshift(fft2(ifftshift(nIm)));

FIm_test = log10(abs(fIm));
FIm = log10(1+abs(fIm));

figure(1); colormap gray;
subplot(3,1,1); imagesc (FIm_test); axis image; colorbar;
subplot(3,1,2); imagesc (FIm); axis image; colorbar;
subplot(3,1,3); imagesc (FIm-FIm_test); axis image; colorbar;


%% 3 Image rotation c) 

Im  = double(imread('logo.tif')); 
theta = pi/6;

rotIm = rotateimage(Im,theta,'nearest');
nIm = rotateimage(rotIm,-theta,'nearest');

fIm  = fftshift(fft2(ifftshift(Im)));
fnIm = fftshift(fft2(ifftshift(nIm)));
fImnIm  = fIm - fnIm;

FIm = log10(1+abs(fIm));
FnIm = log10(1+abs(fnIm));
FImnIm = log10(1+abs(fImnIm));

figure(2); colormap gray;
subplot(3,1,1); imagesc (FIm); axis image; colorbar;
subplot(3,1,2); imagesc (FnIm); axis image; colorbar;
subplot(3,1,3); imagesc (FImnIm); axis image; colorbar;

N = size(fIm);

ErrorEnergy = sum(sum((fIm-fnIm).*conj(fIm-fnIm)))/(N(1)*N(2))
sum(sum((nIm-Im).*(nIm-Im)))

figure(21); colormap gray;
relativeError = abs(fIm-fnIm)./abs(fIm);
imagesc (relativeError,[0 2]); colorbar;

%% 3.2 Bilinear Interpolation a

Im  = double(imread('logo.tif')); 
theta = pi/6;

rotIm = rotateimage(Im,theta,'bilinear');
nIm = rotateimage(rotIm,-theta,'bilinear');

figure(3); colormap gray;
subplot(3,1,1); imagesc (Im); axis image; colorbar;
subplot(3,1,2); imagesc (rotIm); axis image; colorbar;
subplot(3,1,3); imagesc (nIm); axis image; colorbar;

[Ny, Nx] = size(Im);
N = min(min(Nx,Ny));
[x, y] = meshgrid(-ceil((Nx-1)/2):floor((Nx-1)/2), -ceil((Ny-1)/2):floor((Ny-1)/2));
mask = (x.^2 + y.^2)<((N-1)/2)^2;
Im = Im.* mask;

rotIm = rotateimage(Im,theta,'bilinear');
nIm = rotateimage(rotIm,-theta,'bilinear');

figure(4); colormap gray;
subplot(3,1,1); imagesc (Im); axis image; colorbar;
subplot(3,1,2); imagesc (rotIm); axis image; colorbar;
subplot(3,1,3); imagesc (nIm); axis image; colorbar;

figure(81); colormap gray;
imagesc(nIm-Im);axis image; axis off; colorbar;

%% 3.2 Bilinear b
ErrorEnergyBilinear = sum(sum((nIm-Im).*(nIm-Im)))

%% 3.2 Bilinear c 

Im  = double(imread('logo.tif')); 
theta = pi/6;

rotIm = rotateimage(Im,theta,'bilinear');
nIm = rotateimage(rotIm,-theta,'bilinear');

fIm  = fftshift(fft2(ifftshift(Im)));
fnIm = fftshift(fft2(ifftshift(nIm)));
fImnIm  = fIm - fnIm;

FIm = log10(1+abs(fIm));
FnIm = log10(1+abs(fnIm));
FImnIm = log10(1+abs(fImnIm));

figure(3); colormap gray;
subplot(3,1,1); imagesc (FIm); axis image; colorbar;
subplot(3,1,2); imagesc (FnIm); axis image; colorbar;


subplot(3,1,3); imagesc (FImnIm); axis image; colorbar;

N = size(fIm);
ErrorEnergy = sum(sum((fIm-fnIm).*conj(fIm-fnIm)))/(N(1)*N(2));

figure(22); colormap gray;
relativeError = abs(fIm-fnIm)./abs(fIm);
imagesc (relativeError,[0 2]); colorbar;


%% 3.3 Bicubic4 Interpolation a

Im  = double(imread('logo.tif')); 
theta = pi/6;

rotIm = rotateimage(Im,theta,'bicubic');
nIm = rotateimage(rotIm,-theta,'bicubic');

figure(3); colormap gray;
subplot(3,1,1); imagesc (Im); axis image; colorbar;
subplot(3,1,2); imagesc (rotIm); axis image; colorbar;
subplot(3,1,3); imagesc (nIm); axis image; colorbar;

[Ny, Nx] = size(Im);
N = min(min(Nx,Ny));
[x, y] = meshgrid(-ceil((Nx-1)/2):floor((Nx-1)/2), -ceil((Ny-1)/2):floor((Ny-1)/2));
mask = (x.^2 + y.^2)<((N-1)/2)^2;
Im = Im.* mask;

rotIm = rotateimage(Im,theta,'bicubic');
nIm = rotateimage(rotIm,-theta,'bicubic');

figure(4); colormap gray;
subplot(3,1,1); imagesc (Im); axis image; colorbar;
subplot(3,1,2); imagesc (rotIm); axis image; colorbar;
subplot(3,1,3); imagesc (nIm); axis image; colorbar;

figure(80); colormap gray;
imagesc(nIm-Im);axis image; axis off; colorbar;

%% 3.3 Bilinear b
ErrorEnergyBilinear = sum(sum((nIm-Im).*(nIm-Im)))

%% 3.3 Bilinear c 

Im  = double(imread('logo.tif')); 
theta = pi/6;

rotIm = rotateimage(Im,theta,'bicubic');
nIm = rotateimage(rotIm,-theta,'bicubic');

fIm  = fftshift(fft2(ifftshift(Im)));
fnIm = fftshift(fft2(ifftshift(nIm)));
fImnIm  = fIm - fnIm;

FIm = log10(1+abs(fIm));
FnIm = log10(1+abs(fnIm));
FImnIm = log10(1+abs(fImnIm));

figure(4); colormap gray;
subplot(3,1,1); imagesc (FIm); axis image; colorbar;
subplot(3,1,2); imagesc (FnIm); axis image; colorbar;


subplot(3,1,3); imagesc (FImnIm); axis image; colorbar;

N = size(fIm);
ErrorEnergy = sum(sum((fIm-fnIm).*conj(fIm-fnIm)))/(N(1)*N(2));

figure(23); colormap gray;
relativeError = abs(fIm-fnIm)./abs(fIm);
imagesc (relativeError,[0 2]); colorbar;

%% 3.3 Bicubic4 Interpolation a

Im  = double(imread('logo.tif')); 
theta = pi/6;

rotIm = rotateimage(Im,theta,'bicubic16');
nIm = rotateimage(rotIm,-theta,'bicubic16');

figure(3); colormap gray;
subplot(3,1,1); imagesc (Im); axis image; colorbar;
subplot(3,1,2); imagesc (rotIm); axis image; colorbar;
subplot(3,1,3); imagesc (nIm); axis image; colorbar;

[Ny, Nx] = size(Im);
N = min(min(Nx,Ny));
[x, y] = meshgrid(-ceil((Nx-1)/2):floor((Nx-1)/2), -ceil((Ny-1)/2):floor((Ny-1)/2));
mask = (x.^2 + y.^2)<((N-1)/2)^2;
Im = Im.* mask;

rotIm = rotateimage(Im,theta,'bicubic16');
nIm = rotateimage(rotIm,-theta,'bicubic16');

figure(4); colormap gray;
subplot(3,1,1); imagesc (Im); axis image; colorbar;
subplot(3,1,2); imagesc (rotIm); axis image; colorbar;
subplot(3,1,3); imagesc (nIm); axis image; colorbar;

figure(5); colormap gray;
imagesc(nIm-Im);axis image; axis off; colorbar;

%% 3.3 Bilinear b
ErrorEnergyBilinear = sum(sum((nIm-Im).*(nIm-Im)))

%% 3.3 Bilinear c 

Im  = double(imread('logo.tif')); 
theta = pi/6;

rotIm = rotateimage(Im,theta,'bicubic16');
nIm = rotateimage(rotIm,-theta,'bicubic16');

fIm  = fftshift(fft2(ifftshift(Im)));
fnIm = fftshift(fft2(ifftshift(nIm)));
fImnIm  = fIm - fnIm;

FIm = log10(1+abs(fIm));
FnIm = log10(1+abs(fnIm));
FImnIm = log10(1+abs(fImnIm));

figure(4); colormap gray;
subplot(3,1,1); imagesc (FIm); axis image; colorbar;
subplot(3,1,2); imagesc (FnIm); axis image; colorbar;


subplot(3,1,3); imagesc (FImnIm); axis image; colorbar;

N = size(fIm);
ErrorEnergy = sum(sum((fIm-fnIm).*conj(fIm-fnIm)))/(N(1)*N(2));

figure(24); colormap gray;
relativeError = abs(fIm-fnIm)./abs(fIm);
imagesc (relativeError,[0 2]); colorbar;

%% 3.5 Image quality
Im  = double(imread('baboon.tif')); 
theta = pi/6.1;

nIm = rotateimage(Im,theta,'nearest');
bIm = rotateimage(Im,theta,'bilinear');
b16Im =rotateimage(Im,theta,'bicubic16');

for k=1:10
    nIm = rotateimage(nIm,theta,'nearest');
    bIm =rotateimage(bIm,theta,'bilinear');
    b16Im =rotateimage(b16Im,theta,'bicubic16');
end
    
figure(1); colormap gray;
subplot(3,1,1); imagesc (nIm); axis image; colorbar;
subplot(3,1,2); imagesc (bIm); axis image; colorbar;
subplot(3,1,3); imagesc (b16Im); axis image; colorbar;