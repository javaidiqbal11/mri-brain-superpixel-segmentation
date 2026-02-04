function [t1_img]=t1_read()
all=getAllFiles('J:\Education\MSCS\4th_Semester\Thesis\Implementation\source_code\MICCAI_BraTS17_Data_Training\LGG');
count=1;
for f=1: size(all,1)
 tf=contains(all(f),'t1\'); 
 if (tf==1)
    t1_img{count,1}=all(f);
    count=count+1;
 end
end
%save('t1.mat','t1_img');
end