function result = OptimizeRocket( ...
                    mission, ...
                    architecture, ...
                    params)
% OPTIMIZEROCKET Finds optimal launcher configuration
%
% INPUTS:
%   mission      : mission structure
%   architecture : launcher architecture
%   params       : optimization settings
%
% OUTPUT:
%   result       : optimal launcher solution
%
% ==========================================================

fprintf('\n');
fprintf('=========================================================\n');
fprintf('                    OPTIMIZATION                         \n');
fprintf('=========================================================\n');

%% =========================================================
%% GENERATE DESIGN SPACE
%% =========================================================

fprintf('\n');
fprintf('---------------- GENERATING DESIGN SPACE ----------------\n');

candidates = GenerateCandidates( ...
                    mission, ...
                    architecture, ...
                    params);

n_candidates = length(candidates);

fprintf('\n');
fprintf('   Total candidates generated ..... %d\n', ...
        n_candidates);

%% =========================================================
%% INITIALIZATION
%% =========================================================

best_solution = [];

best_m0 = inf;

valid_counter = 0;

invalid_counter = 0;

%% =========================================================
%% EVALUATE CANDIDATES
%% =========================================================

fprintf('\n');
fprintf('---------------- EVALUATING CONFIGURATIONS --------------\n');

for i = 1:n_candidates

    %% -----------------------------------------------------
    %% CURRENT CANDIDATE
    %% -----------------------------------------------------

    candidate = candidates(i);

    %% -----------------------------------------------------
    %% EVALUATE CONFIGURATION
    %% -----------------------------------------------------

    solution = EvaluateConfiguration( ...
                    candidate, ...
                    mission, ...
                    architecture, ...
                    params);

    %% -----------------------------------------------------
    %% INVALID CONFIGURATION
    %% -----------------------------------------------------

    if ~solution.valid

        invalid_counter = ...
            invalid_counter + 1;

        continue;

    end

    %% -----------------------------------------------------
    %% VALID CONFIGURATION
    %% -----------------------------------------------------

    valid_counter = ...
        valid_counter + 1;

    %% -----------------------------------------------------
    %% CHECK OPTIMUM
    %% -----------------------------------------------------

    if solution.m0 < best_m0

        best_m0 = solution.m0;

        best_solution = solution;

        if params.verbose

            fprintf('\n');
            fprintf('   New optimum found\n');

            fprintf('      Initial mass .............. %.2f kg\n', ...
                    best_m0);

            fprintf('      Candidate ID .............. %d\n', ...
                    i);

        end

    end

end

%% =========================================================
%% FINAL RESULTS
%% =========================================================

fprintf('\n');
fprintf('---------------- OPTIMIZATION SUMMARY -------------------\n');

fprintf('\n');
fprintf('   Total candidates ............. %d\n', ...
        n_candidates);

fprintf('   Valid configurations ......... %d\n', ...
        valid_counter);

fprintf('   Invalid configurations ....... %d\n', ...
        invalid_counter);

%% =========================================================
%% CHECK FEASIBILITY
%% =========================================================

if isempty(best_solution)

    error(['No feasible launcher configuration ' ...
           'was found.']);

end

%% =========================================================
%% OUTPUT
%% =========================================================

result = best_solution;

fprintf('\n');
fprintf('------------------- FINAL OPTIMUM -----------------------\n');

fprintf('\n');
fprintf('   Optimization status .......... SUCCESS\n');

fprintf('   Best initial mass ............ %.2f kg\n', ...
        result.m0);

fprintf('   Payload fraction ............. %.4f\n', ...
        result.payload_fraction);

fprintf('   Total launcher length ........ %.2f m\n', ...
        result.total_length);

fprintf('\n');
fprintf('=========================================================\n');

end