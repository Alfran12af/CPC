function valid = CheckMotorCompatibility( ...
                        motor_type, ...
                        prop)
% CHECKMOTORCOMPATIBILITY Validates propulsion compatibility
%
% INPUTS:
%   motor_type : propulsion system type
%   prop       : propellant property structure
%
% OUTPUT:
%   valid      : compatibility flag

%% Initialization

valid = false;

%% Single compatibility

if ischar(prop.compatible_motor)

    valid = strcmp( ...
                motor_type, ...
                prop.compatible_motor);

    return;

end

%% Multiple compatibility

if iscell(prop.compatible_motor)

    valid = ismember( ...
                motor_type, ...
                prop.compatible_motor);

end

end