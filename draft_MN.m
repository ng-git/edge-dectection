% close all; clc

% load data\raw400x600




% data = dataraw;
% a = fliplr([1 2 5 8]);
% for i = 1:length(a);
%     data(:,:,:,a(i)) = [];
% end

figure
for i = 1:30
    subplot(6,5,i)
imshow(avg(:,:,i))
% imshow(uint8(dataraw(:,:,:,i)))

end
figure
for i = 31:60
    subplot(6,5,i-30)
imshow(avg(:,:,i))
% imshow(uint8(dataraw(:,:,:,i)))

end
% dataraw = cat(4, dataraw,data);