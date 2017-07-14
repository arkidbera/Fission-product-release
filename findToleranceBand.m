function [upper,lower] = findToleranceBand(Temp,nbins,ci)

%Calculate area under histogram
[bincounts,binpositions]=hist(Temp,nbins);
binwidth=binpositions(2)-binpositions(1);
histarea=binwidth*sum(bincounts);
%

%Find tolerance band
[upper,lower]=toleranceBand(histarea,ci,bincounts,binwidth,binpositions);
%

end