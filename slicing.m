function slicing()
clc;
clear all;
close all;
workspace; 
image3d=niftiread('Brats17_2013_2_1_t2.nii.gz');
    for sliceIndex =1 : size(image3d, 3)
        thisSlice = image3d(:,:,sliceIndex);
        %thisSlice=thisSlice.*255; %use for seg.nii 
        filename = sprintf('Slice#%d.jpg', sliceIndex);
        imwrite(uint8(thisSlice), filename);
    end
end
