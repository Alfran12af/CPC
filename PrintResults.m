function PrintResults(sol)

fprintf('\n===== OPTIMAL SOLUTION =====\n');

%% --- GLOBAL RESULTS ---
fprintf('Initial mass (m0): %.2f kg\n', sol.m0);
fprintf('Payload mass     : %.2f kg\n', sol.stage3.m_payload);

payload_fraction = sol.stage3.m_payload / sol.m0;
fprintf('Payload fraction : %.3f\n\n', payload_fraction);

%% --- DELTA-V ---
fprintf('Delta-V distribution [m/s]:\n');
fprintf('  Stage 1: %.2f\n', sol.DV(1));
fprintf('  Stage 2: %.2f\n', sol.DV(2));
fprintf('  Stage 3: %.2f\n\n', sol.DV(3));

%% --- MASS RATIOS ---
fprintf('Mass ratios:\n');
fprintf('  Stage 1: %.2f\n', sol.mr(1));
fprintf('  Stage 2: %.2f\n', sol.mr(2));
fprintf('  Stage 3: %.2f\n\n', sol.mr(3));

%% --- ISP ---
fprintf('Specific impulse [s]:\n');
fprintf('  Required:\n');
fprintf('    S1: %.2f | S2: %.2f | S3: %.2f\n', sol.Isp_req);
fprintf('  Available:\n');
fprintf('    S1: %.2f | S2: %.2f | S3: %.2f\n\n', sol.Isp_real);

%% --- ENGINE INFO ---
fprintf('Engine configuration:\n');
for i = 1:3
    fprintf('  Stage %d: %s (%s) | Isp = %.1f s\n', ...
        i, sol.engine(i).type, sol.engine(i).environment, sol.engine(i).Isp);
end
fprintf('\n');

%% --- STAGE MASSES ---
fprintf('Stage mass breakdown:\n');

fprintf('  Stage 1:\n');
fprintf('    Initial mass  : %.2f kg\n', sol.stage1.mi);
fprintf('    Propellant    : %.2f kg\n', sol.stage1.m_prop);
fprintf('    Structure     : %.2f kg\n', sol.stage1.m_struct);

fprintf('  Stage 2:\n');
fprintf('    Initial mass  : %.2f kg\n', sol.stage2.mi);
fprintf('    Propellant    : %.2f kg\n', sol.stage2.m_prop);
fprintf('    Structure     : %.2f kg\n', sol.stage2.m_struct);

fprintf('  Stage 3:\n');
fprintf('    Initial mass  : %.2f kg\n', sol.stage3.mi);
fprintf('    Propellant    : %.2f kg\n', sol.stage3.m_prop);
fprintf('    Structure     : %.2f kg\n\n', sol.stage3.m_struct);

%% --- TANK GEOMETRY ---
fprintf('Tank geometry:\n');

% Stage 1 (solid)
fprintf('  Stage 1 (Solid motor):\n');
fprintf('    Diameter : %.2f m\n', sol.tank1.diameter);
fprintf('    Length   : %.2f m\n', sol.tank1.length);

% Stage 2 (liquid)
fprintf('  Stage 2 (Liquid):\n');
fprintf('    Ox tank diameter   : %.2f m\n', sol.tank2.D_ox);
fprintf('    Fuel tank diameter : %.2f m\n', sol.tank2.D_fuel);

% Stage 3 (liquid)
fprintf('  Stage 3 (Liquid):\n');
fprintf('    Ox tank diameter   : %.2f m\n', sol.tank3.D_ox);
fprintf('    Fuel tank diameter : %.2f m\n\n', sol.tank3.D_fuel);

%% --- TOTAL SIZE ESTIMATE ---
total_length = sol.tank1.length + sol.tank2.total_length + sol.tank3.total_length;

fprintf('Estimated total vehicle length: %.2f m\n', total_length);

fprintf('============================\n');

end