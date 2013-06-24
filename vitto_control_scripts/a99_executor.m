%% Get started
a1_prepare
a2_data_input
a3_process_input

%% Crunch numbers
calc1_system_type % Finds system type
calc2_freq_char % Translates specifications into frequency characteristics
calc3_filter % Calculates filter mask for S, T, L and generates Generates Ws and Wt


%% Generate hinf controller
%hinf1_gen_uncertain% Generates Wu
hinf2_gen_controller % Generates hinf controller
hinf3_error_calc % Calculates errors for hinf norm minimization method
hinf4_error_sim % Captures error functions from simulink

%% Verification
ver_checks
%ver_figures
%ver_output