function prop = PropellantData(type)
% PROPELLANTDATA Returns properties of selected propellant

switch type
    
    case 'solid'
        prop.name = 'HTPB solid';
        prop.rho  = 1700;
        prop.OF   = NaN;
        prop.type = 'solid';
        
    case 'LOX_RP1'
        prop.name = 'LOX/RP-1';
        prop.rho_fuel = 810;
        prop.rho_ox   = 1140;
        prop.OF = 2.6;
        prop.type = 'liquid';
        
    case 'LOX_LH2'
        prop.name = 'LOX/LH2';
        prop.rho_fuel = 70;
        prop.rho_ox   = 1140;
        prop.OF = 5.5;
        prop.type = 'liquid';
        
    otherwise
        error('Unknown propellant')
end

end