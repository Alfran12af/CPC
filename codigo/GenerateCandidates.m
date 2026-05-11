function candidates = GenerateCandidates( ...
                    mission, ...
                    architecture, ...
                    params)
% GENERATECANDIDATES Generates launcher design space
%
% INPUTS:
%   mission      : mission structure
%   architecture : launcher architecture
%   params       : optimization settings
%
% OUTPUT:
%   candidates   : candidate configurations
%
% DESCRIPTION:
%
%   Generates all valid combinations of:
%
%   - Delta-V distributions
%   - Propellant selections
%   - Structural fractions
%
%   respecting:
%
%   - fixed launcher architecture
%   - propulsion compatibility
%
% ==========================================================

fprintf('\\n');
fprintf('----------- GENERATING CANDIDATES -----------\\n');

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

        %% -------------------------------------------------
        %% REMAINING FRACTION
        %% -------------------------------------------------

        f3 = 1 - f1 - f2;

        %% -------------------------------------------------
        %% INVALID DISTRIBUTION
        %% -------------------------------------------------

        if f3 <= 0

            continue;

        end

        %% -------------------------------------------------
        %% DELTA-V PER STAGE
        %% -------------------------------------------------

        DV = mission.DV_total * [f1 f2 f3];

        %% =================================================
        %% PROPELLANT DATABASES
        %% =================================================

        stage1_candidates = ...
            architecture.stage(1).candidates;

        stage2_candidates = ...
            architecture.stage(2).candidates;

        stage3_candidates = ...
            architecture.stage(3).candidates;

        %% =================================================
        %% STRUCTURAL FRACTIONS
        %% =================================================

        eps1_range = ...
            architecture.stage(1).epsilon_range;

        eps2_range = ...
            architecture.stage(2).epsilon_range;

        eps3_range = ...
            architecture.stage(3).epsilon_range;

        %% =================================================
        %% STAGE 1 LOOP
        %% =================================================

        for i = 1:length(stage1_candidates)

            %% ---------------------------------------------
            %% LOAD PROPELLANT
            %% ---------------------------------------------

            prop1 = ...
                PropellantData(stage1_candidates{i});

            %% ---------------------------------------------
            %% CHECK COMPATIBILITY
            %% ---------------------------------------------

            if ~CheckMotorCompatibility( ...
                    architecture.stage(1).motor, ...
                    prop1)

                continue;

            end

            %% =================================================
            %% STAGE 2 LOOP
            %% =================================================

            for j = 1:length(stage2_candidates)

                prop2 = ...
                    PropellantData(stage2_candidates{j});

                %% ---------------------------------------------
                %% CHECK COMPATIBILITY
                %% ---------------------------------------------

                if ~CheckMotorCompatibility( ...
                        architecture.stage(2).motor, ...
                        prop2)

                    continue;

                end

                %% =================================================
                %% STAGE 3 LOOP
                %% =================================================

                for k = 1:length(stage3_candidates)

                    prop3 = ...
                        PropellantData(stage3_candidates{k});

                    %% ---------------------------------------------
                    %% CHECK COMPATIBILITY
                    %% ---------------------------------------------

                    if ~CheckMotorCompatibility( ...
                            architecture.stage(3).motor, ...
                            prop3)

                        continue;

                    end

                    %% =============================================
                    %% EPSILON LOOPS
                    %% =============================================

                    for e1 = 1:length(eps1_range)

                        eps1 = eps1_range(e1);

                        for e2 = 1:length(eps2_range)

                            eps2 = eps2_range(e2);

                            for e3 = 1:length(eps3_range)

                                eps3 = eps3_range(e3);

                                %% =====================================
                                %% STORE CANDIDATE
                                %% =====================================

                                counter = counter + 1;

                                candidates(counter).DV = DV;

                                %% -------------------------------------
                                %% PROPELLANTS
                                %% -------------------------------------

                                candidates(counter).prop1 = prop1;

                                candidates(counter).prop2 = prop2;

                                candidates(counter).prop3 = prop3;

                                %% -------------------------------------
                                %% STRUCTURAL FRACTIONS
                                %% -------------------------------------

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

%% =========================================================
%% DISPLAY SUMMARY
%% =========================================================

fprintf('Valid candidates generated : %d\\n', ...
        counter);

end