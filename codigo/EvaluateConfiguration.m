function solution = EvaluateConfiguration( ...
                    candidate, ...
                    mission, ...
                    architecture, ...
                    params)
% EVALUATECONFIGURATION Evaluates launcher configuration
%
% INPUTS:
%   candidate    : launcher candidate
%   mission      : mission data
%   architecture : launcher architecture
%   params       : optimization parameters
%
% OUTPUT:
%   solution     : evaluated launcher solution

%% Initialization

solution.valid = false;

g0 = params.g0;

%% Candidate data

DV = candidate.DV;

prop1 = candidate.prop1;
prop2 = candidate.prop2;
prop3 = candidate.prop3;

eps1 = candidate.eps1;
eps2 = candidate.eps2;
eps3 = candidate.eps3;

%% Specific impulse selection

Isp1 = GetEffectiveIsp( ...
            prop1.Isp_SL, ...
            prop1.Isp_vac, ...
            10000);

Isp2 = 0.95 * prop2.Isp_vac;

Isp3 = prop3.Isp_vac;

Isp = [ ...
    Isp1 ...
    Isp2 ...
    Isp3 ];

%% Mass ratios

mr = exp(DV ./ (g0 .* Isp));

%% Payload

payload = mission.m_payload;

%% Stage 3 sizing (orbital insertion stage)

stage3 = StageMass( ...
            mr(3), ...
            eps3, ...
            payload);

if ~stage3.valid
    return;
end

%% Stage 2 sizing (main ascent liquid stage)

stage2 = StageMass( ...
            mr(2), ...
            eps2, ...
            stage3.mi);

if ~stage2.valid
    return;
end

%% Stage 1 sizing (solid booster)

stage1 = StageMass( ...
            mr(1), ...
            eps1, ...
            stage2.mi);

if ~stage1.valid
    return;
end

%% Lift-off mass

m0 = stage1.mi;

%% Stage geometry

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

%% Global geometry

total_length = ...
      geom1.total_length ...
    + geom2.total_length ...
    + geom3.total_length;

max_diameter = max([ ...
    geom1.D ...
    geom2.D ...
    geom3.D]);

global_slenderness = ...
    total_length / max_diameter;

%% Payload fraction

payload_fraction = ...
    mission.m_payload / m0;

%% Propulsion sizing

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

%% Store solution

solution.valid = true;

solution.m0 = m0;

solution.DV = DV;

solution.Isp = Isp;

solution.mr = mr;

solution.payload_fraction = ...
    payload_fraction;

%% Stage data

solution.stage1 = stage1;
solution.stage2 = stage2;
solution.stage3 = stage3;

%% Geometry data

solution.geom1 = geom1;
solution.geom2 = geom2;
solution.geom3 = geom3;

solution.total_length = total_length;

solution.max_diameter = max_diameter;

solution.global_slenderness = ...
    global_slenderness;

%% Propellant data

solution.prop1 = prop1;
solution.prop2 = prop2;
solution.prop3 = prop3;

%% Engine data

solution.engine1 = engine1;
solution.engine2 = engine2;
solution.engine3 = engine3;

%% Final constraints

solution.valid = CheckConstraints( ...
                     solution, ...
                     architecture);

end