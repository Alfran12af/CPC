function result = OptimizeRocket( ...
                    mission, ...
                    architecture, ...
                    params)
% OPTIMIZEROCKET Performs launcher optimization
%
% INPUTS:
%   mission      : mission structure
%   architecture : launcher architecture structure
%   params       : optimization parameters
%
% OUTPUT:
%   result       : optimal solution structure

fprintf('\n');
fprintf('==========================================================================\n');
fprintf('                            OPTIMIZATION                                  \n');
fprintf('==========================================================================\n');

%% ------------------------------------------------------------------------
% Generate design space
% -------------------------------------------------------------------------

fprintf('\nGenerating candidate configurations...\n');

candidates = GenerateCandidates( ...
                    mission, ...
                    architecture, ...
                    params);

n_candidates = length(candidates);

fprintf('   Total candidates .................. %d\n', ...
    n_candidates);

%% ------------------------------------------------------------------------
% Initialization
% -------------------------------------------------------------------------

best_solution  = [];
best_m0        = inf;

valid_counter   = 0;
invalid_counter = 0;

fprintf('\nEvaluating configurations...\n');

%% ------------------------------------------------------------------------
% Candidate evaluation
% -------------------------------------------------------------------------

for i = 1:n_candidates

    candidate = candidates(i);

    solution = EvaluateConfiguration( ...
                    candidate, ...
                    mission, ...
                    architecture, ...
                    params);

    %% Invalid solution

    if ~solution.valid

        invalid_counter = invalid_counter + 1;
        continue;

    end

    %% Valid solution

    valid_counter = valid_counter + 1;

    %% Progress display

    if mod(i,100) == 0 || i == n_candidates

        fprintf( ...
            '   Progress: %6d / %6d | Valid: %5d | Best m0: %.2f kg\n', ...
            i, ...
            n_candidates, ...
            valid_counter, ...
            best_m0);

    end

    %% New optimum

    if solution.m0 < best_m0

        best_m0 = solution.m0;
        best_solution = solution;

        fprintf('\n');
        fprintf('   New optimum found\n');
        fprintf('   -------------------------------------------------------\n');

        fprintf('      Candidate ID ................. %d\n', ...
            i);

        fprintf('      Initial mass ................. %.2f kg\n', ...
            best_m0);

        fprintf('      Payload fraction ............. %.4f\n', ...
            solution.payload_fraction);

        fprintf('      Propulsion configuration ..... %s | %s | %s\n', ...
            solution.prop1.name, ...
            solution.prop2.name, ...
            solution.prop3.name);

        fprintf('      Delta-V distribution ......... %.0f | %.0f | %.0f m/s\n', ...
            solution.DV(1), ...
            solution.DV(2), ...
            solution.DV(3));

    end

end

%% ------------------------------------------------------------------------
% Feasibility check
% -------------------------------------------------------------------------

if isempty(best_solution)

    error('No feasible launcher configuration was found.');

end

%% ------------------------------------------------------------------------
% Final summary
% -------------------------------------------------------------------------

result = best_solution;

fprintf('\n');
fprintf('==========================================================================\n');
fprintf('                         OPTIMIZATION SUMMARY                             \n');
fprintf('==========================================================================\n');

fprintf('   Total candidates ................. %d\n', ...
    n_candidates);

fprintf('   Valid configurations ............. %d\n', ...
    valid_counter);

fprintf('   Invalid configurations ........... %d\n', ...
    invalid_counter);

fprintf('\n');
fprintf('BEST CONFIGURATION\n');
fprintf('--------------------------------------------------------------------------\n');

fprintf('   Initial launcher mass ............ %.2f kg\n', ...
    result.m0);

fprintf('   Payload fraction ................. %.4f\n', ...
    result.payload_fraction);

fprintf('   Total launcher length ............ %.2f m\n', ...
    result.total_length);

fprintf('   Maximum diameter ................. %.2f m\n', ...
    result.max_diameter);

fprintf('   Propulsion configuration ......... %s | %s | %s\n', ...
    result.prop1.name, ...
    result.prop2.name, ...
    result.prop3.name);

fprintf('\n');
fprintf('==========================================================================\n');

end