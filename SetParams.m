function params = SetParams()
% Defines global parameters and engineering assumptions

params.g0 = 9.81;              % [m/s^2]

% --- Structural mass fractions (epsilon) ---
params.eps1 = 0.10;            % Stage 1 (solid)
params.eps2 = 0.08;            % Stage 2 (liquid PF)
params.eps3 = 0.07;            % Stage 3 (liquid pump-fed)

% --- Realistic Isp values ---
params.Isp1 = 260;             % [s] solid (sea level)
params.Isp2 = 300;             % [s] liquid PF (mid altitude)
params.Isp3 = 340;             % [s] liquid pump-fed (vacuum)

params.Isp_margin = 0.98;      % safety margin

% --- Search ranges ---
params.frac1_range = linspace(0.3,0.5,8);   % ΔV fractions
params.frac2_range = linspace(0.2,0.4,8);

params.mr1_range = linspace(3,6,6);
params.mr2_range = linspace(3,7,6);
params.mr3_range = linspace(3,8,6);

% --- Pressure constraint ---
params.Pc_max = 50e6;          % [Pa]

end