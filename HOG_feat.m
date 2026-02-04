function hog=HOG_feat(spixel)

%Example
%img = imread('cameraman.tif');
%hog=HOG_feat(img);

[hog, visualization] = extractHOGFeatures(spixel,'CellSize',[64 64]);
%subplot(1,2,1);
%imshow(spixel);
%subplot(1,2,2);
%plot(visualization);
end