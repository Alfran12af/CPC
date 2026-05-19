function [DV_total, DV_drag, DV_insertion] = ...
    GetDeltaV(latitude, h)
% GETDELTAV Computes total launcher Delta-V requirement
%
% INPUTS:
%   latitude  : launch site latitude [deg]
%   h         : target orbit altitude [m]
%
% OUTPUT:
%   DV_total      : total required Delta-V [m/s]
%   DV_drag       : aerodynamic losses [m/s]
%   DV_insertion  : orbital insertion losses [m/s]
%
% DESCRIPTION:
%
%   Computes:
%
%   1) Circular orbital velocity
%   2) Earth rotation contribution
%   3) Gravity losses
%   4) Aerodynamic drag losses
%   5) Orbital insertion losses
%
%   Final result:
%
%       DV_total =
%           DV_orbital
%         - DV_rotation
%         + DV_losses
%

%% =========================================================
%% EARTH CONSTANTS
%% =========================================================

R_E = 6371e3;          % Earth radius [m]

mu = 3.986e14;         % Earth gravitational parameter [m^3/s^2]

T_E = 86164;           % Sidereal day [s]

%% =========================================================
%% TARGET ORBITAL VELOCITY
%% =========================================================
% Circular orbit approximation

r_orbit = R_E + h;

v_orb = sqrt(mu / r_orbit);

%% =========================================================
%% EARTH ROTATION CONTRIBUTION
%% =========================================================

latitude = deg2rad(latitude);

v_rot = ...
    (2*pi*R_E*cos(latitude)) / T_E;

%% =========================================================
%% INSERTION ANGLE
%% =========================================================

alpha_deg = 51;

%% =========================================================
%% IDEAL DELTA-V
%% =========================================================
%
% Orbital velocity corrected by
% Earth rotational contribution.
%

DV_ideal = v_orb - v_rot;

%% =========================================================
%% ESTIMATED LOSSES
%% =========================================================
% Preliminary launcher estimations.

DV_gravity = 300;     % [m/s]

DV_drag = 1200;         % [m/s]

%% =========================================================
%% INSERTION LOSSES
%% =========================================================

DV_insertion =  ... 
   v_orb * (1 - cosd(alpha_deg));

%% =========================================================
%% TOTAL DELTA-V
%% =========================================================

DV_total = ...
    DV_ideal ...
    + DV_gravity ...
    + DV_drag ...
    + DV_insertion;

%% =========================================================
%% DISPLAY RESULTS
%% =========================================================

fprintf('\n');

fprintf('------------- DELTA-V BREAKDOWN -------------\n');

fprintf('Orbital velocity       : %.2f m/s\n', ...
        v_orb);

fprintf('Earth rotation benefit : %.2f m/s\n', ...
        v_rot);

fprintf('Ideal Delta-V          : %.2f m/s\n', ...
        DV_ideal);

fprintf('Gravity losses         : %.2f m/s\n', ...
        DV_gravity);

fprintf('Aerodynamic losses     : %.2f m/s\n', ...
        DV_drag);

fprintf('Insertion losses       : %.2f m/s\n', ...
        DV_insertion);

fprintf('Total Delta-V          : %.2f m/s\n', ...
        DV_total);

end