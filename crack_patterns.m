% clear all; close all; clc
load raw400x600.mat

%% Loop through all images
pix_thresh=80;   % threshold below which pixel values -> 0
for j=1:size(dataraw,4)
    current=uint8(dataraw(:,:,:,j));
    current=double(rgb2gray(current));
    pcolor(current.*(current>pix_thresh)), shading interp, colormap(gray)
    pause(0.01)
end

%% Convert a single image to grayscale doubles
im=6;
testu=uint8(dataraw(:,:,:,im));
test=double(rgb2gray(testu)); test=test.*(test>pix_thresh);
figure(1), pcolor(test), shading interp, colormap(gray)

%% Find the edges, eliminate grainy parts
thresholds=[0.0001 0.7];
test_edge_grainy=edge(test,'Canny',[0 thresholds(1)]);
test_edge_macro=edge(test,'Canny',[0 thresholds(2)]);
figure(2), pcolor(test_edge_grainy), shading interp, colormap(gray)
title("test edge grainy")
figure(3), pcolor(test_edge_macro), shading interp, colormap(gray)
title("test edge macro")

%% Fill in grainy image, subtract from macro (un-grainy) image
se90=strel('line',3,90); se0=strel('line',3,0);
test_grainy_dilate=imdilate(test_edge_grainy,[se90,se0]);
test_macro_dilate=imdilate(test_edge_macro,[se90,se0]);
figure(4), pcolor(test_grainy_dilate), shading interp, colormap(gray)
title("test grainy dilate")
figure(5), pcolor(test_macro_dilate), shading interp, colormap(gray)
title("test macro dilate")
test_fill=imfill(test_grainy_dilate,'holes');
figure(6), pcolor(test_fill), shading interp, colormap(gray)
title("test fill")

%% 6*~5
test_carve=test_fill.*(~test_macro_dilate);
figure(7), pcolor(test_carve), shading interp, colormap(gray)

%%

figure(8), pcolor(~test_fill), shading interp, colormap(gray)
figure(9), pcolor(~test_carve), shading interp, colormap(gray)

%% 6*7*9
final=test_fill.*test_carve;
final=final.*(~test_carve);
figure(10), pcolor(final), shading interp, colormap(gray)

%% other stuff (don't use)
test_outeredges=bwperim(test_fill);
figure(7), pcolor(test_outeredges), shading interp, colormap(gray)
title("test outer edges")

%% Dilate fig 7, subtract from fig 5
test_outeredges_dilate=imdilate(test_outeredges,[se90,se0]);
figure(8), pcolor(test_outeredges_dilate),shading interp, colormap(gray)
title("test outer edges dilate")
%
test_remove_outer_border=test_macro_dilate.*double(~test_outeredges_dilate);
figure(9), pcolor(test_remove_outer_border); % flip 1's and 0's
shading interp,colormap(gray)



