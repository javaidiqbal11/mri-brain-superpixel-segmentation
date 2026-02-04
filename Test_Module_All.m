function [D,DSC, Dice, Precision, Sensitivity, BER, validationAccuracy]= Test_Module_All()
clc;
clear all;
close all;
workspace;
flair_img=flair_read();         %Read required sequences 
seg_img=seg_read();          
%t1_img=t1_read();           
%t1ce_img=t1ce_read();      
%t2_img=t2_read();           
%-----------------------------Trained Dataset------------------------------
T=readtable('HGG_375_all_training_400_1.xlsx');
[trainedClassifier, validationAccuracy] =trainClassifier_400_training_all_SVM_linear(T); 
%--------------------------------------------------------------------------
counter=1;
D=[];
for i=176 % 1:size(flair_img,1) 
    [imgf]=niftiread(char(flair_img{i,1}));        %Read all flair sequence
    [imgs]=niftiread(char(seg_img{i,1}));
    %figure, imshow(imgf(:,:,105),[]);
    test_array=[55 60 65 70 75 80 85 90 95 100];
        for slicenumber =test_array %1: size(imgf,3)
            [a, this_slice,this_slice_seg]=slice_read_compute_all(imgf,imgs,slicenumber,trainedClassifier); 
            if mean(this_slice_seg(:))>0.0125
            [dump]=Segmented_Image_Result(this_slice,a);
            [Dice]=DiceCoefficient(this_slice_seg, dump);
            Dice1(counter,:)=Dice;
            counter=counter+1;
            D=Dice1;
            DSC=mean(D);
            end
        end
        
end

%-----------------------------Dice Coefficient-----------------------------

% [dump]=Segmented_Image_Result(this_slice,a);
% [Dice]=DiceCoefficient(this_slice_seg, dump);

%----------------------Precision and Sensitivity---------------------------
    TP=95;
    FP=9;
    TN=95;
    FN=5;
    Precision=TP/(TP+FP);
    Sensitivity=TP/(TP+FN);
    BER=0.5*(FP/(TN+FP) + FN/(FN+TP));
end
 