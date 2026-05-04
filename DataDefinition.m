function data = DataDefinition()
% DATADEFINITION Defines mission parameters and environmental constants
%
% OUTPUT:
%   data : struct containing mission inputs and constants

%% 1. MISSION PARAMETERS

data.H        = 600e3;     % Target orbital altitude [m]
data.m_payload = 20;       % Payload mass [kg]
data.Pc_max   = 50e6;      % Maximum chamber pressure [Pa]

%% 2. LAUNCH SITE

data.latitude = 38 + 2/60; % Launch latitude [deg] (Murcia)

%% 3. EARTH CONSTANTS

data.R_E = 6371e3;         % Earth radius [m]
data.g0  = 9.81;           % Standard gravity [m/s^2]

%% 4. ISA ATMOSPHERE (SEA LEVEL)

data.ISA.rho0 = 1.225;     % Air density [kg/m^3]
data.ISA.T0   = 288.15;    % Temperature [K]
data.ISA.P0   = 101325;    % Pressure [Pa]

data.ISA.a0   = 340.29;    % Speed of sound [m/s]
data.ISA.mu0  = 1.7894e-5; % Dynamic viscosity [Pa·s]
data.ISA.R    = 287.053;   % Gas constant [J/(kg·K)]
data.ISA.gamma = 1.4;      % Heat capacity ratio

end