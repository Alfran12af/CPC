function solution = EvaluateConfiguration( ...
                    candidate, ...
                    mission, ...
                    architecture, ...
                    params)

% EVALUATECONFIGURATION Evaluates one launcher configuration
%
% INPUTS:
%   candidate     : candidate configuration
%   mission       : mission data
%   architecture  : launcher architecture
%   params        : optimization parameters
%
% OUTPUT:
%   solution      : launcher solution structure

%% =========================================================
%% INITIALIZATION
%% =========================================================

solution.valid = false;

g0 = params.g0;

%% =========================================================
%% EXTRACT CANDIDATE DATA
%% =========================================================

DV = candidate.DV;

prop1 = candidate.prop1;
prop2 = candidate.prop2;
prop3 = candidate.prop3;

eps1 = candidate.eps1;
eps2 = candidate.eps2;
eps3 = candidate.eps3;

%% =========================================================
%% ISP SELECTION
%% =========================================================

% Stage 1 -> sea level
Isp1 = prop1.Isp_SL;

% Stage 2 -> mixed atmosphere
Isp2 = 0.5 * ...
       (prop2.Isp_SL + prop2.Isp_vac);

% Stage 3 -> vacuum
Isp3 = prop3.Isp_vac;

Isp = [Isp1 Isp2 Isp3];

%% =========================================================
%% MASS RATIOS
%% =========================================================

mr = exp(DV ./ (g0 .* Isp));

%% =========================================================
%% STAGE MASSES
%% =========================================================

payload = mission.m_payload;

% ---------- Stage 3 ----------

stage3 = StageMass( ...
            mr(3), ...
            eps3, ...
            payload);

% Check validity immediately
if ~stage3.valid
    return;
end

% ---------- Stage 2 ----------

stage2 = StageMass( ...
            mr(2), ...
            eps2, ...
            stage3.mi);

if ~stage2.valid
    return;
end

% ---------- Stage 1 ----------

stage1 = StageMass( ...
            mr(1), ...
            eps1, ...
            stage2.mi);

if ~stage1.valid
    return;
end

%% =========================================================
%% INITIAL MASS
%% =========================================================

m0 = stage1.mi;

%% =========================================================
%% GEOMETRY
%% =========================================================

% Reference diameters [m]

D1 = 0.50;
D2 = 0.40;
D3 = 0.30;

%% ---------------- STAGE 1 ----------------

tank1 = SolidMotorSizing( ...
            stage1.m_prop, ...
            prop1.rho_eff, ...
            D1);

%% ---------------- STAGE 2 ----------------

tank2 = LiquidTankSizing( ...
            stage2.m_prop, ...
            prop2, ...
            D2);

%% ---------------- STAGE 3 ----------------

tank3 = LiquidTankSizing( ...
            stage3.m_prop, ...
            prop3, ...
            D3);

%% =========================================================
%% VEHICLE GEOMETRY
%% =========================================================

total_length = ...
    tank1.length + ...
    tank2.total_length + ...
    tank3.total_length;

payload_fraction = ...
    mission.m_payload / m0;

%% =========================================================
%% STORE RESULTS
%% =========================================================

solution.m0 = m0;

solution.DV = DV;

solution.Isp = Isp;

solution.mr = mr;

solution.payload_fraction = ...
    payload_fraction;

solution.total_length = ...
    total_length;

%% ---------------- PROPELLANTS ----------------

solution.prop1 = prop1;
solution.prop2 = prop2;
solution.prop3 = prop3;

%% ---------------- STRUCTURAL FRACTIONS ----------------

solution.eps1 = eps1;
solution.eps2 = eps2;
solution.eps3 = eps3;

%% ---------------- STAGES ----------------

solution.stage1 = stage1;
solution.stage2 = stage2;
solution.stage3 = stage3;

%% ---------------- TANKS ----------------

solution.tank1 = tank1;
solution.tank2 = tank2;
solution.tank3 = tank3;

%% =========================================================
%% CONSTRAINTS
%% =========================================================

valid = CheckConstraints( ...
            stage1, ...
            stage2, ...
            stage3, ...
            solution, ...
            architecture);

solution.valid = valid;

end