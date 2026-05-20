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
%         + DV_gravity
%
%   Drag and insertion losses are computed
%   independently and later allocated to
%   stage 1 and stage 3 respectively.
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
% Residual orbital insertion angle
% for preliminary trajectory estimation

alpha_deg = 3;

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
% Preliminary launcher estimations
% based on typical small launch vehicles.

DV_gravity = 1200;     % [m/s]

DV_drag = 300;         % [m/s]

%% =========================================================
%% INSERTION LOSSES
%% =========================================================
%
% Simplified insertion loss estimation:
%
%   DV_insertion =
%       V_orb * (1-cos(alpha))
%
% Small insertion angles are assumed
% for preliminary launcher sizing.
%

DV_insertion = ...
    v_orb * (1 - cosd(alpha_deg));

%% =========================================================
%% SAFETY COEFFICIENTS
%% =========================================================

K_orbit = 1.10;

K_drag = 1/1.50;

K_gravity = 1.50;

K_rotation = 1/1.10;

K_insertion = 1.20;

%% =========================================================
%% SAFETY-ADJUSTED LOSSES
%% =========================================================

DV_drag = ...
    DV_drag * K_drag;

DV_insertion = ...
    DV_insertion * K_insertion;

%% =========================================================
%% TOTAL DELTA-V
%% =========================================================
%
% Drag and insertion losses are NOT included
% in the global Delta-V because they are later
% allocated directly to stage 1 and stage 3.
%

DV_total = ...
      DV_ideal   * K_orbit ...
    + DV_gravity * K_gravity ...
    - abs(v_rot) * K_rotation;

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

fprintf('\n');

fprintf('------------- SAFETY COEFFICIENTS -----------\n');

fprintf('K_orbit                : %.2f\n', ...
        K_orbit);

fprintf('K_drag                 : %.2f\n', ...
        K_drag);

fprintf('K_gravity              : %.2f\n', ...
        K_gravity);

fprintf('K_rotation             : %.2f\n', ...
        K_rotation);

fprintf('K_insertion            : %.2f\n', ...
        K_insertion);

fprintf('\n');

fprintf('Total Delta-V          : %.2f m/s\n', ...
        DV_total + DV_drag + DV_insertion);

end