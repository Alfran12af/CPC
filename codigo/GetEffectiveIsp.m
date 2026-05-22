function Isp = GetEffectiveIsp( ...
                    Isp_SL, ...
                    Isp_vac, ...
                    h)
% GETEFFECTIVEISP Computes effective specific impulse
%
% INPUTS:
%   Isp_SL   : sea-level specific impulse [s]
%   Isp_vac  : vacuum specific impulse [s]
%   h        : altitude [m]
%
% OUTPUT:
%   Isp      : effective specific impulse [s]

%% Atmospheric pressure

P0 = 101325; % Sea-level pressure [Pa]

[~,~,P] = atmosisa(h);

%% Effective specific impulse

Isp = ...
    Isp_vac ...
    - (Isp_vac - Isp_SL) * (P / P0);

end