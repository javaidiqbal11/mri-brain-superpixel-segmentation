function [train_feat]=Train_Module_All()
clc;
clear all;
close all;
workspace;
flair_img=flair_read();         %Read required sequences
seg_img=seg_read();            
%t1_img=t1_read();             
%t1ce_img=t1ce_read();         
%t2_img=tclear2_read();        
 
%--------------------------------------------------------------------------
featureRow = 1; 
for i=206 %1:size(flair_img,1)
    imgf=niftiread(char(flair_img{i,1}));     %read all flair sequences
    %figure, imshow(imgf(:,:,85),[]);
    train_array=[1:54 56:59 61:64 66:69 71:74 76:79 81:84 86:89 91:94 96:99 101:155];
        for slicenumber =train_array %1 : size(imgf,3)
            this_slice1 = imgf(:,:,slicenumber);
            this_slice=uint8(rescale(this_slice1,0,255));   
            %figure, imshow(this_slice,[]);
            if mean(this_slice(:))>0.25
            [L,N]=superpixels(this_slice,400);  %apply superpixel segmentation (SLIC Algorithm)
            %figure, BW=boundarymask(L);  
            %imshow(imoverlay(this_slice,BW,'cyan'),'InitialMagnification',90);
            %title('SuperPixels');
            for patch=1:N            %N is the number of total superpixels/patches.
               Temp = zeros(1,7);
               t = (L==patch);       %Apply mask to get the final superpixel/patch
               %figure, imshow(t);     
               imgs=niftiread(char(seg_img{i,1}));   %Read ground truth
               %figure, imshow(imgs(:,:,85),[]);
                   this_slice2 = imgs(:,:,slicenumber);
                   this_slice_seg=uint8(rescale(this_slice2,0,255));
                   %this_slice_seg = imbinarize(this_slice_seg, graythresh(this_slice_seg));
                   %figure,imshow(this_slice_seg,[]);
                   labeled=double(t).*double(this_slice_seg);      %Superpixel label here Normal or Abnormal 
                   pixelCountr=nnz(labeled(:));
                   pixelCountt=nnz(t(:));
                   result=(pixelCountr/pixelCountt)*100;
                   if result>50
                   result=1;
                   else
                   result=0;
                   end
                   lb=result;
                   temp=double(this_slice).*double(t);
                   [I, J]=find(t);
                   %figure, imshow(temp,[]);
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
                  %x=abs(x);
                  %%==================Texton Features======================
                  gaborArray = gaborFilterBank(5,6,39,39);
                  featureVector = gaborFeatures(spixel,gaborArray,1,1);
                  [rows, columns] = size(spixel);    %reshape the resulted feature vector and responces  
                  F = reshape(featureVector, rows*columns, 30);
                  out_val=kmeans(F(:),5);            %k-means where k=5
                  res=hist(out_val,5);            %Apply histogram of texton map within  each super pixel
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
                  %====================Workspace===========================
                  feat1(featureRow,:)=[x(1:16)' res D out ,Temp(1),...
                  Temp(2),Temp(3),Temp(4),Temp(5),Temp(6),Temp(7),lb];
                  %feat2(featureRow,:)=[lb];
                  featureRow = featureRow + 1;
                  train_feat=feat1;               
                  %label=feat2;                  
                  %save('HGG_26_taining_400.mat', 'train_feat');
                  save('HGG_603_all_training_400.mat','train_feat');
                  end
            end
            end
       end
end

end          