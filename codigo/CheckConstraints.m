function valid = CheckConstraints( ...
                    solution, ...
                    architecture)
% CHECKCONSTRAINTS Verifies launcher feasibility constraints
%
% INPUTS:
%   solution     : evaluated launcher solution
%   architecture : launcher architecture structure
%
% OUTPUT:
%   valid        : feasibility flag

%% Initialization

valid = true;

%% Mass and payload checks

if solution.m0 <= 0
    valid = false;
    return;
end

if solution.payload_fraction < architecture.min_payload_fraction
    valid = false;
    return;
end

%% Global geometry checks

if solution.total_length > architecture.max_length
    valid = false;
    return;
end

if solution.max_diameter > architecture.max_diameter
    valid = false;
    return;
end

if solution.global_slenderness > architecture.global_slenderness_max
    valid = false;
    return;
end

%% Diameter compatibility

D = [ ...
    solution.geom1.D ...
    solution.geom2.D ...
    solution.geom3.D ];

if any(diff(D) > 0)
    valid = false;
    return;
end

if any(D(2:end) ./ D(1:end-1) < architecture.diameter_decay_min)
    valid = false;
    return;
end

end