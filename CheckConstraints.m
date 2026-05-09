function valid = CheckConstraints( ...
                    solution, ...
                    architecture)

valid = true;

%% =========================================================
%% POSITIVE MASS
%% =========================================================

if solution.m0 <= 0

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
%% MAXIMUM DIAMETER
%% =========================================================

if solution.max_diameter > ...
        architecture.max_diameter

    valid = false;
    return;

end

%% =========================================================
%% GLOBAL SLENDERNESS
%% =========================================================

if solution.global_slenderness > ...
        architecture.global_slenderness_max

    valid = false;
    return;

end

%% =========================================================
%% DIAMETER CASCADE
%% =========================================================

if solution.geom2.D > solution.geom1.D

    valid = false;
    return;

end

if solution.geom3.D > solution.geom2.D

    valid = false;
    return;

end

end