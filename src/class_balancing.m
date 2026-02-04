function [feat1,feat2,feat3, feat4, feat5]=class_balancing()
clc;
clear all;
close all;
one=[];
zero=[];
sm=load('LGG_282_all_training_400.mat');
a = cell2mat(table2array(cell2table(struct2cell(sm))));
start=1;
start1=1;
for i=1:size(a,1)
    if(a(i,end)==1)
        one(start,:)=a(i,:);
        start=start+1;
    else
        zero(start1,:)=a(i,:);
        start1=start1+1;
    end
    
end

 for id=1:5
     val=randperm(size(zero,1),size(one,1));
     new_zero=zero(val,:);
     feat1=vertcat(one,new_zero);
     xlswrite('LGG_282_all_training_400_1.xlsx',feat1);
     
     val=randperm(size(zero,1),size(one,1));
     new_zero=zero(val,:);
     feat2=vertcat(one,new_zero);
     xlswrite('LGG_282_all_training_400_2.xlsx',feat2);
     
     val=randperm(size(zero,1),size(one,1));
     new_zero=zero(val,:);
     feat3=vertcat(one,new_zero);
     xlswrite('LGG_282_all_training_400_3.xlsx',feat3);
     
     val=randperm(size(zero,1),size(one,1));
     new_zero=zero(val,:);
     feat4=vertcat(one,new_zero);
     xlswrite('LGG_282_all_training_400_4.xlsx',feat4);
     
     val=randperm(size(zero,1),size(one,1));
     new_zero=zero(val,:);
     feat5=vertcat(one,new_zero);
     xlswrite('LGG_282_all_training_400_5.xlsx',feat5);
 end
end


