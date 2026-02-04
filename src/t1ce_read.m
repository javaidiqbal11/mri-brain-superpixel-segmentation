function [t1ce_img]=t1ce_read()
all=getAllFiles('J:\Education\MSCS\4th_Semester\Thesis\Implementation\source_code_v1.0\MICCAI_BraTS17_Data_Training\LGG');
count=1;
for f=1: size(all,1)
 tf=contains(all(f),'t1ce\'); 
 if (tf==1)
    t1ce_img{count,1}=all(f);
    count=count+1;
 end
end
%save('t1ce.mat','t1ce_img');
end