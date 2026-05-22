function stage = StageMass(mr, epsilon, payload)
% STAGEMASS Preliminary stage mass estimation
%
% INPUTS:
%   mr       : stage mass ratio [-]
%   epsilon  : structural fraction [-]
%   payload  : upper stage or payload mass [kg]
%
% OUTPUT:
%   stage    : stage mass data structure

%% Validity check

stage.valid = false;

if epsilon * mr >= 1
    return;
end

%% Mass calculation

m_prop = ...
    ((mr - 1) * payload) / ...
    (1 - epsilon * mr);

m_struct = ...
    (epsilon * m_prop) / ...
    (1 - epsilon);

mf = ...
    payload + m_struct;

mi = ...
    mf + m_prop;

%% Physical consistency

if any([mi mf m_prop m_struct] <= 0)
    return;
end

%% Store results

stage.valid    = true;

stage.mi       = mi;
stage.mf       = mf;

stage.m_prop   = m_prop;
stage.m_struct = m_struct;

stage.payload  = payload;

stage.mass_ratio = mr;
stage.epsilon    = epsilon;

stage.propellant_fraction = ...
    m_prop / mi;

end