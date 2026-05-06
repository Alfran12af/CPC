function stage = StageMass(mr, epsilon, payload)
% STAGEMASS Computes stage mass breakdown
%
% INPUTS:
%   mr       : mass ratio
%   epsilon  : structural fraction
%   payload  : upper stage mass or payload [kg]
%
% OUTPUT:
%   stage    : struct containing stage masses
%
% DESCRIPTION:
%   Computes:
%   - initial mass
%   - final mass
%   - propellant mass
%   - structural mass

%% =========================================================
%% VALIDITY CHECK
%% =========================================================

% Impossible configuration
if epsilon * mr >= 1
    
    stage.valid = false;
    
    return;
    
end

%% =========================================================
%% PROPELLANT MASS
%% =========================================================

m_prop = ((mr - 1) * payload) / ...
         (1 - epsilon * mr);

%% =========================================================
%% STRUCTURAL MASS
%% =========================================================

m_struct = (epsilon * m_prop) / ...
           (1 - epsilon);

%% =========================================================
%% TOTAL MASSES
%% =========================================================

mf = payload + m_struct;

mi = mf + m_prop;

%% =========================================================
%% STORE RESULTS
%% =========================================================

stage.valid = true;

stage.mi = mi;
stage.mf = mf;

stage.m_prop = m_prop;
stage.m_struct = m_struct;

stage.payload = payload;

stage.m_dry = m_struct + payload;

end