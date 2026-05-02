function solid = SolidMotorSizing(m_prop, rho_prop, D)
% SOLIDMOTORSIZING Computes cylindrical solid motor geometry
%
% INPUTS:
%   m_prop   : propellant mass [kg]
%   rho_prop : propellant density [kg/m^3]
%   D        : motor diameter [m]
%
% OUTPUT:
%   solid : struct with geometry

%% 1. Volume

V = m_prop / rho_prop;

%% 2. Cylinder geometry

A = pi * (D/2)^2;   % cross-sectional area

L = V / A;          % length

%% 3. Store results

solid.volume   = V;
solid.diameter = D;
solid.length   = L;

end