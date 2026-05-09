%% =========================================================
%% ROCKET MULTI-STAGE OPTIMIZATION MAIN
%% =========================================================
%
% Preliminary design and optimization of a
% 3-stage launch vehicle for 20 kg payload to
% 600 km LEO orbit.
%
% Fixed architecture:
%
%   Stage 1 -> Solid rocket motor
%   Stage 2 -> Liquid pressure-fed
%   Stage 3 -> Liquid pump-fed
%
% Optimization variables:
%
%   - Delta-V distribution
%   - Propellant selection
%   - Structural fractions
%
% ==========================================================

clear;
close all;
clc;

fprintf('\n');
fprintf('=========================================================\n');
fprintf('             ROCKET PRELIMINARY DESIGN TOOL             \n');
fprintf('=========================================================\n');

%% =========================================================
%% 1. LOAD MISSION DATA
%% =========================================================

fprintf('\n');
fprintf('---------------- LOADING MISSION DATA -------------------\n');

mission = DataDefinition();

fprintf('\n');
fprintf('   Mission status .............. LOADED\n');

%% =========================================================
%% 2. COMPUTE TOTAL DELTA-V
%% =========================================================
%
% Computes:
%   - orbital velocity
%   - Earth rotation contribution
%   - gravity losses
%   - aerodynamic losses
%
% Output:
%   mission.DV_total
%
% =========================================================

fprintf('\n');
fprintf('--------------- COMPUTING DELTA-V -----------------------\n');

mission.DV_total = GetDeltaV( ...
                            mission.latitude, ...
                            mission.H);

fprintf('\n');
fprintf('   Total Delta-V required ...... %.2f m/s\n', ...
        mission.DV_total);

%% =========================================================
%% 3. DEFINE FIXED LAUNCHER ARCHITECTURE
%% =========================================================
%
% Fixed launcher concept:
%
%   Stage 1 -> Solid
%   Stage 2 -> Pressure-fed liquid
%   Stage 3 -> Pump-fed liquid
%
% =========================================================

fprintf('\n');
fprintf('-------------- LOADING ARCHITECTURE ---------------------\n');

architecture = SetArchitecture();

fprintf('\n');
fprintf('   Architecture status ......... LOADED\n');

%% =========================================================
%% 4. LOAD OPTIMIZATION PARAMETERS
%% =========================================================
%
% Includes:
%   - Delta-V search space
%   - Structural fractions
%   - Numerical settings
%   - Geometric constraints
%
% =========================================================

fprintf('\n');
fprintf('----------- LOADING OPTIMIZATION DATA -------------------\n');

params = SetParams();

fprintf('\n');
fprintf('   Optimization parameters ..... LOADED\n');

%% =========================================================
%% 5. START OPTIMIZATION
%% =========================================================

fprintf('\n');
fprintf('---------------- STARTING OPTIMIZATION ------------------\n');

result = OptimizeRocket( ...
            mission, ...
            architecture, ...
            params);

fprintf('\n');
fprintf('   Optimization status ......... COMPLETED\n');

%% =========================================================
%% 6. DISPLAY RESULTS
%% =========================================================

fprintf('\n');
fprintf('---------------- DISPLAYING RESULTS ---------------------\n');

PrintResults(result);

%% =========================================================
%% 7. GENERATE PLOTS
%% =========================================================

fprintf('\n');
fprintf('---------------- GENERATING PLOTS -----------------------\n');

PlotResults(result);

fprintf('\n');
fprintf('=========================================================\n');
fprintf('                  END OF EXECUTION                      \n');
fprintf('=========================================================\n');