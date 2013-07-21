%%% Process input

%% Get nominal plant transfer function

% Get nominal value for plant coefficients
Gp_coeff1_nominal=(Gp_coeff1_low+Gp_coeff1_high)/2;
Gp_coeff2_nominal=(Gp_coeff2_low+Gp_coeff2_high)/2;
Gp_coeff3_nominal=(Gp_coeff3_low+Gp_coeff3_high)/2;

% substitute nominal values into Gp string
Gp_nominal_string = strrep(Gp_string, 'Gp_coeff1', 'Gp_coeff1_nominal');
Gp_nominal_string = strrep(Gp_nominal_string, 'Gp_coeff2', 'Gp_coeff2_nominal');
Gp_nominal_string = strrep(Gp_nominal_string, 'Gp_coeff3', 'Gp_coeff3_nominal');

% build plant transfer function
Gp_nominal= eval(Gp_nominal_string);
[Gp_nominal_num,Gp_nominal_den]=tfdata(Gp_nominal,'v');

% plant static gain
Kp=dcgain(Gp_nominal);

%% Calculate Feedforward gain
Gf=Gr/(Kd*Gs);



%% Build input functions
dr=buildsignalinputfunction( dr_coeff, dr_type, dr_freq, dr_h, vector_log );
dp=buildsignalinputfunction( dp_coeff, dp_type, dp_freq, dp_h, vector_log );
da=buildsignalinputfunction( da_coeff, da_type, da_freq, da_h, vector_log );
ds=buildsignalinputfunction( ds_coeff, ds_type, ds_freq, ds_h, vector_log );
