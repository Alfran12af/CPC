function architecture = SetArchitecture()
% SETARCHITECTURE Defines launcher architecture
%
% OUTPUT:
%   architecture : struct containing stage definitions
%
% DESCRIPTION:
%   Defines:
%   - propulsion type per stage
%   - allowed propellants
%   - structural fractions
%   - operating conditions

%% =========================================================
%% STAGE 1
%% =========================================================

architecture.stage(1).name = 'Stage 1';

% Motor type
architecture.stage(1).motor = 'solid';

% Operating environment
architecture.stage(1).environment = 'sea_level';

% Structural fraction
architecture.stage(1).epsilon_range = ...
    linspace(0.10,0.16,5);

% Candidate propellants
architecture.stage(1).candidates = ...
{
    'HTPB',
    'HTPB_AL'
};

%% =========================================================
%% STAGE 2
%% =========================================================

architecture.stage(2).name = 'Stage 2';

% Motor type
architecture.stage(2).motor = 'pump-fed';

% Operating environment
architecture.stage(2).environment = 'mixed';

% Structural fraction
architecture.stage(2).epsilon_range = ...
    linspace(0.06,0.12,5);

% Candidate propellants
architecture.stage(2).candidates = ...
{
    'LOX_RP1',
    'LOX_CH4',
    'LOX_LH2'
};

%% =========================================================
%% STAGE 3
%% =========================================================

architecture.stage(3).name = 'Stage 3';

% Motor type
architecture.stage(3).motor = 'pressure-fed';

% Operating environment
architecture.stage(3).environment = 'vacuum';

% Structural fraction
architecture.stage(3).epsilon_range = ...
    linspace(0.08,0.16,5);

% Candidate propellants
architecture.stage(3).candidates = ...
{
    'LOX_CH4',
    'LOX_ETHANOL',
    'LOX_RP1'
};

%% =========================================================
%% GLOBAL VEHICLE CONSTRAINTS
%% =========================================================

% Maximum total length [m]
architecture.max_length = 20;

% Maximum launcher diameter [m]
architecture.max_diameter = 2.0;

% Minimum payload fraction
architecture.min_payload_fraction = 0.005;

end