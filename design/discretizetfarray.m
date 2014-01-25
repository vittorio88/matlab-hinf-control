function [ magnitudeArray] = discretizetfarray( tfArray, frequencyVector)
%discretizetfarray  Discretize an array of tf's
%   Up to 3 dimensions!

arrayLength= length(tfArray);
nArrayDimensions=ndims(tfArray);
frequencyVectorLength=length(frequencyVector);
magnitudeArray = [frequencyVectorLength, arrayLength^nArrayDimensions];
counter=1;



if nArrayDimensions == 1
    for iCoeff1=1 : 1 : arrayLength
        mag = bode(tfArray(iCoeff1),frequencyVector);
        mag = squeeze(mag);
        magnitudeArray(1:frequencyVectorLength,counter) = mag(1:frequencyVectorLength);
        counter=counter+1;
    end
end

if nArrayDimensions == 2
    for iCoeff1=1 : 1 : arrayLength
        for iCoeff2=1 : 1 : arrayLength
            mag = bode(tfArray(iCoeff1,iCoeff2),frequencyVector);
            mag = squeeze(mag);
            magnitudeArray(1:frequencyVectorLength,counter) = mag(1:frequencyVectorLength);
            counter=counter+1;
        end
    end
end

if nArrayDimensions == 3
    for iCoeff1=1 : 1 : arrayLength
        for iCoeff2=1 : 1 : arrayLength
            for iCoeff3=1 : 1 : arrayLength
                mag = bode(tfArray(iCoeff1,iCoeff2,iCoeff3),frequencyVector);
                mag = squeeze(mag);
                magnitudeArray(1:frequencyVectorLength,counter) = mag(1:frequencyVectorLength);
                counter=counter+1;
            end
        end
    end
end


end

