function [Precision, Sensitivity, BER]=Evaluation()
clc;
clear all;
close all;
workspace; 

TN=82;
FP=18;
FN=13;
TP=87;
Precision=TP/(TP+FP);
Sensitivity=TP/(TP+FN);
BER=0.5*(FP/(TN+FP) + FN/(FN+TP));
end