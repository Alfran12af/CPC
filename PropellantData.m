function prop = PropellantData(type)
% PROPELLANTDATA Propellant technology database
%
% INPUT:
%   type : propellant identifier
%
% OUTPUT:
%   prop : propellant properties structure

switch type

%% =========================================================
%% SOLID PROPELLANTS
%% =========================================================

case 'HTPB'

    prop.name = 'HTPB/AP';
    
    prop.category = 'solid';
    
    % Density
    prop.rho_eff = 1700;      % [kg/m^3]
    
    % Mixture ratio
    prop.OF = NaN;
    
    % Performance
    prop.Isp_SL  = 260;       % [s]
    prop.Isp_vac = 280;       % [s]
    
    % Compatibility
    prop.compatible_motor = 'solid';
    
    % Notes
    prop.description = ...
        'Standard composite solid propellant';


case 'HTPB_AL'

    prop.name = 'HTPB/AP/Al';
    
    prop.category = 'solid';
    
    prop.rho_eff = 1800;
    
    prop.OF = NaN;
    
    prop.Isp_SL  = 255;
    prop.Isp_vac = 275;
    
    prop.compatible_motor = 'solid';
    
    prop.description = ...
        'Aluminized solid propellant';


%% =========================================================
%% LIQUID PROPELLANTS
%% =========================================================

case 'LOX_RP1'

    prop.name = 'LOX/RP-1';
    
    prop.category = 'liquid';
    
    % Densities
    prop.rho_fuel = 810;
    prop.rho_ox   = 1140;
    
    % Effective density
    prop.rho_eff = 1030;
    
    % Mixture ratio
    prop.OF = 2.6;
    
    % Performance
    prop.Isp_SL  = 300;
    prop.Isp_vac = 330;
    
    % Compatible systems
    prop.compatible_motor = ...
    {
        'pump-fed',
        'pressure-fed'
    };
    
    prop.description = ...
        'Dense hydrocarbon propellant';


case 'LOX_CH4'

    prop.name = 'LOX/CH4';
    
    prop.category = 'liquid';
    
    prop.rho_fuel = 422;
    prop.rho_ox   = 1140;
    
    prop.rho_eff = 760;
    
    prop.OF = 3.5;
    
    prop.Isp_SL  = 320;
    prop.Isp_vac = 360;
    
    prop.compatible_motor = ...
    {
        'pump-fed',
        'pressure-fed'
    };
    
    prop.description = ...
        'Methalox high-performance propellant';


case 'LOX_LH2'

    prop.name = 'LOX/LH2';
    
    prop.category = 'liquid';
    
    prop.rho_fuel = 70;
    prop.rho_ox   = 1140;
    
    prop.rho_eff = 360;
    
    prop.OF = 5.5;
    
    prop.Isp_SL  = 360;
    prop.Isp_vac = 450;
    
    prop.compatible_motor = ...
    {
        'pump-fed'
    };
    
    prop.description = ...
        'Cryogenic high-Isp propellant';


case 'LOX_ETHANOL'

    prop.name = 'LOX/Ethanol';
    
    prop.category = 'liquid';
    
    prop.rho_fuel = 789;
    prop.rho_ox   = 1140;
    
    prop.rho_eff = 950;
    
    prop.OF = 1.7;
    
    prop.Isp_SL  = 285;
    prop.Isp_vac = 310;
    
    prop.compatible_motor = ...
    {
        'pressure-fed'
    };
    
    prop.description = ...
        'Simple pressure-fed compatible propellant';


%% =========================================================
%% ERROR
%% =========================================================

otherwise

    error('Unknown propellant');

end

end