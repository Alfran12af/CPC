function mission = DataDefinition()
% DATADEFINITION Mission parameters and physical constants
%
% OUTPUT:
%   mission : mission data structure

%% Mission requirements

mission.m_payload = 20;      % Payload mass [kg]
mission.H         = 600e3;   % Orbit altitude [m]

mission.orbit            = 'LEO';
mission.circular_orbit   = true;

%% Launch site

mission.launch_site = 'Mediterranean Coast';
mission.latitude    = 43;    % Latitude [deg]

%% Earth constants

mission.R_E = 6371e3;        % Earth radius [m]
mission.mu  = 3.986e14;      % Gravitational parameter [m^3/s^2]
mission.g0  = 9.81;          % Standard gravity [m/s^2]
mission.T_E = 86164;         % Sidereal rotation period [s]

end