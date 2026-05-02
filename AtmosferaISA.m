function [p, T, rho, a, g] = AtmosferaISA(h)
% ATMOSFERAISA Computes ISA atmospheric properties
%
% INPUT:
%   h   : altitude [m]
%
% OUTPUTS:
%   p   : pressure [Pa]
%   T   : temperature [K]
%   rho : density [kg/m^3]
%   a   : speed of sound [m/s]
%   g   : gravity [m/s^2]

% --- Constants ---
g0 = 9.807;          % [m/s^2]
R  = 287;            % [J/(kg*K)]
gamma = 1.4;
R_E = 6371e3;        % [m]

% Gravity variation with altitude
g = g0 / (1 + h/R_E)^2;

% --- ISA layers ---
if h < 11000
    % Troposphere
    lapse = -0.00649;
    T = 288.15 + lapse*h;
    p = 101325 * (T/288.15)^(-g/(lapse*R));
    
elseif h < 20000
    % Tropopause
    T = 216.65;
    p = 22632 * exp(-g*(h-11000)/(R*T));
    
elseif h < 32000
    % Stratosphere 1
    lapse = 0.001;
    T = 216.65 + lapse*(h-20000);
    p = 5474.9 * (T/216.65)^(g/(lapse*R));
    
elseif h < 47000
    % Stratosphere 2
    lapse = 0.0028;
    T = 228.65 + lapse*(h-32000);
    p = 868.02 * (T/228.65)^(-g/(lapse*R));
    
elseif h < 51000
    % Stratopause
    T = 270.65;
    p = 110.91 * exp(-g*(h-47000)/(R*T));
    
elseif h < 71000
    % Mesosphere 1
    lapse = -0.0028;
    T = 270.65 + lapse*(h-51000);
    p = 66.94 * (T/270.65)^(-g/(lapse*R));
    
elseif h < 84852
    % Mesosphere 2
    lapse = -0.002;
    T = 214.65 + lapse*(h-71000);
    p = 3.956 * (T/214.65)^(-g/(lapse*R));
    
else
    % Above model range
    T = 186.87;
    p = 0.373 * exp(-g*(h-84852)/(R*T));
end

% Density
rho = p / (R*T);

% Speed of sound
a = sqrt(gamma * R * T);

end