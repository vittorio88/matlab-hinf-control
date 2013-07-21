% generate_uncertainty.m
% generate weighting function due to model uncertainty
% requires only data_input.m

%% Generate uncertain Plant transfer function


% Array of transfer functions Gp representing all possible combinations of
% uncertain coefficients.
Gp_uncertain = tf( [vector_uncertainty , vector_uncertainty] ) ;
for cur_i=1 : 1 : vector_uncertainty
    for cur_j=1 : 1 : vector_uncertainty
         Gp_uncertain(cur_i,cur_j)=( 2*(10^5)*(s + Gp_coeff1_vector(cur_i)) )/( (s - 20)*(s + Gp_coeff2_vector(cur_j))*(s/200+1) );
    end
end

%% Plot all possible weighting functions

Wu_uncertain = tf( [vector_uncertainty , vector_uncertainty] );
Wu_uncertain_mag_array = [vector_log_slices,vector_uncertainty^2];
counter=1;

    for cur_i=1 : 1 : vector_uncertainty
        for cur_j=1 : 1 : vector_uncertainty
            
            Wu_uncertain(cur_i,cur_j) = ( Gp_uncertain(cur_i,cur_j)/Gp_nominal - 1 );    
            [mag, phase] = bode(Wu_uncertain(cur_i,cur_j),vector_log);
            mag = squeeze(mag);
             
            Wu_uncertain_mag_array(1:vector_log_slices,counter) = mag(1:vector_log_slices);
            counter=counter+1;
            
        end
    end
    
%% Find Wu
Wu_discrete=[vector_log_slices,1];
for sfreq=1 : 1 : vector_log_slices;
    mag_max=0;
    Wu_discrete(sfreq) = max(Wu_uncertain_mag_array(sfreq,1:vector_uncertainty^2));
end
    
    
%% Obtain tf from Wu_discrete

Wu_packed=vpck(Wu_discrete',vector_log');
Wu_fitted=fitsys(Wu_packed,4); % 2nd argument is order of fit
[A,B,C,D]=unpck(Wu_fitted);
[Z,P,K]=ss2zp(A,B,C,D);
[ Wu_num Wu_den ] = zp2tf(Z,P,K);
Wu = tf( Wu_num , Wu_den );
Wu_inv=Wu^-1;
    