function result = OptimizeRocket( ...
    mission, ...
    architecture, ...
    params)

% OPTIMIZEROCKET Finds optimal launcher configuration

%% =========================================================
%% GENERATE DESIGN SPACE
%% =========================================================

candidates = GenerateCandidates( ...
                mission, ...
                architecture, ...
                params);

%% =========================================================
%% INITIALIZATION
%% =========================================================

best.m0 = inf;
best.solution = [];

valid_counter = 0;

%% =========================================================
%% EVALUATE CANDIDATES
%% =========================================================

for i = 1:length(candidates)
    
    candidate = candidates(i);
    
    %% =====================================================
    %% EVALUATE CONFIGURATION
    %% =====================================================
    
    solution = EvaluateConfiguration( ...
                    candidate, ...
                    mission, ...
                    architecture, ...
                    params);
    
    %% =====================================================
    %% STORE BEST
    %% =====================================================
    
    if solution.valid
        
        valid_counter = valid_counter + 1;
        
        if solution.m0 < best.m0
            
            best.m0 = solution.m0;
            best.solution = solution;
            
        end
        
    end
    
end

%% =========================================================
%% OUTPUT
%% =========================================================

result = best.solution;

if params.verbose
    
    fprintf('\nValid configurations: %d\n', ...
            valid_counter);
    
end

end