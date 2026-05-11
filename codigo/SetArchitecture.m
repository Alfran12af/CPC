function architecture = SetArchitecture()
% SETARCHITECTURE Defines launcher architecture
%
% OUTPUT:
%   architecture : launcher architecture structure
%
% DESCRIPTION:
%
%   Fixed launcher architecture:
%
%   Stage 1 -> Solid propulsion
%   Stage 2 -> Liquid pressure-fed
%   Stage 3 -> Liquid pump-fed
%
%   The optimization process does NOT modify
%   the architecture itself.
%
%   Optimization variables:
%
%   - Delta-V distribution
%   - Structural fractions
%   - Propellant selection
%
% ==========================================================

%% =========================================================
%% GLOBAL CONFIGURATION
%% =========================================================

architecture.n_stages = 3;

architecture.type = ...
    'Three-stage launch vehicle';

%% =========================================================
%% STAGE 1
%% =========================================================
%
% Solid rocket booster
% Main atmospheric acceleration
%

architecture.stage(1).name = ...
    'Stage 1';

architecture.stage(1).motor = ...
    'solid';

architecture.stage(1).environment = ...
    'sea_level';

%% ---------------------------------------------------------
%% STRUCTURAL FRACTION
%% ---------------------------------------------------------

architecture.stage(1).epsilon_range = ...
    linspace(0.10,0.16,5);

%% ---------------------------------------------------------
%% ALLOWED PROPELLANTS
%% ---------------------------------------------------------

architecture.stage(1).candidates = ...
{
    'HTPB',
    'HTPB_AL'
};

%% =========================================================
%% STAGE 2
%% =========================================================
%
% Pressure-fed liquid stage
% Mid-altitude acceleration
%

architecture.stage(2).name = ...
    'Stage 2';

architecture.stage(2).motor = ...
    'pressure-fed';

architecture.stage(2).environment = ...
    'mixed';

%% ---------------------------------------------------------
%% STRUCTURAL FRACTION
%% ---------------------------------------------------------

architecture.stage(2).epsilon_range = ...
    linspace(0.1,0.18,5);

%% ---------------------------------------------------------
%% ALLOWED PROPELLANTS
%% ---------------------------------------------------------

architecture.stage(2).candidates = ...
{
    'LOX_ETHANOL',
    'LOX_RP1',
    'LOX_CH4'
};

%% =========================================================
%% STAGE 3
%% =========================================================
%
% Pump-fed upper stage
% Orbital insertion stage
%

architecture.stage(3).name = ...
    'Stage 3';

architecture.stage(3).motor = ...
    'pump-fed';

architecture.stage(3).environment = ...
    'vacuum';

%% ---------------------------------------------------------
%% STRUCTURAL FRACTION
%% ---------------------------------------------------------

architecture.stage(3).epsilon_range = ...
    linspace(0.06,0.12,5);

%% ---------------------------------------------------------
%% ALLOWED PROPELLANTS
%% ---------------------------------------------------------

architecture.stage(3).candidates = ...
{
    'LOX_CH4',
    'LOX_LH2',
    'LOX_RP1'
};

%% =========================================================
%% GLOBAL GEOMETRIC CONSTRAINTS
%% =========================================================
%
% Used for preliminary launcher sizing
%

%% ---------------------------------------------------------
%% TOTAL LAUNCHER LENGTH
%% ---------------------------------------------------------

architecture.max_length = 20;      % [m] %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ---------------------------------------------------------
%% MAXIMUM DIAMETER
%% ---------------------------------------------------------

architecture.max_diameter = 2.0;   % [m] %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ---------------------------------------------------------
%% GLOBAL SLENDERNESS
%% ---------------------------------------------------------

architecture.global_slenderness_max = 20; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ---------------------------------------------------------
%% STAGE ASPECT RATIO
%% ---------------------------------------------------------

architecture.stage_AR_min = 3; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

architecture.stage_AR_max = 8; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ---------------------------------------------------------
%% DIAMETER DECAY
%% ---------------------------------------------------------

architecture.diameter_decay_min = 0.60; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% =========================================================
%% PAYLOAD FRACTION
%% =========================================================

architecture.min_payload_fraction = 0.005; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% =========================================================
%% DISPLAY SUMMARY
%% =========================================================

fprintf('\n');
fprintf('=========================================================\n');
fprintf('                 LAUNCHER ARCHITECTURE                  \n');
fprintf('=========================================================\n');

%% ---------------------------------------------------------
%% GLOBAL CONFIGURATION
%% ---------------------------------------------------------

fprintf('\n');
fprintf('---------------- GLOBAL CONFIGURATION -------------------\n');

fprintf('\n');
fprintf('   Launcher type ............... %s\n', ...
        architecture.type);

fprintf('   Number of stages ............ %d\n', ...
        architecture.n_stages);

%% =========================================================
%% STAGE 1
%% =========================================================

fprintf('\n');
fprintf('====================== STAGE 1 ==========================\n');

fprintf('\n');
fprintf('   Propulsion type ............. %s\n', ...
        architecture.stage(1).motor);

fprintf('   Environment ................. %s\n', ...
        architecture.stage(1).environment);

fprintf('   Structural fraction min ..... %.2f\n', ...
        min(architecture.stage(1).epsilon_range));

fprintf('   Structural fraction max ..... %.2f\n', ...
        max(architecture.stage(1).epsilon_range));

fprintf('\n');
fprintf('   Allowed propellants:\n');

for i = 1:length(architecture.stage(1).candidates)

    fprintf('      - %s\n', ...
            architecture.stage(1).candidates{i});

end

%% =========================================================
%% STAGE 2
%% =========================================================

fprintf('\n');
fprintf('====================== STAGE 2 ==========================\n');

fprintf('\n');
fprintf('   Propulsion type ............. %s\n', ...
        architecture.stage(2).motor);

fprintf('   Environment ................. %s\n', ...
        architecture.stage(2).environment);

fprintf('   Structural fraction min ..... %.2f\n', ...
        min(architecture.stage(2).epsilon_range));

fprintf('   Structural fraction max ..... %.2f\n', ...
        max(architecture.stage(2).epsilon_range));

fprintf('\n');
fprintf('   Allowed propellants:\n');

for i = 1:length(architecture.stage(2).candidates)

    fprintf('      - %s\n', ...
            architecture.stage(2).candidates{i});

end

%% =========================================================
%% STAGE 3
%% =========================================================

fprintf('\n');
fprintf('====================== STAGE 3 ==========================\n');

fprintf('\n');
fprintf('   Propulsion type ............. %s\n', ...
        architecture.stage(3).motor);

fprintf('   Environment ................. %s\n', ...
        architecture.stage(3).environment);

fprintf('   Structural fraction min ..... %.2f\n', ...
        min(architecture.stage(3).epsilon_range));

fprintf('   Structural fraction max ..... %.2f\n', ...
        max(architecture.stage(3).epsilon_range));

fprintf('\n');
fprintf('   Allowed propellants:\n');

for i = 1:length(architecture.stage(3).candidates)

    fprintf('      - %s\n', ...
            architecture.stage(3).candidates{i});

end

%% =========================================================
%% GLOBAL CONSTRAINTS
%% =========================================================

fprintf('\n');
fprintf('---------------- GLOBAL CONSTRAINTS ---------------------\n');

fprintf('\n');
fprintf('   Maximum launcher length ..... %.2f m\n', ...
        architecture.max_length);

fprintf('   Maximum diameter ............ %.2f m\n', ...
        architecture.max_diameter);

fprintf('   Maximum slenderness (L/D) ... %.2f\n', ...
        architecture.global_slenderness_max);

fprintf('\n');
fprintf('   Stage AR minimum ............ %.2f\n', ...
        architecture.stage_AR_min);

fprintf('   Stage AR maximum ............ %.2f\n', ...
        architecture.stage_AR_max);

fprintf('\n');
fprintf('   Minimum diameter decay ...... %.2f\n', ...
        architecture.diameter_decay_min);

fprintf('   Minimum payload fraction .... %.4f\n', ...
        architecture.min_payload_fraction);

fprintf('\n');
fprintf('=========================================================\n');

end