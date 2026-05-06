%% ROCKET MULTI-STAGE OPTIMIZATION MAIN

clear;
close all;
clc;

%% 1. LOAD MISSION DATA

mission = DataDefinition();

%% 2. COMPUTE TOTAL DELTA-V

mission.DV_total = GetDeltaV(mission.latitude, ...
                             mission.H);

fprintf('Total Delta-V required: %.2f m/s\n', ...
        mission.DV_total);

%% 3. DEFINE VEHICLE ARCHITECTURE

architecture = SetArchitecture();

%% 4. DEFINE OPTIMIZATION PARAMETERS

params = SetParams();

%% 5. START OPTIMIZATION

fprintf('\nStarting optimization...\n');

result = OptimizeRocket(mission, architecture, params);

fprintf('Optimization completed.\n');

%% 6. DISPLAY RESULTS

PrintResults(result);

%% 7. OPTIONAL VISUALIZATION

% PlotResults(result);
