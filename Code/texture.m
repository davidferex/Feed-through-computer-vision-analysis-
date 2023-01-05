function [L,result] = texture(image)

%imshow(img)
%title('Original Image')

img = rgb2gray(image);
E = entropyfilt(img);

Eim = rescale(E);

%imshow(Eim);

%figure(2)

BW1 = imbinarize(Eim,0.85);

%imshow(BW1)
%title('Thresholded Texture Image')

s= size(BW1);
BW12 = zeros(s(1),s(2));

%Convert from Logical matrix to numbers
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
%figure(3)
%imshow(BW12)


%We need logicals again
BWao = logical(BW12);

nhood = ones(9);
closeBWao = imclose(BWao,nhood);
%figure(4)
%imshow(closeBWao)
%title('Closed Texture Image')

mask = imfill(closeBWao,'holes');
%imshow(mask);
%title('Mask of Bottom Texture')


L = mask+1;
%figure(5)
%imshow(labeloverlay(img,L))
result = labeloverlay(img,L);
end

