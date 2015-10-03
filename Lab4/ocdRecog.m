function [ number ] = ocrRecog(inputImage)

hist = histogram(inputImage);
T = ocrselectthresh2(inputImage,myMean(inputImage));
BinImage = threshold(inputImage,T,'>');

number = BinImage
end

