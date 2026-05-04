%% ROCKET MULTI-STAGE OPTIMIZATION MAIN
clear;
close all;
clc;

%% 1. LOAD INPUT DATA
data = DataDefinition;

%% 2. COMPUTE IDEAL DELTA-V
DV_ideal = GetDeltaV(data.latitude, data.H);

%% 3. INCLUDE LOSSES (gravity + drag)
DV_gravity_loss = 1500;   % [m/s]
DV_drag_loss    = 300;    % [m/s]

DV_total = DV_ideal + DV_gravity_loss + DV_drag_loss;

fprintf('Total Delta-V required: %.2f m/s\n', DV_total);

%% 4. DEFINE GLOBAL PARAMETERS
params = SetParams();

% Override payload and Delta-V inside params
params.m_payload = data.m_payload;
params.DV_total  = DV_total;

%% 5. OPTIMIZATION PROCESS
% Search for best configuration (Delta-V distribution + mass ratios)
fprintf('\nStarting optimization...\n');

result = OptimizeRocket(params);

fprintf('Optimization completed.\n');

%% 6. DISPLAY RESULTS
PrintResults(result);

%% 7. OPTIONAL: VISUALIZATION
% (You can implement this later if needed)
% PlotResults(result);




