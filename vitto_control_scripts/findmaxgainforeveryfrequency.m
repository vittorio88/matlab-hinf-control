function [ maxGainTfDiscrete ] = findmaxgainforeveryfrequency( magnitudeArray, frequencyVector )
%findmaxgainforeveryfrequency Find the maximum value for each frequency of
%an array

magnitudeArrayLength=length(magnitudeArray(1,:));
frequencyVectorLength=length(frequencyVector);

maxGainTfDiscrete=[magnitudeArrayLength,1];
for iFrequency=1 : 1 : frequencyVectorLength;
    maxGainTfDiscrete(iFrequency) = max(magnitudeArray(iFrequency,1:magnitudeArrayLength));
end



end

