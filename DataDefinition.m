function mission = DataDefinition()
% DATADEFINITION Defines mission requirements
%
% OUTPUT:
%   mission : structure containing all mission data
%
% DESCRIPTION:
%   Defines:
%
%   - target orbit
%   - payload mass
%   - launch site
%   - Earth constants
%   - mission losses
%   - preliminary launcher assumptions
%

%% =========================================================
%% MISSION REQUIREMENTS
%% =========================================================

% Payload mass [kg]
mission.m_payload = 20;

% Target orbit altitude [m]
mission.H = 600e3;

% Orbit type
mission.orbit = 'LEO';

%% =========================================================
%% TARGET ORBIT
%% =========================================================

mission.circular_orbit = true;

%% =========================================================
%% LAUNCH SITE
%% =========================================================

mission.launch_site = 'Mediterranean Coast';

mission.latitude = 38 + 2/60;      % [deg]

%% =========================================================
%% EARTH CONSTANTS
%% =========================================================

mission.R_E = 6371e3;

mission.mu = 3.986e14;

mission.g0 = 9.81;

mission.T_E = 86164;

%% =========================================================
%% DESIGN OBJECTIVES
%% =========================================================

mission.objective = 'minimize_m0';

%% =========================================================
%% DISPLAY SUMMARY
%% =========================================================

fprintf('\n');
fprintf('=========================================================\n');
fprintf('                     MISSION DATA                        \n');
fprintf('=========================================================\n');

%% ---------------------------------------------------------
%% MISSION REQUIREMENTS
%% ---------------------------------------------------------

fprintf('\n');
fprintf('---------------- MISSION REQUIREMENTS -------------------\n');

fprintf('\n');
fprintf('   Payload mass ................. %.2f kg\n', ...
        mission.m_payload);

fprintf('   Target altitude .............. %.2f km\n', ...
        mission.H/1e3);

fprintf('   Orbit type ................... %s\n', ...
        mission.orbit);

fprintf('   Circular orbit ............... %d\n', ...
        mission.circular_orbit);

%% ---------------------------------------------------------
%% LAUNCH SITE
%% ---------------------------------------------------------

fprintf('\n');
fprintf('------------------- LAUNCH SITE -------------------------\n');

fprintf('\n');
fprintf('   Launch site .................. %s\n', ...
        mission.launch_site);

fprintf('   Launch latitude .............. %.2f deg\n', ...
        mission.latitude);

%% ---------------------------------------------------------
%% DESIGN OBJECTIVE
%% ---------------------------------------------------------

fprintf('\n');
fprintf('---------------- DESIGN OBJECTIVE -----------------------\n');

fprintf('\n');
fprintf('   Optimization target .......... %s\n', ...
        mission.objective);

fprintf('\n');
fprintf('=========================================================\n');

end