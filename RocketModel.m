function sol = RocketModel(DV, mr, params)
% ROCKETMODEL Evaluates a 3-stage rocket configuration
%
% INPUTS:
%   DV     : Delta-V per stage [m/s]
%   mr     : mass ratios per stage [-]
%   params : global parameters
%
% OUTPUT:
%   sol    : structure with results and validity flag

g0 = params.g0;

%% 0. Basic checks

if any(mr <= 1)
    sol.valid = false;
    return;
end

%% 1. Required Isp (Tsiolkovski)

Isp_req = DV ./ (g0 .* log(mr));

%% 2. Engine selection & feasibility

[Isp_real, engine, okIsp] = MatchMotors(Isp_req, params);

if ~okIsp
    sol.valid = false;
    return;
end

%% 3. Backward mass propagation

m_payload = params.m_payload;

stage3 = StageMass(mr(3), params.eps3, m_payload);
stage2 = StageMass(mr(2), params.eps2, stage3.mi);
stage1 = StageMass(mr(1), params.eps1, stage2.mi);

m0 = stage1.mi;

%% 3.1 Tank sizing and propellant selection

D1 = 0.5;  % [m] assumed diameter


% --- Stage 1 (solid) ---
prop1 = PropellantData('solid');
tank1 = SolidMotorSizing(stage1.m_prop, prop1.rho, D1);

% --- Stage 2 (liquid pressure-fed) ---
prop2 = PropellantData('LOX_RP1');
tank2 = LiquidTankSizing(stage2.m_prop, prop2);

% --- Stage 3 (liquid pump-fed) ---
prop3 = PropellantData('LOX_LH2');
tank3 = LiquidTankSizing(stage3.m_prop, prop3);

%% 4. Constraints

valid = CheckConstraints(stage1, stage2, stage3, params);

%% 5. Store results

sol.valid = valid;
sol.m0 = m0;

sol.DV = DV;
sol.mr = mr;

sol.Isp_req = Isp_req;
sol.Isp_real = Isp_real;

sol.engine = engine;

sol.stage1 = stage1;
sol.stage2 = stage2;
sol.stage3 = stage3;

sol.tank1 = tank1;
sol.tank2 = tank2;
sol.tank3 = tank3;

sol.prop1 = prop1;
sol.prop2 = prop2;
sol.prop3 = prop3;

end