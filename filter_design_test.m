
attenuateValue = 0.01;
attenuateFrequency=10;
Sp=1.3295;
systemType=1;
arbitraryHighFrequency=2000;
s=tf('s');
elbowBoost=0;

% butterworth polynomials

Bn{1}='(s/polePos+1)';
Bn{2}='((s/polePos)^2 + sqrt(2)*s/polePos + 1)';
Bn{3}='( (s/polePos+1) * ((s/polePos)^2 + s/polePos + 1) )';
Bn{4}='( ( (s/polePos)^2 + 0.7654*(s/polePos) +1 ) * ((s/polePos)^2 + 1.8478*(s/polePos) + 1 )';

if elbowBoost ==0
    Bfilt=strcat('gain*s^systemType/',Bn{systemType});
    % decrease gain until evalfr of filter at attenuate frequency is less than attenuate value
    for gain = 0.3 : -0.0001 : 0
        filter =  gain*s^systemType;
        if abs(evalfr(filter,1i*attenuateFrequency)) < attenuateValue
            break
        end
    end
    
    % Decrease polePos until evalfr of filter at high frequency	is less than Sp
    for polePos = arbitraryHighFrequency : -1 : attenuateFrequency
        filter=eval(Bfilt);
        if abs(evalfr(filter,1i*9000)) <  Sp
            break
        end
    end
end


% elbowBoost mode adds a pole after attenuate frequency to increase gain
if elbowBoost ==1
    Bfilt=strcat('(gain*s^systemType*(s/attenuateFrequency+1))/',Bn{systemType+1});
    % decrease gain until evalfr of filter at attenuate frequency is less than attenuate value
    for gain = 0.01 : -0.00001 : 0
        filter =  gain*s^systemType*(s/attenuateFrequency+1);
        %abs(evalfr(filter,1i*attenuateFrequency)) % uncomment me to see if
        %value properly converges to attenuateValue
        if abs(evalfr(filter,1i*attenuateFrequency)) < attenuateValue
            break
        end
    end
    
    % Decrease polePos until evalfr of filter at high frequency	is less than Sp
    for polePos = arbitraryHighFrequency : -1 : attenuateFrequency
        filter=eval(Bfilt);
%         abs(evalfr(filter,1i*9000))% uncomment me to see if
        %value properly converges to attenuateValue
        if abs(evalfr(filter,1i*9000)) <  Sp
            break
        end
    end
end

%  Debug output
% filter
% filtzpk= zpk(filter);
% filtzpk.display='frequency';
% filtzpk= zpk(filter)
% bode(tf(Sp),tf(attenuateValue),filter)



if countpolesatorigin(filter^-1) ~= systemType
    error('systemType does not equal number of poles of specified')
end

