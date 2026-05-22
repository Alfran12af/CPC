function prop = PropellantData(type)
% PROPELLANTDATA Propellant property database
%
% INPUT:
%   type : propellant identifier string
%
% OUTPUT:
%   prop : propellant property structure

switch type

%% Solid propellant

case 'HTPB_AN_Al'

    prop.name     = 'HTPB/AN/Al';
    prop.category = 'solid';

    prop.rho_eff = 1650;

    prop.OF = NaN;

    prop.Isp_SL  = 251.11;
    prop.Isp_vac = 274.37;

    prop.Tc    = 2618.8714;
    prop.gamma = 1.1856;
    prop.MW    = 23.4985;

    prop.compatible_motor = 'solid';

%% Liquid propellants - Stage 2 conditions

case 'LOX_RP1_2'

    prop.name     = 'LOX/RP-1';
    prop.category = 'liquid';

    prop.rho_fuel = 810;
    prop.rho_ox   = 1141;

    prop.OF = 2.5865720;

    prop.rho_eff = ...
        (prop.OF + 1) / ...
        (prop.OF / prop.rho_ox + 1 / prop.rho_fuel);

    prop.Isp_SL  = 280.60;
    prop.Isp_vac = 336.00;

    prop.Tc    = 3621.6605;
    prop.gamma = 1.1838;
    prop.MW    = 23.3388;

    prop.compatible_motor = {'pressure-fed'};

case 'LOX_CH4_2'

    prop.name     = 'LOX/CH4';
    prop.category = 'liquid';

    prop.rho_fuel = 422;
    prop.rho_ox   = 1141;

    prop.OF = 3.1505115;

    prop.rho_eff = ...
        (prop.OF + 1) / ...
        (prop.OF / prop.rho_ox + 1 / prop.rho_fuel);

    prop.Isp_SL  = 289.25;
    prop.Isp_vac = 346.64;

    prop.Tc    = 3470.7881;
    prop.gamma = 1.1704;
    prop.MW    = 20.8601;

    prop.compatible_motor = {'pressure-fed'};

case 'N2O4_MMH'

    prop.name     = 'N2O4/MMH';
    prop.category = 'liquid';

    prop.rho_fuel = 880;
    prop.rho_ox   = 1440;

    prop.OF = 2.0985373;

    prop.rho_eff = ...
        (prop.OF + 1) / ...
        (prop.OF / prop.rho_ox + 1 / prop.rho_fuel);

    prop.Isp_SL  = 268.81;
    prop.Isp_vac = 322.87;

    prop.Tc    = 3349.2269;
    prop.gamma = 1.1669;
    prop.MW    = 22.5470;

    prop.compatible_motor = {'pressure-fed'};

case 'N2O4_UH25'

    prop.name     = 'N2O4/UH25';
    prop.category = 'liquid';

    prop.rho_fuel = 790;
    prop.rho_ox   = 1440;

    prop.OF = 2.5358532;

    prop.rho_eff = ...
        (prop.OF + 1) / ...
        (prop.OF / prop.rho_ox + 1 / prop.rho_fuel);

    prop.Isp_SL  = 267.01;
    prop.Isp_vac = 320.50;

    prop.Tc    = 3387.1344;
    prop.gamma = 1.1677;
    prop.MW    = 23.3321;

    prop.compatible_motor = {'pressure-fed'};

%% Liquid propellants - Stage 3 conditions

case 'LOX_RP1_3'

    prop.name     = 'LOX/RP-1';
    prop.category = 'liquid';

    prop.rho_fuel = 810;
    prop.rho_ox   = 1141;

    prop.OF = 2.8499545;

    prop.rho_eff = ...
        (prop.OF + 1) / ...
        (prop.OF / prop.rho_ox + 1 / prop.rho_fuel);

    prop.Isp_SL  = 245.44;
    prop.Isp_vac = 374.39;

    prop.Tc    = 3753.7615;
    prop.gamma = 1.1886;
    prop.MW    = 24.4194;

    prop.compatible_motor = {'pump-fed'};

case 'LOX_CH4_3'

    prop.name     = 'LOX/CH4';
    prop.category = 'liquid';

    prop.rho_fuel = 422;
    prop.rho_ox   = 1141;

    prop.OF = 3.4742122;

    prop.rho_eff = ...
        (prop.OF + 1) / ...
        (prop.OF / prop.rho_ox + 1 / prop.rho_fuel);

    prop.Isp_SL  = 253.79;
    prop.Isp_vac = 385.00;

    prop.Tc    = 3605.2600;
    prop.gamma = 1.1750;
    prop.MW    = 21.9711;

    prop.compatible_motor = {'pump-fed'};

case 'LOX_LH2'

    prop.name     = 'LOX/LH2';
    prop.category = 'liquid';

    prop.rho_fuel = 71;
    prop.rho_ox   = 1141;

    prop.OF = 5.5000;

    prop.rho_eff = ...
        (prop.OF + 1) / ...
        (prop.OF / prop.rho_ox + 1 / prop.rho_fuel);

    prop.Isp_SL  = 243.26;
    prop.Isp_vac = 362.84;

    prop.Tc    = 3523.6766;
    prop.gamma = 1.1583;
    prop.MW    = 21.1639;

    prop.compatible_motor = {'pump-fed'};

%% Unknown propellant

otherwise

    error('Unknown propellant type: %s', type);

end

end