function [out] =curvature_feature(I)
%
boundaries = bwboundaries(I);
x = boundaries{1}(:, 2);
y = boundaries{1}(:, 1);
windowSize = 10;
halfWidth = floor(windowSize/2);   
curvatures = zeros(size(x));

for k = halfWidth+1 : length(x) - halfWidth
	theseX = x(k-halfWidth:k+halfWidth);   
	theseY = y(k-halfWidth:k+halfWidth);   
	coefficients = polyfit(theseX, theseY, 2);
	curvatures(k) = coefficients(1);
	xc(k) = x(k);
	yc(k) = y(k);	
end
clc
curvatures(abs(curvatures) > 20) = 0;

%plot(x, curvatures, 'b-');
%hold on 
%plot(y, curvatures, 'r-');
min_Cur = min(curvatures);

max_Cur = max(curvatures);
[L, W] = size(curvatures);

CurCur = curvatures;
for i = 1 :L
    for j = 1 : W
        if CurCur (i,j) < 0 
           CurCur (i,j) =  CurCur (i,j) +(abs(min_Cur));
        elseif CurCur (i,j) > 0  
            CurCur (i,j) =  CurCur (i,j) + 100;
        end
    end
end
curvatures = CurCur;
%%Mean value of curvature for each superpixel
out=mean(curvatures);
%disp(out);

%sprintf("Mean value of curvature",out);
%%

minC = min(curvatures);
maxC = max(curvatures);
range = ceil(maxC - minC);
myColorMap = jet(range);

%imshow(I);
%hold on;
%{
for k = halfWidth+1 : length(x) - halfWidth
	thisIndex = round(size(myColorMap, 1) * (curvatures(k) - minC) / range);
    %fprintf('For point #%d, the colormap index is %d\n', k, thisIndex);
	if thisIndex <= 0
		thisIndex = 1;
	end
	if isnan(thisIndex)
		thisIndex = 1;
    end
	thisColor = myColorMap(thisIndex, :);
	%plot(x(k), y(k), '.', 'MarkerSize', 15, 'Color', thisColor);
end
%}
end