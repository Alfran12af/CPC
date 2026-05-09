function geom = StageGeometry( ...
                    stage, ...
                    prop, ...
                    stage_arch, ...
                    params)
% STAGEGEOMETRY Computes preliminary stage geometry
%
% INPUTS:
%   stage       : stage mass structure
%   prop        : propellant structure
%   stage_arch  : stage architecture structure
%   params      : optimization parameters
%
% OUTPUT:
%   geom        : stage geometry structure
%
% DESCRIPTION:
%
%   Computes:
%
%   - propellant volume
%   - equivalent stage volume
%   - stage diameter
%   - body length
%   - engine section
%   - nozzle section
%   - interstage section
%   - total stage length
%
% ==========================================================

%% =========================================================
%% INITIALIZATION
%% =========================================================

m_prop = stage.m_prop;

%% =========================================================
%% SOLID STAGE
%% =========================================================
%
% Solid motor:
%
%   chamber + propellant tank = same element
%

if strcmp(stage_arch.motor,'solid')

    %% -----------------------------------------------------
    %% EFFECTIVE DENSITY
    %% -----------------------------------------------------

    rho = prop.rho_eff;

    %% -----------------------------------------------------
    %% PROPELLANT VOLUME
    %% -----------------------------------------------------

    V_prop = m_prop / rho;

    %% -----------------------------------------------------
    %% VOLUMETRIC EFFICIENCY
    %% -----------------------------------------------------
    %
    % Accounts for:
    %
    %   - insulation
    %   - internal port
    %   - casing
    %

    eta_v = ...
        params.solid_volumetric_efficiency;

    %% -----------------------------------------------------
    %% TOTAL EQUIVALENT VOLUME
    %% -----------------------------------------------------

    V_total = ...
        V_prop / eta_v;

%% =========================================================
%% LIQUID STAGES
%% =========================================================

else

    %% -----------------------------------------------------
    %% MASS SPLIT
    %% -----------------------------------------------------

    m_ox = ...
        (prop.OF / (1 + prop.OF)) * m_prop;

    m_fuel = ...
        m_prop - m_ox;

    %% -----------------------------------------------------
    %% TANK VOLUMES
    %% -----------------------------------------------------

    V_ox = ...
        m_ox / prop.rho_ox;

    V_fuel = ...
        m_fuel / prop.rho_fuel;

    %% -----------------------------------------------------
    %% ULLAGE FACTOR
    %% -----------------------------------------------------
    %
    % Accounts for:
    %
    %   - ullage
    %   - tank structures
    %   - feed systems
    %   - pressurization systems
    %

    ullage = ...
        params.liquid_ullage_factor;

    %% -----------------------------------------------------
    %% TOTAL VOLUME
    %% -----------------------------------------------------

    V_total = ...
        ullage * (V_ox + V_fuel);

end

%% =========================================================
%% TARGET ASPECT RATIO
%% =========================================================
%
% Equivalent cylindrical stage
%

if strcmp(stage_arch.name,'Stage 1')

    AR = params.AR_stage1;

elseif strcmp(stage_arch.name,'Stage 2')

    AR = params.AR_stage2;

elseif strcmp(stage_arch.name,'Stage 3')

    AR = params.AR_stage3;
    
end

%% =========================================================
%% EQUIVALENT CYLINDRICAL GEOMETRY
%% =========================================================
%
% Cylinder approximation:
%
%   V = pi/4 * D^2 * L
%
% with:
%
%   L = AR * D
%

D = ...
    ((4 * V_total) / (pi * AR))^(1/3);

L_body = ...
    AR * D;

%% =========================================================
%% ENGINE SECTION
%% =========================================================

if strcmp(stage_arch.motor,'solid')

    engine_factor = ...
        params.solid_engine_factor;

else

    engine_factor = ...
        params.liquid_engine_factor;

end

L_engine = ...
    engine_factor * D;

%% =========================================================
%% NOZZLE SECTION
%% =========================================================

L_nozzle = ...
    params.nozzle_factor * D;

%% =========================================================
%% INTERSTAGE SECTION
%% =========================================================

L_interstage = ...
    params.interstage_factor * D;

%% =========================================================
%% TOTAL STAGE LENGTH
%% =========================================================

L_total = ...
    L_body + ...
    L_engine + ...
    L_nozzle + ...
    L_interstage;

%% =========================================================
%% STAGE SLENDERNESS
%% =========================================================

stage_slenderness = ...
    L_total / D;

%% =========================================================
%% STORE RESULTS
%% =========================================================

%% ---------------------------------------------------------
%% MAIN GEOMETRY
%% ---------------------------------------------------------

geom.D = D;

geom.total_length = L_total;

geom.body_length = L_body;

%% ---------------------------------------------------------
%% SECTIONS
%% ---------------------------------------------------------

geom.engine_length = ...
    L_engine;

geom.nozzle_length = ...
    L_nozzle;

geom.interstage_length = ...
    L_interstage;

%% ---------------------------------------------------------
%% VOLUMES
%% ---------------------------------------------------------

geom.volume_total = ...
    V_total;

%% ---------------------------------------------------------
%% GEOMETRIC RATIOS
%% ---------------------------------------------------------

geom.aspect_ratio = AR;

geom.stage_slenderness = ...
    stage_slenderness;

%% =========================================================
%% OPTIONAL LIQUID DATA
%% =========================================================

if strcmp(prop.category,'liquid')

    geom.V_ox = V_ox;

    geom.V_fuel = V_fuel;

    geom.m_ox = m_ox;

    geom.m_fuel = m_fuel;

end

end