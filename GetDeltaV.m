function DV_total = GetDeltaV(lat, h)
% GETDELTAV Computes total mission Delta-V requirement
%
% INPUTS:
%   lat : launch latitude [deg]
%   h   : target orbital altitude [m]
%
% OUTPUT:
%   DV_total : total required Delta-V [m/s]
%
% DESCRIPTION:
%   Computes:
%   - orbital velocity
%   - Earth rotation benefit
%   - gravity losses
%   - drag losses

%% 1. CONSTANTS

R_E = 6371e3;        % Earth radius [m]
mu  = 3.986e14;      % Earth gravitational parameter [m^3/s^2]
T_E = 86164;         % Earth rotation period [s]

%% 2. ORBITAL VELOCITY

v_orb = sqrt(mu / (R_E + h));

%% 3. EARTH ROTATION CONTRIBUTION

lat = deg2rad(lat);

v_rot = (2*pi*R_E*cos(lat)) / T_E;

%% 4. IDEAL DELTA-V

DV_ideal = v_orb - v_rot;

%% 5. LOSSES

DV_gravity_loss = 1500;   % [m/s]
DV_drag_loss    = 300;    % [m/s]

DV_losses = DV_gravity_loss + DV_drag_loss;

%% 6. TOTAL DELTA-V

DV_total = DV_ideal + DV_losses;

end