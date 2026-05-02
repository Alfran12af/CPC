function [Isp_real, engine, valid] = MatchMotors(Isp_req, params)
% MATCHMOTORS Assigns engine types and checks feasibility
%
% INPUTS:
%   Isp_req : required specific impulse per stage [s]
%   params  : global parameters
%
% OUTPUTS:
%   Isp_real : achievable Isp per stage [s]
%   engine   : struct with engine type info
%   valid    : boolean (true if feasible)
%
% DESCRIPTION:
%   Assigns propulsion type per stage and compares required Isp
%   with realistic achievable values considering operating conditions.

%% 1. DEFINE ENGINE TYPES (fixed by project requirements)

engine(1).type = 'Solid Rocket Motor';
engine(2).type = 'Liquid Pressure-Fed';
engine(3).type = 'Liquid Pump-Fed';

%% 2. ASSIGN REPRESENTATIVE ISP VALUES

% These values implicitly account for:
% - mixture ratio optimization
% - altitude conditions
% - typical engine performance

% Stage 1 → sea level conditions
Isp1_SL = 260;     % [s]

% Stage 2 → intermediate (approximate)
Isp2_mid = 300;    % [s]

% Stage 3 → vacuum optimized
Isp3_vac = 340;    % [s]

Isp_real = [Isp1_SL, Isp2_mid, Isp3_vac];

%% 3. APPLY SAFETY MARGIN

Isp_available = Isp_real * params.Isp_margin;

%% 4. FEASIBILITY CHECK

valid = true;

for i = 1:3
    if Isp_req(i) > Isp_available(i)
        valid = false;
        return;
    end
end

%% 5. ADD ADDITIONAL INFO (useful for report)

engine(1).environment = 'Sea level';
engine(2).environment = 'Transitional';
engine(3).environment = 'Vacuum';

engine(1).Isp = Isp_real(1);
engine(2).Isp = Isp_real(2);
engine(3).Isp = Isp_real(3);

end