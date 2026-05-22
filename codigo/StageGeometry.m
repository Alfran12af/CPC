function geom = StageGeometry( ...
                    stage, ...
                    prop, ...
                    stage_arch, ...
                    params)
% STAGEGEOMETRY Preliminary stage geometric sizing
%
% INPUTS:
%   stage       : stage mass structure
%   prop        : propellant property structure
%   stage_arch  : stage architecture structure
%   params      : sizing parameter structure
%
% OUTPUT:
%   geom        : stage geometry structure

%% Propellant volume

m_prop = stage.m_prop;

if strcmp(stage_arch.motor, 'solid')

    rho = prop.rho_eff;

    V_prop = ...
        m_prop / rho;

    V_total = ...
        V_prop / ...
        params.solid_volumetric_efficiency;

else

    m_ox = ...
        (prop.OF / (1 + prop.OF)) * m_prop;

    m_fuel = ...
        m_prop - m_ox;

    V_ox = ...
        m_ox / prop.rho_ox;

    V_fuel = ...
        m_fuel / prop.rho_fuel;

    V_total = ...
        (V_ox + V_fuel) / ...
        params.liquid_volumetric_efficiency;

end

%% Stage aspect ratio

if strcmp(stage_arch.name, 'Stage 1')

    AR = params.AR_stage1;

elseif strcmp(stage_arch.name, 'Stage 2')

    AR = params.AR_stage2;

else

    AR = params.AR_stage3;

end

%% Equivalent cylindrical geometry

D = ...
    ((4 * V_total) / (pi * AR))^(1/3);

L_body = ...
    AR * D;

%% Auxiliary sections

if strcmp(stage_arch.motor, 'solid')

    engine_factor = ...
        params.solid_engine_factor;

else

    engine_factor = ...
        params.liquid_engine_factor;

end

L_engine = ...
    engine_factor * D;

L_nozzle = ...
    params.nozzle_factor * D;

L_interstage = ...
    params.interstage_factor * D;

%% Total stage length

L_total = ...
    L_body + ...
    L_engine + ...
    L_nozzle + ...
    L_interstage;

%% Store results

geom.D = D;

geom.total_length = L_total;
geom.body_length  = L_body;

geom.engine_length     = L_engine;
geom.nozzle_length     = L_nozzle;
geom.interstage_length = L_interstage;

geom.volume_total = V_total;

geom.aspect_ratio      = AR;
geom.stage_slenderness = ...
    L_total / D;

%% Additional liquid data

if strcmp(prop.category, 'liquid')

    geom.V_ox   = V_ox;
    geom.V_fuel = V_fuel;

    geom.m_ox   = m_ox;
    geom.m_fuel = m_fuel;

end

end