% a0_executor.m
% Runs scripts sequentially to generate and verify an hinf controller


%% Get started
a1_prepare % prepares workspace
a2_data_input_examsim1 % input controller specification
a3_process_input % Interpret some input to prepare for further analysis.

%% Crunch numbers
calc1_system_type % Finds system type
calc2_frequency_characteristics % Translates specifications into frequency characteristics
calc3_generate_filters % Calculates filter mask for S and T and generate Ws, Wt, and Wu


%% Generate hinf controller
hinf1_chose_weighting_functions % Choses weighting functions for hinf controller
hinf2_generate_controller % Generates hinf controller
hinf3_calculate_ss_error % Calculates errors using generated controller
% hinf4_simulate_and_extract_errors % Captures error functions from simulink

%% Verification
% xout1_print_mfile
% xout2_print_figures
% xout3_print_report