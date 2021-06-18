% Group 9 Team Contribution
%Rahul yalavarthi,K.Venkat Chandra,Deepthi Sri,G.Dinesh,E.Yashaswini
% Basic compression of image using svd and conversion into black and white
app=imread(''); %Input the image here
imshow(app)
% Lossy Comp with grayscale
appg=rgb2gray(app);
d=im2double(appg);
[u,s,v]=svd(d);
s1=s;
s1(20:end, :)=0;
s1(:, 20:end)=0;
d1=u*s1*v';
imshow(d1);
% Method 1
% Coloured compression by taking 1:n ratios
L1=app(:,:,1);
L2=app(:,:,2);
L3=app(:,:,3);
%sizing l's for svd.
I1=im2double(L1);
I2=im2double(L2);
I3=im2double(L3);
[u1,s1,v1]=svd(I1);
[u2,s2,v2]=svd(I2);
[u3,s3,v3]=svd(I3);
n = 10;
%for displaying compressed image
R1=0;
R2=0;
R3=0;
%Using for loop to 
for k=1:n
    R1 = R1 +u1(:,k)*s1(k,k)*v1(:,k)';
    R2 = R2 +u2(:,k)*s2(k,k)*v2(:,k)';
    R3 = R3 +u3(:,k)*s3(k,k)*v3(:,k)';  
    R(:,:,1)=R1;
    R(:,:,2)=R2;
    R(:,:,3)=R3;
    imshow(R);
end
% Method 2
%Lossy Comp with different rank values
d=double(appg);
[u,s,v]=svd(d);
dispEr=[];
numSVals=[];
for N=5:15:100
    s1=s;
    s1(N+1:end, :)=0;
    s1(:, N+1:end)=0;
    d1=u*s1*v';
    figure;
    buffer=sprintf('Image comp using rank=%d',N)
    imshow(uint8(d1));
    title(buffer);
    error=sum(sum((d-d1).^2));
    dispEr=[dispEr;error];
    numSVals=[numSVals;N];
end
% Plotting the influence of the above method
figure;
title('Error in compression');
plot(numSVals,dispEr);
grid on
xlabel('K rank');
ylabel('Errors btw comp and original');
%Psnr implementation (UNDER CHANGES)
psnr=10*log10(255/(error).^(1/2))
%Ssim implementation (UNDER CHANGES)
SSIM=ssim(d,d1);
%CR to be implemented in future
%Sample compression using DCT to compare.
im = imread('');    %Input the image here
im = double(im)/255;
im = rgb2gray(im);
subplot(211);
imshow(im)
title('Original Image');
img_dct = dct2(im);
img_pow = (img_dct).^2;
img_pow = img_pow(:);
[B,index] = sort(img_pow);
B = flipud(B);
index = flipud(index);
compressed_dct = zeros(size(im));
coeff = 200;
for k=1:coeff
compressed_dct(index(k)) = img_dct(index(k));
end 
im_dct = idct2(compressed_dct);
subplot(212)
imshow(im_dct)
title('DCT Compressed IMage')