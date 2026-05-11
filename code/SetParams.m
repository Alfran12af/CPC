function params = SetParams()
% SETPARAMS Defines optimization parameters
%
% OUTPUT:
%   params : optimization settings structure
%
% DESCRIPTION:
%
%   Contains:
%
%   - physical constants
%   - Delta-V search space
%   - numerical settings
%   - geometric assumptions
%   - solver configuration
%

%% =========================================================
%% PHYSICAL CONSTANTS
%% =========================================================

params.g0 = 9.81;          % Standard gravity [m/s^2]

%% =========================================================
%% DELTA-V DISTRIBUTION SEARCH SPACE
%% =========================================================
%
% f1 + f2 + f3 = 1
%
% Typical launcher distributions:
%
%   Stage 1 -> 40-60%
%   Stage 2 -> 20-40%
%   Stage 3 -> remaining
%
% ==========================================================

params.frac1_range = ...
    linspace(0.40,0.60,10);

params.frac2_range = ...
    linspace(0.20,0.40,10);

%% =========================================================
%% GEOMETRIC ASSUMPTIONS
%% =========================================================
%
% Preliminary stage geometry assumptions
%

%% ---------------------------------------------------------
%% TARGET STAGE ASPECT RATIO
%% ---------------------------------------------------------
%
% Used in equivalent cylindrical sizing
%
% Typical values:
%
%   AR = L/D ≈ 4-6
%

params.target_stage_AR = 5.5;

%% ---------------------------------------------------------
%% VOLUMETRIC EFFICIENCY
%% ---------------------------------------------------------
%
% Accounts for:
%
%   - insulation
%   - internal structures
%   - unused volume
%   - ullage
%

params.solid_volumetric_efficiency = 0.85;

params.liquid_ullage_factor = 1.10;

%% =========================================================
%% ENGINE SECTION CORRELATIONS
%% =========================================================
%
% Preliminary geometric estimations
%

%% ---------------------------------------------------------
%% SOLID MOTORS
%% ---------------------------------------------------------

params.solid_engine_factor = 0.3;

%% ---------------------------------------------------------
%% LIQUID ENGINES
%% ---------------------------------------------------------

params.liquid_engine_factor = 1.0;

%% ---------------------------------------------------------
%% NOZZLE SECTION
%% ---------------------------------------------------------

params.nozzle_factor = 0.6;

%% ---------------------------------------------------------
%% INTERSTAGE SECTION
%% ---------------------------------------------------------

params.interstage_factor = 0.5;

%% =========================================================
%% NUMERICAL SETTINGS
%% =========================================================

params.max_solutions = 1000;

params.verbose = true;

%% =========================================================
%% CONVERGENCE TOLERANCES
%% =========================================================

params.mass_tolerance = 1e-6;

params.geometry_tolerance = 1e-6;

%% =========================================================
%% TARGET THRUST-TO-WEIGHT RATIOS
%% =========================================================
%
% Preliminary propulsion assumptions
%
% Typical launcher values:
%
%   Stage 1 -> 1.2 - 1.6
%   Stage 2 -> 0.7 - 1.2
%   Stage 3 -> 0.3 - 0.8
%

params.TW_stage1 = 1.4;

params.TW_stage2 = 0.9;

params.TW_stage3 = 0.5;

%% =========================================================
%% DISPLAY SUMMARY
%% =========================================================

fprintf('\n');
fprintf('=========================================================\n');
fprintf('                OPTIMIZATION PARAMETERS                 \n');
fprintf('=========================================================\n');

%% ---------------------------------------------------------
%% DELTA-V SEARCH SPACE
%% ---------------------------------------------------------

fprintf('\n');
fprintf('---------------- DELTA-V SEARCH SPACE -------------------\n');

fprintf('\n');
fprintf('   Stage 1 fractions ........... %d values\n', ...
        length(params.frac1_range));

fprintf('   Stage 2 fractions ........... %d values\n', ...
        length(params.frac2_range));

fprintf('   Total combinations .......... %d\n', ...
        length(params.frac1_range) * ...
        length(params.frac2_range));

fprintf('\n');
fprintf('   Stage 1 range ............... %.2f -> %.2f\n', ...
        min(params.frac1_range), ...
        max(params.frac1_range));

fprintf('   Stage 2 range ............... %.2f -> %.2f\n', ...
        min(params.frac2_range), ...
        max(params.frac2_range));

%% ---------------------------------------------------------
%% GEOMETRIC PARAMETERS
%% ---------------------------------------------------------

fprintf('\n');
fprintf('--------------- GEOMETRIC PARAMETERS --------------------\n');

fprintf('\n');
fprintf('   Target stage AR ............. %.2f\n', ...
        params.target_stage_AR);

fprintf('   Solid volumetric efficiency . %.2f\n', ...
        params.solid_volumetric_efficiency);

fprintf('   Liquid ullage factor ........ %.2f\n', ...
        params.liquid_ullage_factor);

%% ---------------------------------------------------------
%% ENGINE CORRELATIONS
%% ---------------------------------------------------------

fprintf('\n');
fprintf('---------------- ENGINE CORRELATIONS --------------------\n');

fprintf('\n');
fprintf('   Solid engine factor ......... %.2f\n', ...
        params.solid_engine_factor);

fprintf('   Liquid engine factor ........ %.2f\n', ...
        params.liquid_engine_factor);

fprintf('   Nozzle factor ............... %.2f\n', ...
        params.nozzle_factor);

fprintf('   Interstage factor ........... %.2f\n', ...
        params.interstage_factor);

%% ---------------------------------------------------------
%% PROPULSION TARGETS
%% ---------------------------------------------------------

fprintf('\n');
fprintf('---------------- PROPULSION TARGETS ---------------------\n');

fprintf('\n');
fprintf('   Target T/W Stage 1 .......... %.2f\n', ...
        params.TW_stage1);

fprintf('   Target T/W Stage 2 .......... %.2f\n', ...
        params.TW_stage2);

fprintf('   Target T/W Stage 3 .......... %.2f\n', ...
        params.TW_stage3);

%% ---------------------------------------------------------
%% NUMERICAL SETTINGS
%% ---------------------------------------------------------

fprintf('\n');
fprintf('---------------- NUMERICAL SETTINGS ---------------------\n');

fprintf('\n');
fprintf('   Maximum solutions ........... %d\n', ...
        params.max_solutions);

fprintf('   Verbose mode ................ %d\n', ...
        params.verbose);

%% ---------------------------------------------------------
%% CONVERGENCE TOLERANCES
%% ---------------------------------------------------------

fprintf('\n');
fprintf('-------------- CONVERGENCE TOLERANCES -------------------\n');

fprintf('\n');
fprintf('   Mass tolerance .............. %.2e\n', ...
        params.mass_tolerance);

fprintf('   Geometry tolerance .......... %.2e\n', ...
        params.geometry_tolerance);

fprintf('\n');
fprintf('=========================================================\n');

end