function engine = EngineSizing( ...
                    stage, ...
                    prop, ...
                    Isp, ...
                    TW_target, ...
                    params)
% ENGINESIZING Preliminary propulsion sizing
%
% INPUTS:
%   stage       : stage structure
%   prop        : propellant structure
%   Isp         : specific impulse [s]
%   TW_target   : target thrust-to-weight ratio
%   params      : optimization parameters
%
% OUTPUT:
%   engine      : propulsion structure
%
% DESCRIPTION:
%
%   Computes:
%
%   - thrust
%   - mass flow
%   - burn time
%   - oxidizer flow
%   - fuel flow
%
% ==========================================================

%% =========================================================
%% CONSTANTS
%% =========================================================

g0 = params.g0;

%% =========================================================
%% STAGE INITIAL MASS
%% =========================================================

m0 = stage.mi;

%% =========================================================
%% TARGET THRUST
%% =========================================================

T = ...
    TW_target * m0 * g0;

%% =========================================================
%% TOTAL MASS FLOW
%% =========================================================

mdot = ...
    T / (g0 * Isp);

%% =========================================================
%% BURN TIME
%% =========================================================

tb = ...
    stage.m_prop / mdot;

%% =========================================================
%% INITIALIZATION
%% =========================================================

mdot_ox = NaN;

mdot_fuel = NaN;

%% =========================================================
%% LIQUID STAGES
%% =========================================================

if strcmp(prop.category,'liquid')

    %% -----------------------------------------------------
    %% OXIDIZER FLOW
    %% -----------------------------------------------------

    mdot_ox = ...
        (prop.OF / (1 + prop.OF)) * mdot;

    %% -----------------------------------------------------
    %% FUEL FLOW
    %% -----------------------------------------------------

    mdot_fuel = ...
        mdot - mdot_ox;

end

%% =========================================================
%% STORE RESULTS
%% =========================================================

engine.T = T;

engine.TW = TW_target;

engine.Isp = Isp;

engine.mdot = mdot;

engine.tb = tb;

engine.mdot_ox = mdot_ox;

engine.mdot_fuel = mdot_fuel;

end