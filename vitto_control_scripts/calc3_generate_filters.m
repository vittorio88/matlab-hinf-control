% calculate_filter.m
% Filter mask generation for sinusoidal disturbances

%% Create weighting function Ws to represent high pass filter
% Ws_inv is a curve that must be below Ms_lf up until plant sinusoidal input
% frequency, and under Sp at all times.


% Calculate Ms_lf based on dp_error_max, and dp_coeff
Ms_lf=dp_error_max/dp_coeff;
Ms_lf_db=20*log10(Ms_lf);

% Calculate pole position and generate filters for nonsinusoidal
% disturbances
if dp_type == 0 || dp_type == 1
    
    Ws_polepos=Wc*10^(-1); % Move as close to Wc as possible without cutting Sp in result
    Ws_inv=Sp*s^sys_h/(s+Ws_polepos);
    
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
if dp_type == 2
    % Verify Ws_polepos with following command
    % bode(tf(Sp),S,Ws_inv)
    Ws_zeropos = dp_freq;
    
    % %     Calculate pole positions by quadratic factoring (doesn't work)
    %     quadfaca= 1 - ( sqrt(2) + 2 ) * 10^((Ms_lf_db-3)/20) / 10^((Sp_db-3)/20)
    %     quadfacb= sqrt(2)*Ws_zeropos
    %     quadfacc= Ws_zeropos^2
    %     quadans1=(-quadfacb+sqrt(-quadfacb^2 - 4*quadfaca*quadfacc))/(2*quadfaca)
    %     quadans2=(-quadfacb-sqrt(-quadfacb^2 - 4*quadfaca*quadfacc))/(2*quadfaca)
    %     Ws_inv = 10^((Ms_lf_db-3)/20)*( s^2/Ws_zeropos^2 + sqrt(2)*s/Ws_zeropos + 1)/((s+quadans1)*(s+quadans2));
    
    
    % %     Calculate pole position by counting decades remaining to Sp (imprecise)
    %   Ws_decades_to_Sp = ( Sp_db - Ms_lf_db )/( 2*20 ); % Number of decades required to arrive to 0dB.
    %   Ws_polepos=10^(abs(Ws_decades_to_Sp)+1) + dp_freq;
    %   Ws_inv= 10^(Ms_lf_db/20)*(1 + 1.414*s /dp_freq  + (s^2)/(dp_freq^2) )/( 1 + 1.414*s / (Ws_polepos) + (s^2)/(Ws_polepos^2));
    
    % %     Find pole position by graphical technique
    %     Ws_inv_num = 10^((Ms_lf_db-3)/20)*( s^2/Ws_zeropos^2 + sqrt(2)*s/Ws_zeropos + 1)/1;
    %     bode(Ws_inv_num,tf(Sp));
    %     Ws_polepos = 137; % Chosen by finding intersection frequency between Ws_invnum and tf(Sp)
    %     Ws_inv = 10^((Ms_lf_db-3)/20)*( s^2/Ws_zeropos^2 + sqrt(2)*s/Ws_zeropos + 1)/(s^2/Ws_polepos^2 + sqrt(2)*s/Ws_polepos + 1);
    
    
    
    % %     Find pole position finding intersection (automatic, good)
    % bode(Ws_inv_num,tf(Sp));
    % Set numerator of filter to second order butterworth polynomial
    Ws_inv_num = 10^((Ms_lf_db-3)/20)*( s^2/Ws_zeropos^2 + sqrt(2)*s/Ws_zeropos + 1)/1;
    Ws_inv_num_mag = squeeze(bode(Ws_inv_num,vector_log));
    Sp_num_mag = squeeze(bode(tf(Sp),vector_log));
    % Chose 2nd butterworth pole position by finding intersection frequency between Ws_invnum and tf(Sp)
    for sfreq=1 : 1 : vector_log_slices
        if roundTo(Ws_inv_num_mag(sfreq),1) == roundTo(Sp_num_mag(sfreq),1)
            Ws_polepos=vector_log(sfreq);
            break;
        end
    end
    %  Ws_polepos = 137; % manually set value to test filter
    Ws_inv = 10^((Ms_lf_db-3)/20)*( s^2/Ws_zeropos^2 + sqrt(2)*s/Ws_zeropos + 1)/(s^2/Ws_polepos^2 + sqrt(2)*s/Ws_polepos + 1);
end


Ws=Ws_inv^-1;
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


%% Create weighting function Wt to represent low pass filter
% Wt_inv is a curve that must be below Mt_HF after sinusoidal input
% frequency, and under Tp at all times
if ds_type == 0 || ds_type == 1
    Wt_inv=tf(Tp); % Inverse of frequency domain constraint on T
end

if ds_type==2
    Mt_hf=ds_error_max*Gs/ds_coeff;
    Mt_hf_db=20*log10(Mt_hf);
    
    % For butterworth
    Mt_hf_polepos=(ds_freq^4/(10^((-Mt_hf_db+Tp_db)/10)-1) )^(1/4) ;% Valid only for second order lowpass butterworth
    Wt_inv = Tp/(1 + s*sqrt(2)/( Mt_hf_polepos ) + (s)^2/( Mt_hf_polepos )^2 );
    
end



Wt=Wt_inv^-1;
Wt_zpk=zpk(Wt);
Wt_zpk_notp=zpk(1 + s*sqrt(2)/( Mt_hf_polepos ) + (s)^2/( Mt_hf_polepos )^2 );
Wt_poles=minreal(Wt*Tp); % Pole position equal Wt with dcgain cancelled


% Check Wt_inv
%     check_mt=abs(1/(1 + 1i*ds_freq*sqrt(2)/(Mt_hf_polepos) + (1i*ds_freq)^2/(Mt_hf_polepos)^2) )% should return Mt
%     check_wt=abs(evalfr(Wt_inv,1i*ds_freq)) % Should return Mt
%     check_wtdb=20*log10(abs(evalfr(Wt_inv,1i*ds_freq))) % should return Mt_db
%     check_wtbutdb=20*log10(abs(evalfr(Wt_inv,1i*Mt_hf_polepos))) %should be-3db
%     bode(Wt_inv,minreal(Wt_inv))
%  bode(Wt_inv)


%% Create weighting function Wu to represent plant uncertainty

% Choose function to call based on amount of uncertain variables.
if nGp_coeffs == 1
    Gp_uncertain_array = permutatetfstringonedof(Gp_string,'Gp_coeff1', Gp_coeff1_low, Gp_coeff1_high, nPermutations);
end

if nGp_coeffs == 2
    Gp_uncertain_array = permutatetfstringtwodof(Gp_string, 'Gp_coeff1', Gp_coeff1_low, Gp_coeff1_high, 'Gp_coeff2', Gp_coeff2_low, Gp_coeff2_high, nPermutations);
end

if nGp_coeffs == 3
    Gp_uncertain_array = permutatetfstringthreedof(Gp_string, 'Gp_coeff1', Gp_coeff1_low, Gp_coeff1_high, 'Gp_coeff2', Gp_coeff2_low, Gp_coeff2_high, 'Gp_coeff3', Gp_coeff3_low, Gp_coeff3_high, nPermutations);
end

% Generate Uncertain weighting function array and discretize
Wu_uncertain_array = Gp_uncertain_array/Gp_nominal - 1;


% Discretize uncertainty array and find maximum value for every frequency
Wu_uncertain_discrete = discretizetfarray(Wu_uncertain_array, vector_log);
Wu_discrete = findmaxgainforeveryfrequency(Wu_uncertain_discrete,vector_log);

% Convert discrete model to tf
Wu = magnitudevectortotf(Wu_discrete,vector_log, 4); % 3rd arg. is order of fit

