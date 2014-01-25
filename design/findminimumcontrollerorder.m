% name: findminimumcontrollerorder
% author: vittorio alfieri

% example:
% minimumControllerOrder =
% findminimumcontrollerorder(inputSignal,
%                            inputTf,
%                            maxError,
%                            errorSignalNoGc)
%
%
% output:
% minimumControllerOrder =
% 1

% function [minimumControllerOrder , errorValue, fvtString] = findminimumcontrollerorder(inputSignal, errorSignalNoGc, maxError )
function [minimumControllerOrder , errorValue, errorFunction] = findminimumcontrollerorder(errorString, GpTf, Ga, Gf, Gs, maxError)
% if toleratedError == 0
%     minimumControllerOrder =  nPolesOfHighestOrderInput + nPolesPlant + 1;
% end
%
% if abs(toleratedError) > 0
%     minimumControllerOrder = nPolesOfHighestOrderInput + nPolesPlant;
% end
% s=tf('s');
s=sym('s');
breakOnNonNullError=0; % initialize value

% loosens order requirement if a non-null error is acceptable.
if abs(maxError) > 0
    breakOnNonNullError=1;
end

subdString= strrep(errorString, 'Gp', tf2string(GpTf)); % sub Gp for Gp nominal
subdString= strrep(subdString, 'Gc', '(1/s^mu)'); % sub Gc for s^mu
subdString= strrep(subdString, 'Gs', num2str(Gs)); % sub Gc for s^mu
subdString= strrep(subdString, 'Ga', num2str(Ga)); % sub Gc for s^mu
subdString= strrep(subdString, 'Gf', num2str(Gf)); % sub Gc for s^mu
subdString= strcat('s*(',subdString,')'); % add s* for fvt


disp('maxError')
disp(maxError)


% loops through different order of controller order applying fvt.
for iOrder = 0: 3
  disp('========================')
    fvtString= strrep(subdString,'mu',int2str(iOrder) )
      s=tf('s');
    % evaluate limit
%     limitEvaluated=limit(fvtString,s,0 )
    %     limitEvaluated=eval(limitEvaluated)
    
    
    iOrder
     limitTf = zpk(eval(fvtString))
%     disp('class(limitTf)')
%     class(limitTf)
    limitEvaluated=dcgain(limitTf)
%     disp('class(limitEvaluated)');
%     class(limitEvaluated);
%     
    
    %     if ~isnumeric(limitEvaluated)
    %         error('evaluated limit is a not numeric')
    %     end
    
    
    
    
    if limitEvaluated == 0
        disp('breaking because limit exists and limitEvaluated == 0')
        minimumControllerOrder=iOrder
        break;% result is 0
    end
    
    if limitEvaluated == limitEvaluated % NaN check
        if ~isinf(limitEvaluated) % infinity
            if (breakOnNonNullError == 1)
                if(limitEvaluated ~= 0)
                    disp('breaking because limit exists and breakOnNonNullError=1')
                    minimumControllerOrder=iOrder
                    break; % result is neither NaN nor 0
                end
            end
        end
    end
    
    if iOrder == 3
    error('did not find any suitable order for mu')
    end
    
end % for loop end

errorValue=limitEvaluated;
 errorFunction=limitTf



end % function end
