function [ filter, filter_stable ] = buildhighpassbwfilterfrommask3( attenuateValueInDb, attenuateFrequency, steadyStateValue, frequencyVector ,order )
%buildhighpassbwfilterfrommask Given filter mask specification, will build
%2nd order roll up then roll down high pass butterworth filter.
%attenuateValueInDb: low frequency value to attenuate
%attenuateFrequency: low frequency value to attenuate
%steadyStateValue: value to roll down to
%frequencyVector: frequeny vector for alignment in vector dimensions
s=tf('s');
    zeropos = attenuateFrequency;
    filter = 10^((attenuateValueInDb-3)/20)*( s^2/zeropos^2 + sqrt(2)*s/zeropos + 1)/1;
    filterNumeratorMagnitudeVector = squeeze(bode(filter ,frequencyVector));
    steadyStateMagnitudeVector = squeeze(bode(tf(steadyStateValue),frequencyVector));

    % Chose butterworth pole position by finding intersection frequency
    % between filterNumeratorMagnitudeVector and steadyStateMagnitudeVector
    for sfreq=1 : 1 : length(frequencyVector)
        if roundTo(filterNumeratorMagnitudeVector(sfreq),1) == roundTo(steadyStateMagnitudeVector(sfreq),1)
            polepos=frequencyVector(sfreq);
            break;
        end
    end

filter_stable = 10^((attenuateValueInDb-3)/20)*( s^2/zeropos^2 + sqrt(2)*s/zeropos + 1)/(s^2/polepos^2 + sqrt(2)*s/polepos + 1);
end


