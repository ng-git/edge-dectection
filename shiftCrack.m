function shifted = shiftCrack(crack)
    % shift crack pattern so that its centroid is at the center of matrix
    % also, converts to black and white
    currentCrack=imbinarize(crack);
    [y, x]=ndgrid(1:size(currentCrack, 1), 1:size(currentCrack, 2));
    centroid=mean([x(logical(currentCrack)), y(logical(currentCrack))]);
    centroid=round(centroid);     % convert to int
    
    % centroid=[col,row].  Shift 1's (600-centroidX) columns and
    % (400-centroidY) rows, provided it does not exceed dimensions
    shifted=zeros(400,600);
    rowShift=200-centroid(2); colShift=300-centroid(1);
    for row=1:400
        for col=1:600
            if currentCrack(row,col)==1 ...
                && row+rowShift<=400 ...
                && col+colShift<=600 ...
                && row+rowShift>0 ...
                && col+colShift>0 ...
                    % shift all grayscale (not binary) values
                    shifted(row+rowShift,col+colShift)=crack(row,col);
            end
        end
    end
end