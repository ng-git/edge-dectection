function crack = isolateCrack(originalImage,type)
    % Convert a single image to grayscale doubles
    originalImage = adapthisteq(originalImage,'clipLimit',0.01,'Distribution','rayleigh');
    originalImage = imfilter(originalImage,fspecial(char(type)));
    
    
    % Produce an expanded image of the crack and slab
    thresholds=[0.001 0.7]; % originally 0.001 0.4
    edgeGrain=edge(originalImage,'Canny',[0 thresholds(1)]);
    edgeMacro=edge(originalImage,'Canny',[0 thresholds(2)]);
    
    % Construct strel structres for grainy and macro images
    se90g=strel('line',5,90); se0g=strel('line',5,0);
    se90m=strel('line',2,90); se0m=strel('line',2,0);
    grainDilate=imdilate(edgeGrain,[se90g se0g]);
    macroDilate=imdilate(edgeMacro,[se90m se0m]);

    % Fill in the expanded image, and produce a perimeter
    %filled=imfill(macroDilate,'holes');
    filled=imfill(grainDilate,'holes');
    slabPerimeter=bwperim(filled);

    % Subtract most of the outer boundary, leaving a thin line
    macroDilateThin=macroDilate-imdilate(slabPerimeter,[se90m se0m]);
    macroDilateThin=macroDilateThin>0;

    % Erode crack and eliminate remaining thin boundary lines
    isolatedCrackandSpecs=imerode(macroDilateThin,[se90m se90m]);

    % Eliminate remaining specs
    pixel_limit=25; % max number of pixels in a connected region to remove
    crack=bwareaopen(isolatedCrackandSpecs,pixel_limit);
    
    % Set outer columns = 0
    crack(:,1:75)=0; crack(:,525:end)=0;
end