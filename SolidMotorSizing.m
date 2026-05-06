function solid = SolidMotorSizing(m_prop, rho_prop, D)
% SOLIDMOTORSIZING Computes solid rocket motor geometry
%
% INPUTS:
%   m_prop   : propellant mass [kg]
%   rho_prop : propellant density [kg/m^3]
%   D        : motor diameter [m]
%
% OUTPUT:
%   solid : solid motor geometry

%% =========================================================
%% VOLUMETRIC LOADING FACTOR
%% =========================================================
%
% Accounts for:
%   - internal port
%   - insulation
%   - casing
%

eta_v = 0.85;

%% =========================================================
%% PROPELLANT VOLUME
%% =========================================================

V_prop = m_prop / rho_prop;

%% =========================================================
%% TOTAL MOTOR VOLUME
%% =========================================================

V_total = V_prop / eta_v;

%% =========================================================
%% CYLINDRICAL GEOMETRY
%% =========================================================

A = pi * (D/2)^2;

L = V_total / A;

%% =========================================================
%% STORE RESULTS
%% =========================================================

solid.volume_propellant = V_prop;

solid.volume_total = V_total;

solid.diameter = D;

solid.length = L;

solid.loading_factor = eta_v;

end