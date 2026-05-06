function params = SetParams()
% SETPARAMS Defines optimization parameters
%
% OUTPUT:
%   params : optimization settings
%
% DESCRIPTION:
%   Contains:
%   - numerical parameters
%   - search ranges
%   - optimization discretization

%% =========================================================
%% PHYSICAL CONSTANTS
%% =========================================================

params.g0 = 9.81;    % [m/s^2]

%% =========================================================
%% DELTA-V DISTRIBUTION SEARCH SPACE
%% =========================================================
%
% f1 + f2 + f3 = 1
%
% Typical launcher distributions:
%   Stage 1 -> 40-60%
%   Stage 2 -> 25-40%
%   Stage 3 -> remaining
%

params.frac1_range = linspace(0.40,0.60,10);

params.frac2_range = linspace(0.20,0.40,10);

%% =========================================================
%% NUMERICAL SETTINGS
%% =========================================================

% Maximum number of stored solutions
params.max_solutions = 1000;

% Enable verbose mode
params.verbose = true;

%% =========================================================
%% GEOMETRIC ASSUMPTIONS
%% =========================================================

% Initial reference diameter [m]
params.reference_diameter = 0.5;

%% =========================================================
%% CONSTRAINTS TOLERANCES
%% =========================================================

params.mass_tolerance = 1e-6;

end