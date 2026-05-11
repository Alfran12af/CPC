function valid = CheckMotorCompatibility( ...
                        motor_type, ...
                        prop)
% CHECKMOTORCOMPATIBILITY Validates propulsion compatibility
%
% INPUTS:
%   motor_type : stage motor type
%   prop       : propellant structure
%
% OUTPUT:
%   valid      : compatibility flag
%
% DESCRIPTION:
%
%   Checks whether a propellant combination
%   is compatible with the selected
%   propulsion system.
%
% ==========================================================

%% =========================================================
%% INITIALIZATION
%% =========================================================

valid = false;

%% =========================================================
%% SINGLE STRING CASE
%% =========================================================
%
% Example:
%
%   'solid'
%

if ischar(prop.compatible_motor)

    valid = strcmp( ...
                motor_type, ...
                prop.compatible_motor);

    return;

end

%% =========================================================
%% MULTIPLE COMPATIBILITY CASE
%% =========================================================
%
% Example:
%
%   {
%       'pressure-fed',
%       'pump-fed'
%   }
%

if iscell(prop.compatible_motor)

    valid = ismember( ...
                motor_type, ...
                prop.compatible_motor);

end

end