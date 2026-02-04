function [ D ] = sfta( I, nt )
% SFTA extracts texture features from the grayscale image I using the SFTA 
% algorithm (Segmentation-based Fractal Texture Analysis).
%
%    Returns a 1 by 6*nt vector D extracted from the input grayscale image I 
%    using the SFTA (Segmentation-based Fractal Texture Analysis) algorithm. The
%    feature vector corresponds to texture information extracted from the input
%    image I.
%
%    If necessary, the input image is converted to a grayscale image with 
%    bit-depth of 8.
%
%Example:
%   I=imread('s33.jpg');
%   D=sfta(I,4);
%
% 

    % If necessary, convert I to a grayscale image with bit-depth of 8.
    I = im2uint8(I);
    if size(I,3) ~= 1
        I = rgb2gray(I);
    end

    T = otsurec( I, nt );
    dSize = (numel(T) * 6) - 3;     %24-3=21 values 
    D = zeros(1, dSize);
    pos = 1;
    for t = 1 : numel(T)
        thresh = T(t);
        
        Ib = imbinarize(I, thresh); 
        Ib = findBorders(Ib);
        
        vals = double(I(Ib));
        
        D(pos) = hausDim(Ib);
        pos = pos + 1;
        
        D(pos) = mean(vals);
        pos = pos + 1;

        D(pos) = numel(vals);
        pos = pos + 1;
    end
    
    T = [T; 1.0];
    range = getrangefromclass(I);
    range = range(2);
    
    for t = 1 : (numel(T) - 2)
        lowerThresh = T(t);
        upperThresh = T(t + 1);
            
        Ib = I > (lowerThresh * range) & I < (upperThresh * range);
        Ib = findBorders(Ib);
        
        vals = double(I(Ib));
        
        D(pos) = hausDim(Ib);
        pos = pos + 1;
        
        D(pos) = mean(vals);
        pos = pos + 1;

        D(pos) = numel(vals);
        pos = pos + 1;
    end
    
end