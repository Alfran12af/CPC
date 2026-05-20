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
%   All thermochemical properties are extracted
%   from Rocket Propulsion Analysis (RPA).
%
% ==========================================================

switch type

%% =========================================================
%% SOLID PROPELLANTS
%% =========================================================

case 'HTPB_AN_AL'

    %% -----------------------------------------------------
    %% IDENTIFICATION
    %% -----------------------------------------------------

    prop.name = 'HTPB/AN/Al';

    prop.category = 'solid';

    %% -----------------------------------------------------
    %% DENSITY
    %% -----------------------------------------------------

    prop.rho_eff = 1650;     % [kg/m^3]

    %% -----------------------------------------------------
    %% MIXTURE RATIO
    %% -----------------------------------------------------

    prop.OF = NaN;

    %% -----------------------------------------------------
    %% PERFORMANCE
    %% -----------------------------------------------------

    prop.Isp_SL = 251.11;      % [s]

    prop.Isp_vac = 274.37;     % [s]

    %% -----------------------------------------------------
    %% COMBUSTION DATA
    %% -----------------------------------------------------

    prop.Tc = 2618.8714;       % [K]

    prop.gamma = 1.1856;

    prop.MW = 23.4985;         % [kg/kmol]

    %% -----------------------------------------------------
    %% MOTOR COMPATIBILITY
    %% -----------------------------------------------------

    prop.compatible_motor = ...
        'solid';

%% =========================================================
%% LIQUID PROPELLANTS
%% =========================================================

case 'LOX_RP1_2'

    %% -----------------------------------------------------
    %% IDENTIFICATION
    %% -----------------------------------------------------

    prop.name = 'LOX/RP-1';

    prop.category = 'liquid';

    %% -----------------------------------------------------
    %% DENSITIES
    %% -----------------------------------------------------

    prop.rho_fuel = 810;     % [kg/m^3]

    prop.rho_ox = 1141;      % [kg/m^3]

    prop.rho_eff = ...
        (2.5865720 + 1) / ...
        (2.5865720 / 1141 + 1 / 810);

    %% -----------------------------------------------------
    %% MIXTURE RATIO
    %% -----------------------------------------------------

    prop.OF = 2.5865720;

    %% -----------------------------------------------------
    %% PERFORMANCE
    %% -----------------------------------------------------

    prop.Isp_SL = 280.60;

    prop.Isp_vac = 336.00;

    %% -----------------------------------------------------
    %% COMBUSTION DATA
    %% -----------------------------------------------------

    prop.Tc = 3621.6605;

    prop.gamma = 1.1838;

    prop.MW = 23.3388;

    %% -----------------------------------------------------
    %% MOTOR COMPATIBILITY
    %% -----------------------------------------------------

    prop.compatible_motor = ...
    {
        'pressure-fed'
    };

%% =========================================================

case 'LOX_RP1_3'

    prop.name = 'LOX/RP-1';

    prop.category = 'liquid';

    prop.rho_fuel = 810;

    prop.rho_ox = 1141;

    prop.rho_eff = ...
        (2.8499545 + 1) / ...
        (2.8499545 / 1141 + 1 / 810);

    prop.OF = 2.8499545;

    prop.Isp_SL = 245.44;
 
    prop.Isp_vac = 333.39; % originalemnt 374.39

    prop.Tc = 3753.7615;

    prop.gamma = 1.1886;

    prop.MW = 24.4194;

    prop.compatible_motor = ...
    {
        'pump-fed'
    };

%% =========================================================

case 'LOX_CH4_2'

    prop.name = 'LOX/CH4';

    prop.category = 'liquid';

    prop.rho_fuel = 422;

    prop.rho_ox = 1141;

    prop.rho_eff = ...
        (3.1505115 + 1) / ...
        (3.1505115 / 1141 + 1 / 422);

    prop.OF = 3.1505115;

    prop.Isp_SL = 289.25;

    prop.Isp_vac = 346.64;

    prop.Tc = 3470.7881;

    prop.gamma = 1.1704;

    prop.MW = 20.8601;

    prop.compatible_motor = ...
    {
        'pressure-fed'
    };

%% =========================================================

case 'LOX_CH4_3'

    prop.name = 'LOX/CH4';

    prop.category = 'liquid';

    prop.rho_fuel = 422;

    prop.rho_ox = 1141;

    prop.rho_eff = ...
        (3.4742122 + 1) / ...
        (3.4742122 / 1141 + 1 / 422);

    prop.OF = 3.4742122;

    prop.Isp_SL = 253.79;

    prop.Isp_vac = 345.00; % Originalment: 385.00

    prop.Tc = 3605.2600;

    prop.gamma = 1.1750;

    prop.MW = 21.9711;

    prop.compatible_motor = ...
    {
        'pump-fed'
    };

%% =========================================================

case 'LOX_LH2'

    prop.name = 'LOX/LH2';

    prop.category = 'liquid';

    prop.rho_fuel = 71;

    prop.rho_ox = 1141;

    prop.rho_eff = ...
        (5.5000 + 1) / ...
        (5.5000 / 1141 + 1 / 71);

    prop.OF = 5.5000;

    prop.Isp_SL = 243.26;

    prop.Isp_vac = 362.84;

    prop.Tc = 3523.6766;

    prop.gamma = 1.1583;

    prop.MW = 21.1639;

    prop.compatible_motor = ...
    {
        'pump-fed'
    };

%% =========================================================

case 'N2O4_MMH'

    prop.name = 'N2O4/MMH';

    prop.category = 'liquid';

    prop.rho_fuel = 880;

    prop.rho_ox = 1440;

    prop.rho_eff = ...
        (2.0985373 + 1) / ...
        (2.0985373 / 1440 + 1 / 880);

    prop.OF = 2.0985373;

    prop.Isp_SL = 268.81;

    prop.Isp_vac = 322.87;

    prop.Tc = 3349.2269;

    prop.gamma = 1.1669;

    prop.MW = 22.5470;

    prop.compatible_motor = ...
    {
        'pressure-fed'
    };

%% =========================================================

case 'N2O4_UH25'

    prop.name = 'N2O4/UH25';

    prop.category = 'liquid';

    prop.rho_fuel = 790;

    prop.rho_ox = 1440;

    prop.rho_eff = ...
        (2.5358532 + 1) / ...
        (2.5358532 / 1440 + 1 / 790);

    prop.OF = 2.5358532;

    prop.Isp_SL = 267.01;

    prop.Isp_vac = 320.50;

    prop.Tc = 3387.1344;

    prop.gamma = 1.1677;

    prop.MW = 23.3321;

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