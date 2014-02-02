function [ maxGainValue ] = findmaxgainvalueoftf( tf )


maxGainValue=max(bode(tf));

end

