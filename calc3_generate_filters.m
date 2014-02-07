% calculate_filter.m
% Filter mask generation for sinusoidal disturbances


%% Chose to design Ws to filter da or dp!!!!


%% Create weighting function Ws to represent high pass filter
% Ws.tf.inv is a curve that must be below Ms_lf up until plant sinusoidal input
% frequency, and under Sp at all times.


% create generic Ws if there is no low frequency sinusoidal disturbance
if (dp.values.type == 0 || dp.values.type == 1) && (da.values.type == 0 || da.values.type == 1)
   
        Ws.tf.polepos=Wc.design.value*10^(-1); % Manually move as close to Wc as possible without cutting resonant peak of S
        Ws.tf.inv=S.design.p.value*s^sys.h/(s+Ws.tf.polepos)^sys.h;
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
    
    if sys.h > 0
        Ws.tf.inv=buildhighpassbwfilterfrommask(Ms_lf.value, dp.values.frequency, S.design.p.value , sys.h, 1);
    end
    
    
end

derp=buildhighpassbwfilterfrommask_stabilized(Ms_lf.db, dp.values.frequency, S.design.p.value, vector.log.value);

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
% broken%  check_mt=abs(1/(1 + 1i*dMt_hs.values.frequency*sqrt(2)/(Mt_hf.polepos) + (1i*ds_freq)^2/(Mt_hf.polepos)^2) )% should return Mt
%     check_wt=abs(evalfr(Wt.tf.inv,1i*ds.values.frequency)) % Should return Mt
%     check_wtdb=20*log10(abs(evalfr(Wt.tf.inv,1i*ds.values.frequency))) % should return Mt_db
%     check_wtbutdb=20*log10(abs(evalfr(Wt.tf.inv,1i*Mt_hf.polepos))) %should be-3db
%     bode(Wt_inv,minreal(Wt.tf.inv))
%  bode(Wt.tf.inv)


%% Create weighting function Wu to represent plant uncertainty

%TODO DO ALL UNCERTAINTY TYPES

% create vector containing all possible tf
Gp.uncertainArray = permutatetfstring(Gp.inputString, Gp.coefficient,nPermutations);

% Generate Uncertain weighting function array
Wu.multiplicative.uncertain.value = Gp.uncertainArray/Gp.nominal.tf - 1;

% Discretize uncertainty array and find maximum value for every frequency
Wu.multiplicative.uncertain.discrete = discretizetfarray(Wu.multiplicative.uncertain.value, vector.log.value);

% Get magnitude vector with max for each frequency in array of discrete tf
Wu.multiplicative.tf.discrete = findmaxgainforeveryfrequency(Wu.multiplicative.uncertain.discrete ,vector.log.value);

% Convert discrete model to tf
Wu.multiplicative.tf.value = magnitudevectortotf(Wu.multiplicative.tf.discrete,vector.log.value, 4); % 3rd arg. is order of fit




