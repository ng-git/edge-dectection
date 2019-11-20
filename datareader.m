% directory to all DIC folders
mainpath = dir('I:\Test\DIC images\DFCS\3\1*');

newsize = [400 600];
dataraw = zeros(newsize(1), newsize(2),3, length(mainpath));
surfraw = zeros(newsize(1), newsize(2),3, length(mainpath));

% collect image data from every DIC folder
for j = 1:length(mainpath)
%     access each DIC folder and acquire all .JPG file names
    path = dir(char(string(mainpath(j).folder)+ "\" +string(mainpath(j).name) ...
        + "\*.JPG"));
%     collect 10th and last image of each data
    surfraw(:,:,:,j) = imresize(imread(char(string(mainpath(j).folder) + "\" ...
         + string(mainpath(j).name)+ "\" + string(path(10).name))),newsize);
    dataraw(:,:,:,j) = imresize(imread(char(string(mainpath(j).folder) + "\" ...
         + string(mainpath(j).name)+ "\" + string(path(length(path)).name))),newsize);
    disp(j);
end
%      imshow(input(:,:,i))
%     reshape average images of all B folder
%     [m n k] = size(input);
%     data(:,i+(j-1)*length(path)) = reshape(double(flipud(input)),1,m*n);
%     end
    
% save('raw.mat', 'dataraw')
% save('surfraw.mat', 'surfraw')

% 
% clear m n i j mainpath path 