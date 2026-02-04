function [Dice]=DiceCoefficient(this_slice_seg, dump)
        Seg1 = this_slice_seg(:);
        Seg2 = dump(:);
        VoxelsNumber1=sum(Seg1); 
        VoxelsNumber2=sum(Seg2);
        CommonArea=sum(Seg1 & Seg2); 
        Dice=(2*CommonArea)/(VoxelsNumber1+VoxelsNumber2);
end