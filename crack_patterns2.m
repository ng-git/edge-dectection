clear all; close all; clc
load data\raw400x600.mat

%% Isolate crack patterns
numImages=size(dataraw,4);
pix_thresh=80;      % threshold below which pixel values -> 0
isolatedCracks=zeros(numImages,size(dataraw,1)*size(dataraw,2));

list = {'average' 'disk' 'gaussian' 'laplacian' 'motion'};
dim = [400 600];
for j=1:numImages
    for k=1:length(list)    
        currentImage=uint8(dataraw(:,:,:,j));
        currentImage=double(rgb2gray(currentImage));
        currentImage=currentImage.*(currentImage>pix_thresh);
        crack(:,:,k)=isolateCrack(currentImage,list(k));
    end
    avg(:,:,j) = mean(crack,3);
    avg(:,:,j) = avg(:,:,j)/max(max(avg(:,:,j)));
    
    avgShifted=shiftCrack(avg(:,:,j));
    
    %isolatedCracks(j,:)=reshape(avg(:,:,j),1,[]);
    isolatedCracks(j,:)=reshape(avgShifted,1,[]);
%     pcolor((avg(:,:,j))), shading interp, colormap(gray), pause(0.2)
    
end
   
    
%% Examine all images
for j=1:numImages
    crack=isolatedCracks(j,:);
    crack=reshape(crack,[size(dataraw,1),size(dataraw,2)]);
    original=uint8(dataraw(:,:,:,j));
    original=double(rgb2gray(original));
%     imshow(imfuse(original,crack))  % display original image with crack outline
    pcolor(crack), shading interp, colormap(gray)
     pause(0.5)

%     saveas(imshow(imfuse(original,crack)), char("comparisons\comparisons_"+string(j)+".png"),'png');

end

%% PCA
for j=1:numImages
    currentMean=mean(isolatedCracks(j,:));
    isolatedCracks(j,:)=isolatedCracks(j,:)-currentMean;
end
[U,S,V]=svd(isolatedCracks,'econ');

%% Singular value spectrum
figure
singvals=diag(S)/max(diag(S));
scatter(1:length(singvals),singvals)

%% principal components
figure(), title("Principal Components")
subplot(2,2,1)
pcolor(reshape(V(:,1),size(dataraw,1),size(dataraw,2)))
shading interp, colormap(gray), axis off, title("PC1")
subplot(2,2,2)
pcolor(reshape(V(:,2),size(dataraw,1),size(dataraw,2)))
shading interp, colormap(gray), axis off, title("PC2")
subplot(2,2,3)
pcolor(reshape(V(:,3),size(dataraw,1),size(dataraw,2)))
shading interp, colormap(gray), axis off, title("PC3")
subplot(2,2,4)
pcolor(reshape(V(:,4),size(dataraw,1),size(dataraw,2)))
shading interp, colormap(gray), axis off, title("PC4")




