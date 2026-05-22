function PrintResults(sol)
% PRINTRESULTS Displays optimal launcher configuration
%
% INPUT:
%   sol : optimal solution structure

fprintf('\n');
fprintf('==========================================================================\n');
fprintf('                    OPTIMAL LAUNCHER CONFIGURATION                        \n');
fprintf('==========================================================================\n');

%% ------------------------------------------------------------------------
% Global results
% -------------------------------------------------------------------------

fprintf('\nGLOBAL RESULTS\n');
fprintf('--------------------------------------------------------------------------\n');

fprintf('   Initial launcher mass .............. %.2f kg\n', ...
    sol.m0);

fprintf('   Payload mass ....................... %.2f kg\n', ...
    sol.stage3.payload);

fprintf('   Payload fraction ................... %.4f\n', ...
    sol.payload_fraction);

fprintf('   Total launcher length .............. %.2f m\n', ...
    sol.total_length);

fprintf('   Maximum launcher diameter .......... %.2f m\n', ...
    sol.max_diameter);

fprintf('   Global slenderness ratio ........... %.2f\n', ...
    sol.global_slenderness);

%% ------------------------------------------------------------------------
% Stage results
% -------------------------------------------------------------------------

for i = 1:3

    fprintf('\n');
    fprintf('STAGE %d\n', i);
    fprintf('--------------------------------------------------------------------------\n');

    %% Stage selection

    prop = sol.(sprintf('prop%d',i));

    fprintf('   Propellant ........................ %s\n', ...
        prop.name);
   

    %% Delta-V and propulsion

    fprintf('   Delta-V ........................... %.2f m/s\n', ...
        sol.DV(i));

    fprintf('   Specific impulse .................. %.2f s\n', ...
        sol.Isp(i));

    fprintf('   Mass ratio ........................ %.3f\n', ...
        sol.mr(i));

    %% Stage masses

    stage = sol.(sprintf('stage%d',i));

    fprintf('   Initial mass ...................... %.2f kg\n', ...
        stage.mi);

    fprintf('   Propellant mass ................... %.2f kg\n', ...
        stage.m_prop);

    fprintf('   Structural mass ................... %.2f kg\n', ...
        stage.m_struct);

    %% Geometry

    geom = sol.(sprintf('geom%d',i));

    fprintf('   Diameter .......................... %.2f m\n', ...
        geom.D);

    fprintf('   Total length ...................... %.2f m\n', ...
        geom.total_length);

    fprintf('   Aspect ratio ...................... %.2f\n', ...
        geom.aspect_ratio);

    %% Engine

    engine = sol.(sprintf('engine%d',i));

    fprintf('   Thrust ............................ %.2f N\n', ...
        engine.T);

    fprintf('   Mass flow rate .................... %.2f kg/s\n', ...
        engine.mdot);

    fprintf('   Burn time ......................... %.2f s\n', ...
        engine.tb);

    fprintf('   Thrust-to-weight ratio ............ %.2f\n', ...
        engine.TW);

end

fprintf('\n');
fprintf('==========================================================================\n');

end