function [a, this_slice,this_slice_seg]= slice_read_compute_all(imgf,imgs,slicenumber,trainedClassifier)
            a=[];
            this_slice1 = imgf(:,:,slicenumber);
            this_slice=uint8(rescale(this_slice1,0,255)); 
            this_slice2 = imgs(:,:,slicenumber);
            this_slice_seg=uint8(rescale(this_slice2,0,255)); 
            this_slice_seg = imbinarize(this_slice_seg, graythresh(this_slice_seg));
            %figure(1), imshow(this_slice,[]);
            title('Original Image');
            %figure(2), imshow(this_slice_seg,[]);
            title('Taged Image');
            if mean(this_slice(:))>0.25
            [L,N]=superpixels(this_slice,400);   %Apply superpixel segmentation
            %figure, BW=boundarymask(L);  
            %imshow(imoverlay(this_slice,BW,'cyan'),'InitialMagnification',90);
            %title('SuperPixels');
            
            for patch=1:N                 %N is number of total superpixels/patches
                Temp = zeros(1,7);
                t = (L==patch);            %Apply mask to get the final superpixel/patch
               %figure, imshow(t);
               temp=double(this_slice).*double(t);
               [I, J]=find(t);
               %figure, imshow(t,[]);
               spixel=uint8(temp(min(I):max(I), min(J):max(J)));
               %figure, imshow(spixel,[]);
               if mean(spixel(:))>0.125
                  %figure, imshow(spixel,[]);
                  %===================Statistical Features=================
                  glcms = graycomatrix(spixel, 'offset', [0 1], 'Symmetric', true);
                  x = haralickTextureFeatures(glcms);
                  xFeatures = 1:16;
                  x = haralickTextureFeatures(glcms, 1:16);
                  %x(isnan(x))=0;
                  % x=abs(x);
                  %%==================Texton Features======================
                  gaborArray = gaborFilterBank(5,6,39,39);
                  featureVector = gaborFeatures(spixel,gaborArray,1,1);
                  [rows, columns] = size(spixel);    %reshape the resulted feature vector and responces  
                  F = reshape(featureVector, rows*columns, 30);
                  out_val=kmeans(F(:),5);               %k-means where k=5
                  res=hist(out_val,5);  %Apply histogram of texton map within  each super pixel
                  %res(isnan(res))=0;
                  %res=abs(res);
                  %%=================Fractal Features======================
                  D=sfta(spixel,2);
                  %D(isnan(D))=0;
                  %D=abs(D);
                  %==================Curvature Features====================
                  out=curvature_feature(spixel);
                  %out(isnan(out))=0;
                  %out=abs(out);
                  %===================SIFT Features=================
                  kpd=SIFT_KeyPoints_Descriptors(spixel);
                  for ii=1:size(kpd,2)
                    Temp(ii) = kpd(ii);
                  end
                  
                  T2=table(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8),x(9),x(10),...
                      x(11),x(12),x(13),x(14),x(15),x(16),res(1),res(2),res(3),res(4),...
                      res(5),D(1),D(2),D(3),D(4),D(5),D(6),D(7),D(8),D(9),out(1),Temp(1),...
                      Temp(2),Temp(3),Temp(4),Temp(5),Temp(6),Temp(7)); 
                  
                  %====================Workspace===========================  
                  yfit = trainedClassifier.predictFcn(T2);
                  if yfit==1 
                      a=[a;patch];
                  end
                end
            end
            end
            
end