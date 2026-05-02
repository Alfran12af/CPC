function tank = LiquidTankSizing(m_prop, prop)
% LIQUIDTANKSIZING Computes spherical tank geometry for liquid propellants
%
% INPUTS:
%   m_prop : total propellant mass [kg]
%   prop   : propellant struct (with rho_fuel, rho_ox, OF)
%
% OUTPUT:
%   tank : struct with geometry and masses

%% 1. Mass split (O/F ratio)

m_ox   = (prop.OF / (1 + prop.OF)) * m_prop;
m_fuel = m_prop - m_ox;

%% 2. Volumes

V_ox   = m_ox   / prop.rho_ox;
V_fuel = m_fuel / prop.rho_fuel;

%% 3. Sphere geometry

% Volume of sphere: V = (4/3)*pi*r^3
r_ox   = (3*V_ox   / (4*pi))^(1/3);
r_fuel = (3*V_fuel / (4*pi))^(1/3);

D_ox   = 2*r_ox;
D_fuel = 2*r_fuel;

%% 4. Store results

tank.m_ox   = m_ox;
tank.m_fuel = m_fuel;

tank.V_ox   = V_ox;
tank.V_fuel = V_fuel;

tank.r_ox   = r_ox;
tank.r_fuel = r_fuel;

tank.D_ox   = D_ox;
tank.D_fuel = D_fuel;

% Total length if stacked (simple assumption)
tank.total_length = D_ox + D_fuel;

end