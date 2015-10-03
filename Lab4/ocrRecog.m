function [ number ] = ocrRecog(inputImage)
load thinphase1.mat
load thinphase2.mat
load thinphase3.mat
load thinphase4.mat
load endpoints.mat

hist = histogram(inputImage);
T = meanhist(hist);
T = ocrselectthresh1(hist,T);
T = leastError(hist,T);
BinImage = threshold(inputImage,T,'<');

newimage (BinImage, 'Thres', 5);

contractImage = contract(BinImage, 4, 1);
expandImage = expand(contractImage, 4, 5);
contractImage = contract(expandImage, 4, 2);

newimage (contractImage, 'Closed', 5);

skelletonImage = logop4(contractImage, 0, -1, 0, thinphase1, thinphase2, thinphase3, thinphase4);

skelletonImage = logop(skelletonImage, 0, -1, 14, endpoints);

[labeledImage, numberOfLabels] = labeling(skelletonImage,4);

newimage (skelletonImage, 'Skell', 5);

    C = zeros(1,numberOfLabels);
    
    for i = 1:numberOfLabels
        
        C(i) = sum(sum(labeledImage==i));
        
    end
    
    [maxValue indx] = max(C);

extractedImage = ocrextract(labeledImage,indx);
nbr = ocrdecide(extractedImage,4);

number = nbr;
end

