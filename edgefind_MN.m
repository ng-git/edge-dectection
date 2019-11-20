function final = edgefind_MN(a)

% close all; clc
% clear all;
dim = [400 600];
a = uint8(a);

% a = imresize(imread('G:\My Drive\AMATH582\AMATH582 project NF MN\Data\1466\DSC_0230.JPG'),[400 600]);
% a = imresize(imread('G:\My Drive\AMATH582\AMATH582 project NF MN\Data\1469\DSC_0231.JPG'),[400 600]);
% a = imresize(imread('G:\My Drive\AMATH582\AMATH582 project NF MN\Data\1472\DSC_0146.JPG'),dim);
% a = uint8(dataraw(:,:,:,6));
list = {'average' 'disk' 'gaussian' 'laplacian' 'motion'};

for k = 1:2
    % run through 2 different images sizes
    data = imresize(uint8(a),dim/k);
    % add grayscale as the 4th colormap of an image
    data(:,:,4) = rgb2gray(data);
    
for j = 1:size(data,3)  % go through each colormap RGB and gray
    input = data(:,:,j);
    
% edge detect
for i = 1:length(list) % go through each filter type
    % enhance contrast
    I = adapthisteq(input,'clipLimit',0.01,'Distribution','rayleigh');
    % apply filter
    I = imfilter(I,fspecial(char(list(i))));
    % edge detect
%     BWs(:,:,i*j*k) = imresize(edge(I,'canny', fudgeFactor * threshold),dim);
    BWs(:,:,i+(j-1)*size(data,3),k) = imresize(edge(I,'canny', [0.2 0.75]),dim);

end
end
end
sum = BWs(:,:,:,1) + BWs(:,:,:,k);
final = mean(sum,3);
% size(final)
final = final/max(max(final))-0.06;
% final = final/max(max(final));

% figure
% imshow((final))

end
