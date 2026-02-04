f=getAllFiles('J:\Education\MSCS\4th_Semester\Thesis\Implementation\source_code\MRI_Brain_Dataset_Training\HGG');
count=1;
for i=1: size(f,1)
 tf=contains(f(i),'flair\'); %change here as 'fair\' or 't1\' or 't1ce\' or 't2\'
 if (tf==1)
    j{count,1}=f(i);
    count=count+1;
 end
end
save('flair.mat','j');  %save as 'flair.mat' or 't1.maat' or 't1ce.mat' or 't2.mat'
% for i=1: size(j,1)
% imshow(imread(char(j{i,1})));
% end
% 
% for i=1:size(j,1)
%     img=imread(char(j{i,1}));
%     %figure, imshow(img);
%     %Extract features here   
% end