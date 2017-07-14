function [upper,lower]=toleranceBand(histarea,ci,bincounts,binwidth,binpositions)

%Some initializations
instantArea=0;
confArea=(ci*histarea)/100;
totalLength=size(bincounts,2);
meanPosition1=totalLength/2;
meanPosition2=(totalLength/2)+1;
min=10^6;
%

%Loop over each bin of the histogram and sum up the areas, starting from mean 
%In order to reach the value of area corresponding to the confidence interval
for i=0:(meanPosition1-1)
    instantArea = instantArea + binwidth*bincounts(meanPosition1-i) +...
        binwidth*bincounts(meanPosition2+i);
    difference = abs(confArea-instantArea);
    if difference<min
        min=difference;
        upper=binpositions(meanPosition2+i);
        lower=binpositions(meanPosition1-i);
    end
    
end
%

end