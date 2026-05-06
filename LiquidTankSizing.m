function tank = LiquidTankSizing( ...
                    m_prop, ...
                    prop, ...
                    D)

% LIQUIDTANKSIZING Computes liquid tank geometry
%
% INPUTS:
%   m_prop : total propellant mass [kg]
%   prop   : propellant structure
%   D      : tank diameter [m]
%
% OUTPUT:
%   tank   : tank geometry structure

%% =========================================================
%% MASS SPLIT
%% =========================================================

m_ox = ...
    (prop.OF / (1 + prop.OF)) * m_prop;

m_fuel = ...
    m_prop - m_ox;

%% =========================================================
%% VOLUMES
%% =========================================================

V_ox = m_ox / prop.rho_ox;

V_fuel = m_fuel / prop.rho_fuel;

%% =========================================================
%% GEOMETRY
%% =========================================================

r = D / 2;

% Hemisphere volume
V_hemi = (2/3) * pi * r^3;

%% =========================================================
%% OXIDIZER TANK
%% =========================================================

V_cyl_ox = max(V_ox - 2*V_hemi, 0);

L_ox = V_cyl_ox / (pi*r^2);

L_total_ox = L_ox + D;

%% =========================================================
%% FUEL TANK
%% =========================================================

V_cyl_fuel = max(V_fuel - 2*V_hemi, 0);

L_fuel = V_cyl_fuel / (pi*r^2);

L_total_fuel = L_fuel + D;

%% =========================================================
%% TOTAL LENGTH
%% =========================================================

total_length = ...
    L_total_ox + ...
    L_total_fuel;

%% =========================================================
%% STORE RESULTS
%% =========================================================

tank.D = D;

tank.m_ox = m_ox;
tank.m_fuel = m_fuel;

tank.V_ox = V_ox;
tank.V_fuel = V_fuel;

tank.L_ox = L_total_ox;
tank.L_fuel = L_total_fuel;

tank.total_length = total_length;

end