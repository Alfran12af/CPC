function prop = PropellantData(type)
% PROPELLANTDATA Propellant database
%
% INPUT:
%   type : propellant identifier
%
% OUTPUT:
%   prop : propellant properties structure
%
% DESCRIPTION:
%
%   Contains:
%
%   - propellant densities
%   - O/F ratio
%   - Isp values
%   - combustion properties
%   - compatible propulsion systems
%
%   All thermochemical properties are intended
%   to be extracted manually from RPA.
%
% ==========================================================

switch type

%% =========================================================
%% SOLID PROPELLANTS
%% =========================================================

case 'HTPB'

    %% -----------------------------------------------------
    %% IDENTIFICATION
    %% -----------------------------------------------------

    prop.name = 'HTPB/AP';

    prop.category = 'solid';

    %% -----------------------------------------------------
    %% DENSITY
    %% -----------------------------------------------------

    prop.rho_eff = 1700;     % [kg/m^3]

    %% -----------------------------------------------------
    %% MIXTURE RATIO
    %% -----------------------------------------------------

    prop.OF = NaN;

    %% -----------------------------------------------------
    %% PERFORMANCE
    %% -----------------------------------------------------

    prop.Isp_SL = 260;       % [s]

    prop.Isp_vac = 280;      % [s]

    %% -----------------------------------------------------
    %% COMBUSTION DATA
    %% -----------------------------------------------------

    prop.Tc = 3200;          % [K]

    prop.gamma = 1.22;

    prop.MW = 24;            % [kg/kmol]

    %% -----------------------------------------------------
    %% MOTOR COMPATIBILITY
    %% -----------------------------------------------------

    prop.compatible_motor = ...
        'solid';

%% =========================================================

case 'HTPB_AL'

    prop.name = 'HTPB/AP/Al';

    prop.category = 'solid';

    prop.rho_eff = 1800;

    prop.OF = NaN;

    prop.Isp_SL = 255;

    prop.Isp_vac = 275;

    prop.Tc = 3400;

    prop.gamma = 1.20;

    prop.MW = 26;

    prop.compatible_motor = ...
        'solid';

%% =========================================================
%% LIQUID PROPELLANTS
%% =========================================================

case 'LOX_RP1'

    %% -----------------------------------------------------
    %% IDENTIFICATION
    %% -----------------------------------------------------

    prop.name = 'LOX/RP-1';

    prop.category = 'liquid';

    %% -----------------------------------------------------
    %% DENSITIES
    %% -----------------------------------------------------

    prop.rho_fuel = 810;     % [kg/m^3]

    prop.rho_ox = 1140;      % [kg/m^3]

    prop.rho_eff = 1030;

    %% -----------------------------------------------------
    %% MIXTURE RATIO
    %% -----------------------------------------------------

    prop.OF = 2.6;

    %% -----------------------------------------------------
    %% PERFORMANCE
    %% -----------------------------------------------------

    prop.Isp_SL = 300;

    prop.Isp_vac = 330;

    %% -----------------------------------------------------
    %% COMBUSTION DATA
    %% -----------------------------------------------------

    prop.Tc = 3670;

    prop.gamma = 1.22;

    prop.MW = 22;

    %% -----------------------------------------------------
    %% MOTOR COMPATIBILITY
    %% -----------------------------------------------------

    prop.compatible_motor = ...
    {
        'pressure-fed',
        'pump-fed'
    };

%% =========================================================

case 'LOX_CH4'

    prop.name = 'LOX/CH4';

    prop.category = 'liquid';

    prop.rho_fuel = 422;

    prop.rho_ox = 1140;

    prop.rho_eff = 760;

    prop.OF = 3.5;

    prop.Isp_SL = 320;

    prop.Isp_vac = 360;

    prop.Tc = 3550;

    prop.gamma = 1.24;

    prop.MW = 20;

    prop.compatible_motor = ...
    {
        'pressure-fed',
        'pump-fed'
    };

%% =========================================================

case 'LOX_LH2'

    prop.name = 'LOX/LH2';

    prop.category = 'liquid';

    prop.rho_fuel = 70;

    prop.rho_ox = 1140;

    prop.rho_eff = 360;

    prop.OF = 5.5;

    prop.Isp_SL = 360;

    prop.Isp_vac = 450;

    prop.Tc = 3500;

    prop.gamma = 1.20;

    prop.MW = 16;

    prop.compatible_motor = ...
    {
        'pump-fed'
    };

%% =========================================================

case 'LOX_ETHANOL'

    prop.name = 'LOX/Ethanol';

    prop.category = 'liquid';

    prop.rho_fuel = 789;

    prop.rho_ox = 1140;

    prop.rho_eff = 950;

    prop.OF = 1.7;

    prop.Isp_SL = 285;

    prop.Isp_vac = 310;

    prop.Tc = 3300;

    prop.gamma = 1.23;

    prop.MW = 24;

    prop.compatible_motor = ...
    {
        'pressure-fed'
    };

%% =========================================================
%% ERROR
%% =========================================================

otherwise

    error('Unknown propellant');

end

end