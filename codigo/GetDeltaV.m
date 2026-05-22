function [DV_ascent, DV_insertion] = GetDeltaV(latitude, h)
% GETDELTAV Computes launcher Delta-V requirements
%
% INPUTS:
%   latitude : launch site latitude [deg]
%   h        : target orbit altitude [m]
%
% OUTPUTS:
%   DV_ascent    : ascent Delta-V [m/s]
%   DV_insertion : orbital insertion Delta-V [m/s]

%% Earth constants

R_E = 6371e3;      % Earth radius [m]
mu  = 3.986e14;    % Gravitational parameter [m^3/s^2]
T_E = 86164;       % Sidereal day [s]

%% Orbital velocity

r_orbit = R_E + h;

v_orb = sqrt(mu / r_orbit);

%% Earth rotation contribution

latitude = deg2rad(latitude);

v_rot = ...
    (2*pi*R_E*cos(latitude)) / T_E;

%% Ideal ascent Delta-V

DV_ideal = v_orb - v_rot;

%% Estimated losses

DV_gravity = 1200;
DV_drag    = 300;

%% Orbital insertion maneuver

insertion_angle = 15;

DV_insertion_raw = ...
    2 * v_orb * sind(insertion_angle/2);

%% Safety coefficients

K_orbit     = 1.05;
K_gravity   = 1.20;
K_drag      = 1/1.50;
K_insertion = 1.10;

%% Corrected contributions

DV_orbit = ...
    DV_ideal * K_orbit;

DV_gravity = ...
    DV_gravity * K_gravity;

DV_drag = ...
    DV_drag * K_drag;

DV_insertion = ...
    DV_insertion_raw * K_insertion;

%% Final ascent Delta-V

DV_ascent = ...
      DV_orbit ...
    + DV_gravity ...
    + DV_drag;

DV_total = ...
    DV_ascent ...
    + DV_insertion;

%% Delta-V report

fprintf('\n');
fprintf('==========================================================================\n');
fprintf('                           DELTA-V BUDGET                                 \n');
fprintf('==========================================================================\n');

fprintf('\nORBITAL CONTRIBUTIONS\n');
fprintf('--------------------------------------------------------------------------\n');

fprintf('   Orbital velocity ................. %.2f m/s\n', ...
    v_orb);

fprintf('   Earth rotation benefit ........... %.2f m/s\n', ...
    v_rot);

fprintf('   Ideal ascent Delta-V ............. %.2f m/s\n', ...
    DV_ideal);

fprintf('\nASCENT LOSSES\n');
fprintf('--------------------------------------------------------------------------\n');

fprintf('   Gravity losses ................... %.2f m/s\n', ...
    DV_gravity);

fprintf('   Aerodynamic losses ............... %.2f m/s\n', ...
    DV_drag);

fprintf('\nINSERTION MANEUVER\n');
fprintf('--------------------------------------------------------------------------\n');

fprintf('   Orbital insertion Delta-V ........ %.2f m/s\n', ...
    DV_insertion);

fprintf('\nFINAL DELTA-V REQUIREMENTS\n');
fprintf('--------------------------------------------------------------------------\n');

fprintf('   Ascent Delta-V ................... %.2f m/s\n', ...
    DV_ascent);

fprintf('   Insertion Delta-V ................ %.2f m/s\n', ...
    DV_insertion);

fprintf('   Total mission Delta-V ............ %.2f m/s\n', ...
    DV_total);

fprintf('\n');
fprintf('==========================================================================\n');

end