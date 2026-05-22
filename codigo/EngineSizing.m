function engine = EngineSizing( ...
                    stage, ...
                    prop, ...
                    Isp, ...
                    TW_target, ...
                    params)
% ENGINESIZING Preliminary propulsion sizing
%
% INPUTS:
%   stage     : stage mass structure
%   prop      : propellant property structure
%   Isp       : stage specific impulse [s]
%   TW_target : target thrust-to-weight ratio [-]
%   params    : parameter structure
%
% OUTPUT:
%   engine    : propulsion sizing structure

%% Basic sizing

g0 = params.g0;

T = ...
    TW_target * stage.mi * g0;

mdot = ...
    T / (g0 * Isp);

tb = ...
    stage.m_prop / mdot;

%% Liquid mass flow split

mdot_ox   = NaN;
mdot_fuel = NaN;

if strcmp(prop.category, 'liquid')

    mdot_ox = ...
        (prop.OF / (1 + prop.OF)) * mdot;

    mdot_fuel = ...
        mdot - mdot_ox;

end

%% Store results

engine.T = T;
engine.TW = TW_target;
engine.Isp = Isp;

engine.mdot = mdot;
engine.tb   = tb;

engine.mdot_ox   = mdot_ox;
engine.mdot_fuel = mdot_fuel;

end