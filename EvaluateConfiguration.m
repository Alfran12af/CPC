function solution = EvaluateConfiguration( ...
                    candidate, ...
                    mission, ...
                    architecture, ...
                    params)
% EVALUATECONFIGURATION Evaluates launcher configuration
%
% DESCRIPTION:
%
%   PHASE 1 -> Vehicle sizing
%       - Tsiolkovsky
%       - stage masses
%       - geometry
%
%   PHASE 2 -> Propulsion sizing
%       - thrust
%       - mass flow
%       - burn time
%
% ==========================================================

%% =========================================================
%% INITIALIZATION
%% =========================================================

solution.valid = false;

g0 = params.g0;

%% =========================================================
%% EXTRACT CANDIDATE
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

Isp1 = prop1.Isp_SL;

Isp2 = 0.5 * ...
       (prop2.Isp_SL + prop2.Isp_vac);

Isp3 = prop3.Isp_vac;

Isp = [Isp1 Isp2 Isp3];

%% =========================================================
%% MASS RATIOS
%% =========================================================

mr = exp(DV ./ (g0 .* Isp));

%% =========================================================
%% PAYLOAD
%% =========================================================

payload = mission.m_payload;

%% =========================================================
%% STAGE 3
%% =========================================================

stage3 = StageMass( ...
            mr(3), ...
            eps3, ...
            payload);

if ~stage3.valid
    return;
end

%% =========================================================
%% STAGE 2
%% =========================================================

stage2 = StageMass( ...
            mr(2), ...
            eps2, ...
            stage3.mi);

if ~stage2.valid
    return;
end

%% =========================================================
%% STAGE 1
%% =========================================================

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
%% STAGE GEOMETRY
%% =========================================================

geom1 = StageGeometry( ...
            stage1, ...
            prop1, ...
            architecture.stage(1), ...
            params);

geom2 = StageGeometry( ...
            stage2, ...
            prop2, ...
            architecture.stage(2), ...
            params);

geom3 = StageGeometry( ...
            stage3, ...
            prop3, ...
            architecture.stage(3), ...
            params);

%% =========================================================
%% VEHICLE GEOMETRY
%% =========================================================

total_length = ...
    geom1.total_length + ...
    geom2.total_length + ...
    geom3.total_length;

max_diameter = max([ ...
    geom1.D ...
    geom2.D ...
    geom3.D]);

global_slenderness = ...
    total_length / max_diameter;

%% =========================================================
%% PAYLOAD FRACTION
%% =========================================================

payload_fraction = ...
    mission.m_payload / m0;

%% =========================================================
%% PROPULSION SIZING
%% =========================================================

engine1 = EngineSizing( ...
                stage1, ...
                prop1, ...
                Isp1, ...
                params.TW_stage1, ...
                params);

engine2 = EngineSizing( ...
                stage2, ...
                prop2, ...
                Isp2, ...
                params.TW_stage2, ...
                params);

engine3 = EngineSizing( ...
                stage3, ...
                prop3, ...
                Isp3, ...
                params.TW_stage3, ...
                params);

%% =========================================================
%% STORE RESULTS
%% =========================================================

solution.valid = true;

%% ---------------------------------------------------------
%% PERFORMANCE
%% ---------------------------------------------------------

solution.m0 = m0;

solution.DV = DV;

solution.Isp = Isp;

solution.mr = mr;

solution.payload_fraction = ...
    payload_fraction;

%% ---------------------------------------------------------
%% STAGES
%% ---------------------------------------------------------

solution.stage1 = stage1;
solution.stage2 = stage2;
solution.stage3 = stage3;

%% ---------------------------------------------------------
%% GEOMETRY
%% ---------------------------------------------------------

solution.geom1 = geom1;
solution.geom2 = geom2;
solution.geom3 = geom3;

solution.total_length = total_length;

solution.max_diameter = max_diameter;

solution.global_slenderness = ...
    global_slenderness;

%% ---------------------------------------------------------
%% PROPELLANTS
%% ---------------------------------------------------------

solution.prop1 = prop1;
solution.prop2 = prop2;
solution.prop3 = prop3;

%% ---------------------------------------------------------
%% ENGINES
%% ---------------------------------------------------------

solution.engine1 = engine1;
solution.engine2 = engine2;
solution.engine3 = engine3;

%% =========================================================
%% FINAL CONSTRAINT CHECK
%% =========================================================

solution.valid = CheckConstraints( ...
                    solution, ...
                    architecture);

end