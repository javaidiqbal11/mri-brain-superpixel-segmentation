function [flair_img]=flair_read()
all=getAllFiles('J:\Education\MSCS\4th_Semester\Thesis\Implementation\source_code_All_v1.1\HGG');
count=1;
for f=1: size(all,1)
    tf=contains(all(f),'flair\'); 
 if (tf==1)
    flair_img{count,1}=all(f);
    count=count+1;
 end
end
%save('flair.mat','flair_img');
end