function [featureVector] = HOG_Features(img)

% Example: Running the code
% >>> img = imread('flair.jpg');
% >>> hog = HOG_Features(img);

[featureVector,hogVisualization] = extractHOGFeatures(img);
figure, imshow(img); 
hold on;
plot(hogVisualization);
end 