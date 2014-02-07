function [ magnitudeArray] = discretizetfarray( tfArray, frequencyVector)
%discretizetfarray  Discretize a single dimension of tf's

arrayLength= size(tfArray,3);
frequencyVectorLength=length(frequencyVector);
magnitudeArray = [frequencyVectorLength, arrayLength];


for iCoeff=1 : 1 : arrayLength
    mag = bode(tfArray(1,1,iCoeff,1),frequencyVector);
    mag = squeeze(mag);
    magnitudeArray(1:frequencyVectorLength,iCoeff) = mag(1:frequencyVectorLength);
end


end

