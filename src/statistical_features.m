function [y]=statistical_features(I)
    I = double(I(I~=0).');
    N = length(I);
     
          mean = sum(I)/N;
%          featuresN(i,1) = mean;
     
         standardDevation = sqrt(sum((I-mean).^2)/N);
%          featuresN(i,2) = standardDevation;
     
         smoothness = 1 - ( 1/(1 + standardDevation^2));
%          featuresN(i,3) = smoothness;
     
         skewness = sum((I-mean).^3)/ (N* (standardDevation^3));
%          featuresN(i,4) = skewness;
     
         kurtosis = sum((I-mean).^4)/ ((N-1)* standardDevation^4);
%          featuresN(i,5) = kurtosis;
     
         p = zeros(1,256);
         for j = 1: 255
             p(j+1) = ((length(I(I==j)))/length(I))^2;
         end
     
         uniformity = sum(p);
%          featuresN(i,6) = uniformity;
      
         modifiedStandardDeviation = 0;
         for k = 1: 255
              modifiedStandardDeviation = modifiedStandardDeviation + sum(((I(I==k) - mean).^2 * (length(I(I==k))/N)));
         end
       
         modifiedStandardDeviation = sqrt(modifiedStandardDeviation);
%          featuresN(i,7) = modifiedStandardDeviation;
     
         modifiedSkew = 0;
         for m = 1: 255
            modifiedSkew = modifiedSkew + sum(((I(I==m) - mean).^3 * (length(I(I==m))/N)));
         end
         modifiedSkew = modifiedSkew/ (standardDevation^3);
%          featuresN(i,8) = modifiedStandardDeviation;
     
         averageHistogram = N/255;
            % Features concatenation
           % featuresAbNormal(i,:)={double(mean) double(standardDevation) double(smoothness) double(skewness) double(kurtosis) double(uniformity) double(modifiedStandardDeviation) double(modifiedSkew) double(averageHistogram)}; 
        
end     