% name: findminimumcontrollerorder
% author: vittorio alfieri

% example:
% minimumControllerOrder =
% findminimumcontrollerorder(toleratedError, inputOrder, nPlantPoles)
%
%
% output:
% minimumControllerOrder =
% 1

function [minimumControllerOrder , errorvalue] = findminimumcontrollerorder(inputSignal, inputTf, maxError, errorSignalNoGc)

% if toleratedError == 0
%     minimumControllerOrder =  nPolesOfHighestOrderInput + nPolesPlant + 1;
% end
% 
% if abs(toleratedError) > 0
%     minimumControllerOrder = nPolesOfHighestOrderInput + nPolesPlant;
% end
s=tf('s');
breakOnNonNullError=0;

% loosens order requirement if a non-null error is acceptable.
if abs(maxError) > 0
    breakOnNonNullError=1;
end

% loops through different order of controller order applying fvt.
for iOrder = 0: 3
temptf= inputSignal*inputTf*errorSignalNoGc*s^(iOrder+1); % fvt, +1 is for s inside limit of fvt
tempstring = tf2string(temptf);


s=sym('s');
limitevaluated=limit(tempstring,s,0);
s=tf('s');

if limitevaluated == 0
%     minimumControllerOrder =iOrder
        break;
end

if limitevaluated == limitevaluated % NaN check
if (breakOnNonNullError == 1)
    if(limitevaluated ~= 0)
%     minimumControllerOrder =iOrder;
        break;
    end
end
end


end % for loop end
errorvalue=limitevaluated;
minimumControllerOrder=iOrder;

end % function end
