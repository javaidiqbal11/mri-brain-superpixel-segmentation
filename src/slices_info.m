function [tr,tr_s,ts, ts_s]=slices_info()
clc;
clear all;
close all;
workspace;
seg_img=seg_read();
tr=[];
ts=[];
for i=15 %1:size(seg_img,1)  %volume count 
    imgs=niftiread(char(seg_img{i,1}));
    %figure, imshow(imgs(:,:,85),[]);
    train_array=[1:54 56:59 61:64 66:69 71:74 76:79 81:84 86:89 91:94 96:99 101:155];
    for slicenumber=train_array %1 : size(imgs,3)
        this_slice1 = imgs(:,:,slicenumber);
        this_slice_seg=uint8(rescale(this_slice1,0,255));
        %figure, imshow(this_slice_seg);
        if mean(this_slice_seg(:))>0
           tr=[tr,slicenumber];
           tr_s=numel(tr);
        end
     end         
    %Test slices info 
    test_array=[55 60 65 70 75 80 85 90 95 100];
    for test_slice=test_array
        this_slice2=imgs(:,:,test_slice);
        this_slice_segt=uint8(rescale(this_slice2,0,255));
        if mean(this_slice_segt(:))>0
            ts=[ts,test_slice];
            ts_s=numel(ts);
        end
    end
end
    
end
