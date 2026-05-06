function mission = DataDefinition()
% DATADEFINITION Defines mission requirements
%
% OUTPUT:
%   mission : mission definition structure

%% =========================================================
%% MISSION REQUIREMENTS
%% =========================================================

% Target orbit altitude [m]
mission.H = 600e3;

% Payload mass [kg]
mission.m_payload = 20;

%% =========================================================
%% LAUNCH SITE
%% =========================================================

% Launch latitude [deg]
% Mediterranean coast (Murcia)

mission.latitude = 38 + 2/60;

%% =========================================================
%% EARTH CONSTANTS
%% =========================================================

mission.R_E = 6371e3;      % [m]

mission.g0 = 9.81;         % [m/s^2]

mission.mu = 3.986e14;     % [m^3/s^2]

mission.T_E = 86164;       % [s]

%% =========================================================
%% MISSION LOSSES
%% =========================================================

% Typical launch losses

mission.losses.gravity = 1500;   % [m/s]

mission.losses.drag = 300;       % [m/s]

end