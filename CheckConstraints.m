function valid = CheckConstraints( ...
    stage1, ...
    stage2, ...
    stage3, ...
    solution, ...
    architecture)

% CHECKCONSTRAINTS Validates launcher feasibility
%
% INPUTS:
%   stage1        : stage 1 masses
%   stage2        : stage 2 masses
%   stage3        : stage 3 masses
%   solution      : launcher solution
%   architecture  : launcher architecture
%
% OUTPUT:
%   valid         : boolean validity flag

%% =========================================================
%% INITIALIZATION
%% =========================================================

valid = true;

%% =========================================================
%% POSITIVE MASSES
%% =========================================================

if any([ ...
        stage1.mi, ...
        stage2.mi, ...
        stage3.mi] <= 0)

    valid = false;
    return;

end

%% =========================================================
%% STAGE VALIDITY
%% =========================================================

if ~stage1.valid || ...
   ~stage2.valid || ...
   ~stage3.valid

    valid = false;
    return;

end

%% =========================================================
%% PAYLOAD FRACTION
%% =========================================================

if solution.payload_fraction < ...
        architecture.min_payload_fraction

    valid = false;
    return;

end

%% =========================================================
%% TOTAL LENGTH
%% =========================================================

if solution.total_length > ...
        architecture.max_length

    valid = false;
    return;

end

%% =========================================================
%% SLENDERNESS RATIO
%% =========================================================

% Approximate launcher diameter
D = max([ ...
    solution.tank1.diameter, ...
    solution.tank2.D, ...
    solution.tank3.D]);

slenderness = solution.total_length / D;

% Typical launchers: 10-20
if slenderness > 25

    valid = false;
    return;

end

%% =========================================================
%% GEOMETRY CHECK
%% =========================================================

if solution.total_length <= 0

    valid = false;
    return;

end

end