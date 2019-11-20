close all, clc
clear all;
load data\raw400x600

% for i = 1:size(edges,3)
%     test(:,:,i) = shiftCrack(edges(:,:,i));
%     figure(1)
%     imshow(test(:,:,i))
%     drawnow, pause(0.7)
% end

dim = [400 600];

a = uint8(dataraw(:,:,:,88));


list = {'average' 'disk' 'gaussian' 'laplacian' 'motion'};

for k = 1:3
    % run through 2 different images sizes
    data = imresize(uint8(a),dim/k);
    % add grayscale as the 4th colormap of an image
    data(:,:,4) = rgb2gray(data);
    
for j = 1:size(data,3)  % go through each colormap RGB and gray
%     input = data(:,:,j);
    input = rgb2gray(imresize(uint8(a),dim/k));
    
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
sum = (BWs(:,:,:,1) + BWs(:,:,:,k))/2;
final = mean(sum,3);

imshow(final)
final = final/max(max(final))-0.06;


