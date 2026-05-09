function DV_total = GetDeltaV(latitude, h)
% GETDELTAV Computes total launcher Delta-V requirement
%
% INPUTS:
%   latitude : launch site latitude [deg]
%   h        : target orbit altitude [m]
%
% OUTPUT:
%   DV_total : total required Delta-V [m/s]
%
% DESCRIPTION:
%
%   Computes:
%
%   1) Circular orbital velocity
%   2) Earth rotation contribution
%   3) Gravity losses
%   4) Aerodynamic drag losses
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
%
% Circular orbit approximation
%
% v_orb = sqrt(mu/r)
%

r_orbit = R_E + h;

v_orb = sqrt(mu / r_orbit);

%% =========================================================
%% EARTH ROTATION CONTRIBUTION
%% =========================================================
%
% Launch sites closer to the equator
% benefit from higher rotational velocity.
%

latitude = deg2rad(latitude);

v_rot = ...
    (2*pi*R_E*cos(latitude)) / T_E;

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
%
% Preliminary launcher estimations.
%
% Typical small launcher values:
%
%   Gravity losses -> 1.3-1.8 km/s
%   Drag losses    -> 0.2-0.4 km/s
%

DV_gravity = 1500;     % [m/s]

DV_drag = 300;         % [m/s]

DV_losses = ...
    DV_gravity + DV_drag;

%% =========================================================
%% TOTAL DELTA-V
%% =========================================================

DV_total = DV_ideal + DV_losses;

%% =========================================================
%% DISPLAY RESULTS
%% =========================================================

fprintf('\\n');
fprintf('------------- DELTA-V BREAKDOWN -------------\\n');

fprintf('Orbital velocity       : %.2f m/s\\n', ...
        v_orb);

fprintf('Earth rotation benefit : %.2f m/s\\n', ...
        v_rot);

fprintf('Ideal Delta-V          : %.2f m/s\\n', ...
        DV_ideal);

fprintf('Gravity losses         : %.2f m/s\\n', ...
        DV_gravity);

fprintf('Aerodynamic losses     : %.2f m/s\\n', ...
        DV_drag);

fprintf('Total Delta-V          : %.2f m/s\\n', ...
        DV_total);

end