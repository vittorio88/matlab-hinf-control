% name: findminimumcontrollerorder
% author: vittorio alfieri

function [minimumControllerOrder , steadyStateError, errorFunction] = findminimumcontrollerorder(errorString, GpTf, Ga, Gf, Gs, maxError)

s=tf('s');
%s=sym('s');

% subsitute real values into errorString
subdString= strrep(errorString, 'Gp', tf2string(GpTf)); % sub Gp for Gp nominal
subdString= strrep(subdString, 'Gc', '(1/s^mu)'); % sub Gc for s^mu
subdString= strrep(subdString, 'Gs', num2str(Gs)); % sub Gc for s^mu
subdString= strrep(subdString, 'Ga', num2str(Ga)); % sub Gc for s^mu
subdString= strrep(subdString, 'Gf', num2str(Gf)); % sub Gc for s^mu
subdString= strcat('s*(',subdString,')'); % add s* for fvt





% loops through different order of controller order applying fvt.
for iMu = 0: 3
    
    % sub test mu into mu
    fvtString= strrep(subdString,'mu',int2str(iMu) );
    
    % build tf and perform fvt, result can be null, a real number, or inf.
    limitTf = zpk(eval(fvtString));% build tf
    limitEvaluated=dcgain(limitTf);% t->inf = s->0
    
    % check for NaN
    if limitEvaluated ~= limitEvaluated
        error('evaluated limit is a not numeric');
    end
    
    
    
    % no need to raise mu further
    if limitEvaluated == 0
        %disp('breaking because limit exists and error is null');
        minimumControllerOrder=iMu;
        break; % steady state value is 0
    end
    
    % error is present, but this is acceptable
    if ~isinf(limitEvaluated) % infinity
        if (maxError ~= 0)
            if(limitEvaluated ~= 0)
                %disp('breaking because limit exists and maxError ~= 0');
                minimumControllerOrder=iMu;
                break; % result is neither NaN nor 0
            end
        end
    end
    
    % overflow
    if iMu == 3
        error('did not find any suitable order for mu');
    end
    
end % for loop end

steadyStateError=limitEvaluated;
errorFunction=limitTf;



end % function end
