function [ filter , polepos] = flattenrisingtftoconstvalue( risingtf, steadyStateValue, frequencyVector )
%flattenrisingtftoconstvalue Will flatten out a rising tf to a certain
%value, useful for finding pole position for tf to finish on Sp

% Bn{1}='(s/polePos+1)';
% Bn{2}='((s/polePos)^2 + sqrt(2)*s/polePos + 1)';
% Bn{3}='( (s/polePos+1) * ((s/polePos)^2 + s/polePos + 1) )';
% Bn{4}='( ( (s/polePos)^2 + 0.7654*(s/polePos) +1 ) * ((s/polePos)^2 + 1.8478*(s/polePos) + 1 )';


s=tf('s');
tfMagnitudeVector = squeeze(bode(risingtf ,frequencyVector));

% Chose butterworth pole position by finding intersection frequency
for sfreq=1 : 1 : length(frequencyVector)
    % find frequency which is 3db away from intersection- 1.4125
    if (roundTo((tfMagnitudeVector(sfreq) ),2) >= roundTo(steadyStateValue,2))
        polepos=frequencyVector(sfreq);
        break;
    end
end

filter = risingtf/ (s^2/polepos^2 + sqrt(2)*s/polepos + 1);


end


