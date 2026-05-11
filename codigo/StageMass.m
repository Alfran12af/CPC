function stage = StageMass( ...
                    mr, ...
                    epsilon, ...
                    payload)
% STAGEMASS Computes stage mass breakdown
%
% INPUTS:
%   mr       : stage mass ratio
%   epsilon  : structural fraction
%   payload  : upper stage mass or payload [kg]
%
% OUTPUT:
%   stage    : structure containing stage masses
%
% DESCRIPTION:
%
%   Computes:
%
%   - propellant mass
%   - structural mass
%   - dry mass
%   - initial mass
%   - final mass
%
%   using:
%
%       mr = mi/mf
%
%   and:
%
%       epsilon =
%           m_struct /
%           (m_struct + m_prop)
%
% ==========================================================

%% =========================================================
%% INITIALIZATION
%% =========================================================

stage.valid = false;

%% =========================================================
%% PHYSICAL VALIDITY CHECK
%% =========================================================
%
% Impossible configuration:
%
%   epsilon * mr >= 1
%

if epsilon * mr >= 1

    return;

end

%% =========================================================
%% PROPELLANT MASS
%% =========================================================
%
% Derived from:
%
%   mr = mi/mf
%
% considering structural fraction.
%

m_prop = ...
    ((mr - 1) * payload) / ...
    (1 - epsilon * mr);

%% =========================================================
%% STRUCTURAL MASS
%% =========================================================

m_struct = ...
    (epsilon * m_prop) / ...
    (1 - epsilon);

%% =========================================================
%% FINAL MASS
%% =========================================================
%
% Final mass after propellant depletion
%

mf = ...
    payload + m_struct;

%% =========================================================
%% INITIAL MASS
%% =========================================================
%
% Initial stage mass before burn
%

mi = ...
    mf + m_prop;

%% =========================================================
%% DRY MASS
%% =========================================================

m_dry = ...
    payload + m_struct;

%% =========================================================
%% MASS FRACTIONS
%% =========================================================

propellant_fraction = ...
    m_prop / mi;

structural_fraction_real = ...
    m_struct / (m_struct + m_prop);

%% =========================================================
%% STORE RESULTS
%% =========================================================

stage.valid = true;

%% ---------------------------------------------------------
%% MAIN MASSES
%% ---------------------------------------------------------

stage.mi = mi;

stage.mf = mf;

stage.m_prop = m_prop;

stage.m_struct = m_struct;

stage.m_dry = m_dry;

%% ---------------------------------------------------------
%% PAYLOAD
%% ---------------------------------------------------------

stage.payload = payload;

%% ---------------------------------------------------------
%% PERFORMANCE PARAMETERS
%% ---------------------------------------------------------

stage.mass_ratio = mr;

stage.epsilon = epsilon;

%% ---------------------------------------------------------
%% MASS FRACTIONS
%% ---------------------------------------------------------

stage.propellant_fraction = ...
    propellant_fraction;

stage.structural_fraction_real = ...
    structural_fraction_real;

%% =========================================================
%% SANITY CHECKS
%% =========================================================

if any([ ...
        mi ...
        mf ...
        m_prop ...
        m_struct] <= 0)

    stage.valid = false;

    return;

end

end