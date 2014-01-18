% calculate_filter.m
% Filter mask generation for sinusoidal disturbances

%% Create weighting function Ws to represent high pass filter
% Ws_inv is a curve that must be below Ms_lf up until plant sinusoidal input
% frequency, and under Sp at all times.



% Calculate pole position and generate filters for nonsinusoidal
% disturbances
if dp.type == 0 || dp.type == 1
    
    if sys.h ~= 1
        % OLD, WORKS, but slow
        Ws.tf.polepos=Wc.design.value*10^(-1); % Move as close to Wc as possible without cutting Sp in result
        Ws.tf.inv=S.design.p.value*s^sys.h/(s+Ws.tf.polepos)^sys.h;
    end
    
    % only applicable for h = 1 
    if sys.h ==1
        Ws.tf.inv=S.design.value;
    end
    % Verify Ws_polepos with following command
    %      bode(tf(Sp),S,Ws_inv,tf(s))
end

% % Calculate pole position and generate filters for sinusoidal plant
% % disturbance (CURVE FITTING)
% if dp_type==2
% % bode(tf(Sp),tf(Ms_lf),s^sys_h) % We are trying to combine these 3 tf for
% % different frequency ranges
% Ms_lf_mag = squeeze( bode( tf(Ms_lf), vector_log));
% Sp_mag = squeeze( bode( tf(Sp), vector_log));
% roll_rate_mag = squeeze( bode(Ms_lf*s^sys_h,vector_log));
%
% % Draw out discrete bode plot
% Ws_inv_discrete=[vector_log_slices,1];
% for sfreq=1 : 1 : vector_log_slices;
%     if (10^log10(vector_log(sfreq)) < dp_freq)
%     Ws_inv_discrete(sfreq) = Ms_lf_mag(sfreq);
%     end
%     if (10^log10(vector_log(sfreq)) > dp_freq) && (10^log10(vector_log(sfreq)) < Wc)
%     Ws_inv_discrete(sfreq) = ((Sp-Ms_lf)/(Wc-dp_freq)) * (10^log10(vector_log(sfreq))) + Ms_lf -((Sp-Ms_lf)/(Wc-dp_freq))*dp_freq;
%     end
%     if  (10^log10(vector_log(sfreq)) > Wc)
%     Ws_inv_discrete(sfreq) = Sp_mag(sfreq);
%     end
% end
%
% % Fit model of discrete magnitudes to ZPK
% Ws_inv_packed=vpck(Ws_inv_discrete' , vector_log');
% Ws_inv_fitted=fitsys(Ws_inv_packed,4,[],1); % 2nd order, code 1 = rational fit
% [Aws,Bws,Cws,Dws]=unpck(Ws_inv_fitted);
% [Zws,Pws,Kws]=ss2zp(Aws,Bws,Cws,Dws);
% Ws_inv_zpk=zpk(Zws,Pws,Kws);
%
% % Generate tfs
% Ws_inv=tf(Ws_inv_zpk)
% % [Ws_inv_num , Ws_inv_den] = tfdata(Ws_inv_zpk , 'v');
% % Ws_inv = tf( Ws_inv_num , Ws_inv_den );
% end

% Build Ws manually butterworth 2nd order
if dp.type == 2
    
    
    
    % Calculate Ms_lf based on dp_error_max, and dp_coeff
    if strcmp(class(dp.tf),'double')
        Ms_lf.value=dp.maxError/dp.coefficient;
    end
    if strcmp(class(dp.tf),'tf')
        Ms_lf.value=dp.maxError/dp.coefficient- evalfr(dp.tf,1i*dp.frequency) ;
    end
    Ms_lf.db=20*log10(Ms_lf.value) ;
    % Verify Ws_polepos with following command
    % bode(tf(Sp),S,Ws_inv)
    %     Ws.tf.zeropos = dp.frequency;
    
    % %     Find pole position by graphical technique
    %     Ws_inv_num = 10^((Ms_lf_db-3)/20)*( s^2/Ws_zeropos^2 + sqrt(2)*s/Ws_zeropos + 1)/1;
    %     bode(Ws_inv_num,tf(Sp));
    %     Ws_polepos = 137; % Chosen by finding intersection frequency between Ws_invnum and tf(Sp)
    %     Ws_inv = 10^((Ms_lf_db-3)/20)*( s^2/Ws_zeropos^2 + sqrt(2)*s/Ws_zeropos + 1)/(s^2/Ws_polepos^2 + sqrt(2)*s/Ws_polepos + 1);
    
    
    Ws.tf.inv=buildhighpassbwfilterfrommask(Ms_lf.db, dp.frequency, S.design.p.value, vector.log.value);
    Ws.tf.value=Ws.tf.inv^-1;
    
    % VERIFY
    % bode(tf(Sp),Ws_inv,tf(Ms_lf))
    
    
    % Check Ws_inv
    % % curve fit mode
    % Ws_inv_mag=squeeze(bode(Ws_inv,vector_log));
    % plot(vector_log, Ws_inv_discrete,vector_log, Ws_inv_mag)
    % bode(tf(Sp),tf(Ms_lf),s^sys_h,Wsmod_inv)
    
    % % Manual mode
    % bode(tf(Sp),tf(Ms_lf),Ws_inv)
    % check_ws=abs(evalfr(Ws_inv,1i*dp_freq)) % Should return Ms
    % bode(Ws_inv)
    
end
%% Create weighting function Wt to represent low pass filter
% Wt_inv is a curve that must be below Mt_HF after sinusoidal input
% frequency, and under Tp at all times
if ds.type == 0 || ds.type == 1
    Wt.tf.inv=tf(T.design.p.value); % Inverse of frequency domain constraint on T
end

if ds.type==2
    if strcmp(class(dp.tf),'double')
        Mt_hf.value=ds.maxError*Gs/ds.coefficient;
    end
    if strcmp(class(dp.tf),'tf')
        Mt_hf.value=ds.maxError*Gs/ds.coefficient - evalfr(ds.tf,1i*ds.frequency) ;
    end
    Mt_hf.db=20*log10(Mt_hf.value);
    
    % For butterworth
    Mt_hf.polepos=(ds.frequency^4/(10^((-Mt_hf.db+T.design.p.value)/10)-1) )^(1/4) ;% Valid only for second order lowpass butterworth
    Wt.tf.inv = T.design.p.value/(1 + s*sqrt(2)/( Mt_hf.polepos ) + (s)^2/( Mt_hf.polepos )^2 );
    
end



Wt.tf.value=Wt.tf.inv^-1;
Wt.zpk.value=zpk(Wt.tf.value);
Wt.zpk.notp=zpk(1 + s*sqrt(2)/( Mt_hf.polepos ) + (s)^2/( Mt_hf.polepos )^2 );
Wt.poles=minreal(Wt.tf.value*T.design.p.value); % Pole position equal Wt with dcgain cancelled


% Check Wt_inv
%     check_mt=abs(1/(1 + 1i*ds_freq*sqrt(2)/(Mt_hf_polepos) + (1i*ds_freq)^2/(Mt_hf_polepos)^2) )% should return Mt
%     check_wt=abs(evalfr(Wt_inv,1i*ds_freq)) % Should return Mt
%     check_wtdb=20*log10(abs(evalfr(Wt_inv,1i*ds_freq))) % should return Mt_db
%     check_wtbutdb=20*log10(abs(evalfr(Wt_inv,1i*Mt_hf_polepos))) %should be-3db
%     bode(Wt_inv,minreal(Wt_inv))
%  bode(Wt_inv)


%% Create weighting function Wu to represent plant uncertainty

% Choose function to call based on amount of uncertain variables.
if Gp.nCoefficients == 1
    Gp.uncertainArray = permutatetfstringonedof   (Gp.inputString, ...
        'coeff1', Gp.coefficient(1).low, Gp.coefficient(1).high, nPermutations);
end

if Gp.nCoefficients == 2
    Gp.uncertainArray = permutatetfstringtwodof  (Gp.inputString, ...
        'coeff1', Gp.coefficient(1).low, Gp.coefficient(1).high, ...
        'coeff2', Gp.coefficient(2).low, Gp.coefficient(2).high, nPermutations);
end

if Gp.nCoefficients == 3
    Gp.uncertainArray = permutatetfstringthreedof(Gp.inputString, ...
        'coeff1', Gp.coefficient(1).low, Gp.coefficient(1).high, ...
        'coeff2', Gp.coefficient(2).low, Gp.coefficient(2).high, ...
        'coeff3', Gp.coefficient(3).low, Gp.coefficient(3).high, nPermutations);
end

% Generate Uncertain weighting function array and discretize
Wu.uncertain.array = Gp.uncertainArray/Gp.nominal.tf - 1;


% Discretize uncertainty array and find maximum value for every frequency
Wu.uncertain.discreteArray = discretizetfarray(Wu.uncertain.array, vector.log.value);
Wu.tf.discrete = findmaxgainforeveryfrequency(Wu.uncertain.discreteArray ,vector.log.value);

% Convert discrete model to tf
Wu.tf.value = magnitudevectortotf(Wu.tf.discrete,vector.log.value, 4); % 3rd arg. is order of fit


