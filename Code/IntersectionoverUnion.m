

%% initialize
IOUM=zeros(1,34); %initialize
intersection=0;
union=0;
for m = 1:34

%% -------------TEXTURE SEGMENTATION CODE-----------(VIEW THE OTHER TEXTURE SEGMENTATION CODE)-------------------------
img =sprintf("F:\\!Computer Vision\\Project\\code\\Sample images\\TestImages\\Finished Binary\\%d.jpg",m);
img = rgb2gray(imread(img));

%imshow(img)
%title('Original Image')

E = entropyfilt(img);

Eim = rescale(E);

BW1 = imbinarize(Eim,0.85);
%imshow(BW1)
title('Thresholded Texture Image')

s= size(BW1);
BW12 = zeros(s(1),s(2));


B = zeros(s(1), s(2));
for i=1:s(1)
    for j=1:s(2)
        if (BW1(i,j) == 1)
            B(i,j) = 1;
        else
            B(i,j) = 0;
        end
    end
end

M = ones(105,105);

aux = imfilter(B, M);

for i=1:s(1)
    for j=1:s(2)
        if (B(i,j) == 1 && aux(i,j)>4500)
            BW12(i,j) = 1;
        end
    end
end


BWao = logical(BW12);
nhood = ones(9);
closeBWao = imclose(BWao,nhood);

mask = imfill(closeBWao,'holes'); %IMPORTANT OUTPUT FROM TEXTURE FILTERING
%% -----IOU-----------------------
%----------READ DATA AND GET READ FOR CALCULATION--------------
Bstring=sprintf('F:\\!Computer Vision\\Project\\code\\Sample images\\TestImages\\Finished Binary\\%d_B.png',m);
A=mask; %SET A
B=imread(Bstring);
B=im2bw(B); %SET B
%-------------INITALIZE SIZE OF UNION AND INTERSECTION AND IoU------------
unionM=zeros(size(A,1),size(A,2),3);
IoUM=zeros(size(A,1),size(A,2),3);
intM=zeros(size(A,1),size(A,2),3);
%-----------------INTERSECTION AND UNION CALCULATION
    for i = 1:size(A,1);
        for j= 1:size(A,2);
            if A(i,j)== 1 && B(i,j)==1; %DEFINITION OF THE INTERSECTION, ALSO A SUBSET OF THE UNION
                intersection = intersection+1; 
                 intM(i,j,1)= 255;
                 union= union+1;
                unionM(i,j,3)= 255;
            elseif (A(i,j)== 1 || B(i,j)==1 ) %DEFINITION OF THE UNION
                union= union+1;
                unionM(i,j,3)= 255;
                IoUM(i,j,3)=255;
            else
            end 
        end 
    end 
  IoUM(:,:,1)=A(:,:,1);
  IoUM(:,:,3)=B(:,:,1);
  %-------SHOW IMAGES-----------
figure
subplot(1,4,1)
imshow(img)
subplot(1,4,2)
a=imshow(intM)
subplot(1,4,3)
b=imshow(unionM)
 subplot(1,4,4)
imshow(IoUM)
%-----------------------------
IoU = intersection/union;
IOUM(1,m)= IoU ;
end
%% RESULTS---------------
IoUMean=mean(IOUM,'all') %TAKES THE MEAN
subplot(1,4,1)
imshow(img)
subplot(1,4,2)
a=imshow(intM)
subplot(1,4,3)
b=imshow(unionM)
 subplot(1,4,4)
imshow(IoUM)