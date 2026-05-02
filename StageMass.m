function stage = StageMass(mr, epsilon, m_payload)
% Computes stage masses using mass ratio and structural fraction

% mf = final mass after burn
mf = m_payload / (1 - epsilon);

% initial mass
mi = mr * mf;

% propellant and structure
m_prop = mi - mf;
m_struct = mf - m_payload;

stage.mi = mi;
stage.mf = mf;
stage.m_prop = m_prop;
stage.m_struct = m_struct;
stage.m_payload = m_payload;

end