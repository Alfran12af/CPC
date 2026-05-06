function candidates = GenerateCandidates( ...
                    mission, ...
                    architecture, ...
                    params)

% GENERATECANDIDATES Generates launcher design space
%
% INPUTS:
%   mission      : mission structure
%   architecture : launcher architecture
%   params       : optimization parameters
%
% OUTPUT:
%   candidates   : candidate configurations array

%% =========================================================
%% INITIALIZATION
%% =========================================================

counter = 0;

candidates = [];

%% =========================================================
%% DELTA-V DISTRIBUTIONS
%% =========================================================

for f1 = params.frac1_range
    
    for f2 = params.frac2_range
        
        % Remaining fraction
        f3 = 1 - f1 - f2;
        
        % Invalid distribution
        if f3 <= 0
            continue;
        end
        
        %% =================================================
        %% DELTA-V PER STAGE
        %% =================================================
        
        DV = mission.DV_total * [f1 f2 f3];
        
        %% =================================================
        %% PROPELLANT CANDIDATES
        %% =================================================
        
        stage1_candidates = ...
            architecture.stage(1).candidates;
        
        stage2_candidates = ...
            architecture.stage(2).candidates;
        
        stage3_candidates = ...
            architecture.stage(3).candidates;
        
        %% =================================================
        %% EPSILON RANGES
        %% =================================================
        
        eps1_range = ...
            architecture.stage(1).epsilon_range;
        
        eps2_range = ...
            architecture.stage(2).epsilon_range;
        
        eps3_range = ...
            architecture.stage(3).epsilon_range;
        
        %% =================================================
        %% DESIGN SPACE LOOPS
        %% =================================================
        
        for i = 1:length(stage1_candidates)
            
            prop1 = ...
                PropellantData(stage1_candidates{i});
            
            for j = 1:length(stage2_candidates)
                
                prop2 = ...
                    PropellantData(stage2_candidates{j});
                
                for k = 1:length(stage3_candidates)
                    
                    prop3 = ...
                        PropellantData(stage3_candidates{k});
                    
                    %% =====================================
                    %% EPSILON LOOPS
                    %% =====================================
                    
                    for e1 = 1:length(eps1_range)
                        
                        eps1 = eps1_range(e1);
                        
                        for e2 = 1:length(eps2_range)
                            
                            eps2 = eps2_range(e2);
                            
                            for e3 = 1:length(eps3_range)
                                
                                eps3 = eps3_range(e3);
                                
                                %% =============================
                                %% STORE CANDIDATE
                                %% =============================
                                
                                counter = counter + 1;
                                
                                candidates(counter).DV = DV;
                                
                                candidates(counter).prop1 = prop1;
                                candidates(counter).prop2 = prop2;
                                candidates(counter).prop3 = prop3;
                                
                                candidates(counter).eps1 = eps1;
                                candidates(counter).eps2 = eps2;
                                candidates(counter).eps3 = eps3;
                                
                            end
                        end
                    end
                end
            end
        end
        
    end
end

end