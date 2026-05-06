function PrintResults(sol)
% PRINTRESULTS Displays optimal launcher configuration
%
% INPUT:
%   sol : optimal solution structure

%% =========================================================
%% HEADER
%% =========================================================

fprintf('\n');
fprintf('=============================================\n');
fprintf('         OPTIMAL LAUNCHER CONFIGURATION      \n');
fprintf('=============================================\n');

%% =========================================================
%% GLOBAL RESULTS
%% =========================================================

fprintf('\n');
fprintf('--------------- GLOBAL RESULTS --------------\n');

fprintf('Initial mass (m0)      : %.2f kg\n', ...
        sol.m0);

fprintf('Payload mass           : %.2f kg\n', ...
        sol.stage3.payload);

fprintf('Payload fraction       : %.4f\n', ...
        sol.payload_fraction);

fprintf('Total vehicle length   : %.2f m\n', ...
        sol.total_length);

%% =========================================================
%% DELTA-V DISTRIBUTION
%% =========================================================

fprintf('\n');
fprintf('------------- DELTA-V DISTRIBUTION ----------\n');

fprintf('Stage 1 : %.2f m/s\n', sol.DV(1));
fprintf('Stage 2 : %.2f m/s\n', sol.DV(2));
fprintf('Stage 3 : %.2f m/s\n', sol.DV(3));

%% =========================================================
%% ISP
%% =========================================================

fprintf('\n');
fprintf('------------------- ISP ---------------------\n');

fprintf('Stage 1 : %.2f s\n', sol.Isp(1));
fprintf('Stage 2 : %.2f s\n', sol.Isp(2));
fprintf('Stage 3 : %.2f s\n', sol.Isp(3));

%% =========================================================
%% MASS RATIOS
%% =========================================================

fprintf('\n');
fprintf('--------------- MASS RATIOS -----------------\n');

fprintf('Stage 1 : %.3f\n', sol.mr(1));
fprintf('Stage 2 : %.3f\n', sol.mr(2));
fprintf('Stage 3 : %.3f\n', sol.mr(3));

%% =========================================================
%% PROPELLANTS
%% =========================================================

fprintf('\n');
fprintf('-------------- PROPELLANTS ------------------\n');

fprintf('Stage 1 : %s\n', ...
        sol.prop1.name);

fprintf('Stage 2 : %s\n', ...
        sol.prop2.name);

fprintf('Stage 3 : %s\n', ...
        sol.prop3.name);

%% =========================================================
%% STAGE MASSES
%% =========================================================

fprintf('\n');
fprintf('--------------- STAGE MASSES ----------------\n');

%% ---------- Stage 1 ----------

fprintf('\nStage 1\n');

fprintf('Initial mass      : %.2f kg\n', ...
        sol.stage1.mi);

fprintf('Propellant mass   : %.2f kg\n', ...
        sol.stage1.m_prop);

fprintf('Structural mass   : %.2f kg\n', ...
        sol.stage1.m_struct);

%% ---------- Stage 2 ----------

fprintf('\nStage 2\n');

fprintf('Initial mass      : %.2f kg\n', ...
        sol.stage2.mi);

fprintf('Propellant mass   : %.2f kg\n', ...
        sol.stage2.m_prop);

fprintf('Structural mass   : %.2f kg\n', ...
        sol.stage2.m_struct);

%% ---------- Stage 3 ----------

fprintf('\nStage 3\n');

fprintf('Initial mass      : %.2f kg\n', ...
        sol.stage3.mi);

fprintf('Propellant mass   : %.2f kg\n', ...
        sol.stage3.m_prop);

fprintf('Structural mass   : %.2f kg\n', ...
        sol.stage3.m_struct);

%% =========================================================
%% GEOMETRY
%% =========================================================

fprintf('\n');
fprintf('------------------ GEOMETRY -----------------\n');

%% ---------- Solid stage ----------

fprintf('\nStage 1 Solid Motor\n');

fprintf('Diameter          : %.2f m\n', ...
        sol.tank1.diameter);

fprintf('Length            : %.2f m\n', ...
        sol.tank1.length);

%% ---------- Stage 2 ----------

fprintf('\nStage 2 Tanks\n');

fprintf('Tank diameter     : %.2f m\n', ...
        sol.tank2.D);

fprintf('Total tank length : %.2f m\n', ...
        sol.tank2.total_length);

%% ---------- Stage 3 ----------

fprintf('\nStage 3 Tanks\n');

fprintf('Tank diameter     : %.2f m\n', ...
        sol.tank3.D);

fprintf('Total tank length : %.2f m\n', ...
        sol.tank3.total_length);

%% =========================================================
%% FOOTER
%% =========================================================

fprintf('\n');
fprintf('=============================================\n');

end