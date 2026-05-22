function params = SetParams()
% SETPARAMS Optimization and sizing parameters
%
% OUTPUT:
%   params : optimization parameter structure

%% Physical constants

% Standard gravity [m/s^2]
params.g0 = 9.81;

%% Delta-V distribution

% Stage 1 Delta-V fraction search space [-]
params.frac1_range = ...
    linspace(0.55, 0.70, 20);

%% Stage aspect ratios

% Stage 1 aspect ratio [-]
params.AR_stage1 = 4.5;

% Stage 2 aspect ratio [-]
params.AR_stage2 = 5.5;

% Stage 3 aspect ratio [-]
params.AR_stage3 = 7.0;

%% Volumetric efficiencies

% Solid propulsion volumetric efficiency [-]
params.solid_volumetric_efficiency = 0.90;

% Liquid propulsion volumetric efficiency [-]
params.liquid_volumetric_efficiency = 0.90;

%% Geometric correlations

% Solid engine geometric factor [-]
params.solid_engine_factor = 0.30;

% Liquid engine geometric factor [-]
params.liquid_engine_factor = 1.00;

% Nozzle geometric factor [-]
params.nozzle_factor = 0.60;

% Interstage geometric factor [-]
params.interstage_factor = 0.50;

%% Numerical settings

% Maximum number of stored solutions [-]
params.max_solutions = 1000;

%% Target thrust-to-weight ratios

% Stage 1 target thrust-to-weight ratio [-]
params.TW_stage1 = 1.4;

% Stage 2 target thrust-to-weight ratio [-]
params.TW_stage2 = 1.0;

% Stage 3 target thrust-to-weight ratio [-]
params.TW_stage3 = 0.7;

end