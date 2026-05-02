function DV = GetDeltaV(lat, h)
% GETDELTAV Computes ideal orbital Delta-V requirement
%
% INPUTS:
%   lat : launch latitude [deg]
%   h   : target orbital altitude [m]
%
% OUTPUT:
%   DV  : ideal Delta-V [m/s] (no losses)
%
% DESCRIPTION:
%   Computes the velocity required to reach a circular orbit,
%   accounting for Earth's rotation benefit.

% --- Constants ---
R_E = 6371e3;            % Earth radius [m]
mu  = 3.986e14;          % Earth gravitational parameter [m^3/s^2]
T_E = 86164;             % Earth rotation period [s]

% --- Convert latitude to radians ---
lat = deg2rad(lat);

% --- Orbital velocity ---
v_orb = sqrt(mu / (R_E + h));

% --- Earth's rotational velocity contribution ---
v_rot = (2*pi*R_E*cos(lat)) / T_E;

% --- Ideal Delta-V ---
DV = v_orb - v_rot;

end