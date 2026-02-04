function [dump]=Segmented_Image_Result(this_slice,a)
temp1=zeros(240,240);
dump=zeros(240,240);
[L,N]=superpixels(this_slice,400);
for patch=1:N
     for i=1:length(a)
     if(patch==a(i))
        temp1 = (L==patch);                    
        dump=double(dump)+ double(temp1);
        %dump=imbinarize(dump, graythresh(dump));
              %dump=diff(dump);
              %filler=zeros(240,240);
              %dump=cat(3,filler,filler,dump);
     end
     end
end
%dump=uint8(rescale(dump,0,255));
%dump=uint8(dump) + uint8(this_slice);
%figure(3),imshow(dump,[]);  
title('Segmented Image');
end