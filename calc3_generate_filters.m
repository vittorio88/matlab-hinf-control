% calculate_filter.m
% Filter mask generation for sinusoidal disturbances


%% Chose to design Ws to filter da or dp!!!!


%% Create weighting function Ws to represent high pass filter
% Ws.tf.inv is a curve that must be below Ms_lf up until plant sinusoidal input
% frequency, and under Sp at all times.


% create generic Ws if there is no low frequency sinusoidal disturbance
if (dp.values.type == 0 || dp.values.type == 1) && (da.values.type == 0 || da.values.type == 1)
    
    if sys.h == 0
        Ws.tf.inv=S.design.p.value;
    end
    
    % TODO CHECKME
    % only applicable for h = 1
    if sys.h == 1
        Ws.tf.inv=S.design.value;
    end
    
    
    if sys.h > 1
        Ws.tf.polepos=Wc.design.value*10^(-1); % Manually move as close to Wc as possible without cutting resonant peak of S
        Ws.tf.inv=S.design.p.value*s^sys.h/(s+Ws.tf.polepos)^sys.h;
    end
    %      Verify Ws_polepos with following command
    %      bode(tf(Sp),S,Ws.tf.inv,tf(s))
        
end




% Build Ws manually butterworth 2nd order
if da.values.type == 2
    
    % Calculate Ms_lf based on values.coefficient, errors.max, and
    % values.tf if present
    if isa(da.values.tf,'double')
        Ms_lf.value=da.errors.max/da.values.coefficient;
    end
    if isa(da.values.tf,'tf')
        Ms_lf.value=da.errors.max/da.values.coefficient- evalfr(da.values.tf,1i*da.values.frequency) ;
    end
    Ms_lf.db=20*log10(Ms_lf.value) ;
    
    if sys.h == 0
        Ws.tf.inv=buildhighpassbwfilterfrommask_stabilized(Ms_lf.db, da.values.frequency, S.design.p.value, vector.log.value);
    end
    
    if sys.h >0
        Ws.tf.inv=buildhighpassbwfilterfrommask(Ms_lf.value, da.values.frequency, S.design.p.value , sys.h, 0);
    end
    
end


% Build Ws from dp sinusoidal disturbance
if dp.values.type == 2
    
    % Calculate Ms_lf based on values.coefficient, errors.max, and
    % values.tf if present
    if isa(dp.values.tf,'double')
        Ms_lf.value=dp.errors.max/dp.values.coefficient;
    end
    if isa(dp.values.tf,'tf')
        Ms_lf.value=dp.errors.max/dp.values.coefficient - evalfr(dp.values.tf,1i*dp.values.frequency) ;
    end
    Ms_lf.db=20*log10(Ms_lf.value) ;
    
    if sys.h == 0
        Ws.tf.inv=buildhighpassbwfilterfrommask_stabilized(Ms_lf.db, dp.values.frequency, S.design.p.value, vector.log.value);
    end
    
    if sys.h >0
        Ws.tf.inv=buildhighpassbwfilterfrommask(Ms_lf.value, dp.values.frequency, S.design.p.value , sys.h, 0);
    end
    
    
end

bode(tf(S.design.p.value),tf(Ms_lf.value),Ws.tf.inv)
Ws.tf.value=Ws.tf.inv^-1;


%% Verify Ws

% bode(tf(S.design.p.value),tf(Ms_lf.value),Ws.tf.inv)
% check_ws=abs(evalfr(Ws_inv,1i*dp_freq)) % Should return Ms
% bode(Ws_inv)


%% Create weighting function Wt to represent low pass filter
% Wt_inv is a curve that must be below Mt_HF after sinusoidal input
% frequency, and under Tp at all times
if ds.values.type == 0 || ds.values.type == 1
    Wt.tf.inv=tf(T.design.p.value); % Inverse of frequency domain constraint on T
end

if ds.values.type==2
    if isa(ds.values.tf,'double')
        Mt_hf.value=ds.errors.max*Gs/ds.values.coefficient;
    end
    if isa(ds.values.tf,'tf')
        Mt_hf.value=ds.errors.max*Gs/ds.values.coefficient - evalfr(ds.values.tf,1i*ds.values.frequency) ;
    end
    Mt_hf.db=20*log10(Mt_hf.value);
    
    % For butterworth
    Mt_hf.polepos=(ds.values.frequency^4/(10^((-Mt_hf.db+T.design.p.value)/10)-1) )^(1/4) ;% Valid only for second order lowpass butterworth
    Wt.tf.inv = T.design.p.value/(1 + s*sqrt(2)/( Mt_hf.polepos ) + (s)^2/( Mt_hf.polepos )^2 );
    
end


Wt.tf.value=Wt.tf.inv^-1;
Wt.zpk.value=zpk(Wt.tf.value);
Wt.zpk.notp=zpk(1 + s*sqrt(2)/( Mt_hf.polepos ) + (s)^2/( Mt_hf.polepos )^2 );
Wt.poles=minreal(Wt.tf.value*T.design.p.value); % Pole position equal Wt with dcgain cancelled


%% Veriy Wt

% Check Wt_inv
% broken%  check_mt=abs(1/(1 + 1i*ds.values.frequency*sqrt(2)/(Mt_hf_polepos) + (1i*ds_freq)^2/(Mt_hf_polepos)^2) )% should return Mt
%     check_wt=abs(evalfr(Wt.tf.inv,1i*ds.values.frequency)) % Should return Mt
%     check_wtdb=20*log10(abs(evalfr(Wt.tf.inv,1i*ds.values.frequency))) % should return Mt_db
%     check_wtbutdb=20*log10(abs(evalfr(Wt_inv,1i*Mt_hf_polepos))) %should be-3db
%     bode(Wt_inv,minreal(Wt_inv))
%  bode(Wt_inv)


%% Create weighting function Wu to represent plant uncertainty


%% TODO CHECK ME
% Choose function to call based on amount of uncertain variables.
if length(Gp.coefficient) == 1
    Gp.uncertainArray = permutatetfstringonedof   (Gp.inputString, ...
        Gp.coefficient(1).name, Gp.coefficient(1).low, Gp.coefficient(1).high, nPermutations);
end

if length(Gp.coefficient) == 2
    Gp.uncertainArray = permutatetfstringtwodof  (Gp.inputString, ...
        Gp.coefficient(1).name, Gp.coefficient(1).low, Gp.coefficient(1).high, ...
        Gp.coefficient(2).name, Gp.coefficient(2).low, Gp.coefficient(2).high, nPermutations);
end

if length(Gp.coefficient) == 3
    Gp.uncertainArray = permutatetfstringthreedof(Gp.inputString, ...
        Gp.coefficient(3).name, Gp.coefficient(1).low, Gp.coefficient(1).high, ...
        Gp.coefficient(3).name, Gp.coefficient(2).low, Gp.coefficient(2).high, ...
        Gp.coefficient(3).name, Gp.coefficient(3).low, Gp.coefficient(3).high, nPermutations);
end

% Generate Uncertain weighting function array and discretize
Wu.uncertain.array = Gp.uncertainArray/Gp.nominal.tf - 1;


% Discretize uncertainty array and find maximum value for every frequency
Wu.uncertain.discreteArray = discretizetfarray(Wu.uncertain.array, vector.log.value);
Wu.tf.discrete = findmaxgainforeveryfrequency(Wu.uncertain.discreteArray ,vector.log.value);

% Convert discrete model to tf
Wu.tf.value = magnitudevectortotf(Wu.tf.discrete,vector.log.value, 4); % 3rd arg. is order of fit


