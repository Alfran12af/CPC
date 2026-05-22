function candidates = GenerateCandidates( ...
                    mission, ...
                    architecture, ...
                    params)
% GENERATECANDIDATES Generates launcher design candidates
%
% INPUTS:
%   mission      : mission data
%   architecture : launcher architecture
%   params       : optimization parameters
%
% OUTPUT:
%   candidates   : candidate configuration array

fprintf('\n');
fprintf('==========================================================================\n');
fprintf('                     GENERATING DESIGN SPACE                              \n');
fprintf('==========================================================================\n');

%% Initialization

counter = 0;

candidates = [];

%% Mission Delta-V

DV3 = mission.DV_insertion;

DV_ascent = mission.DV_ascent;

%% Propellant databases

stage1_candidates = ...
    architecture.stage(1).candidates;

stage2_candidates = ...
    architecture.stage(2).candidates;

stage3_candidates = ...
    architecture.stage(3).candidates;

%% Structural fraction ranges

eps1_range = ...
    architecture.stage(1).epsilon_range;

eps2_range = ...
    architecture.stage(2).epsilon_range;

eps3_range = ...
    architecture.stage(3).epsilon_range;

%% Delta-V distribution loop

for f1 = params.frac1_range

    % Remaining ascent fraction
    f2 = 1 - f1;

    if f2 <= 0
        continue;
    end

    %% Stage Delta-V allocation

    DV1 = f1 * DV_ascent;

    DV2 = f2 * DV_ascent;

    DV = [DV1 DV2 DV3];

    %% Stage 1

    for i = 1:length(stage1_candidates)

        prop1 = ...
            PropellantData(stage1_candidates{i});

        if ~CheckMotorCompatibility( ...
                architecture.stage(1).motor, ...
                prop1)

            continue;

        end

        %% Stage 2

        for j = 1:length(stage2_candidates)

            prop2 = ...
                PropellantData(stage2_candidates{j});

            if ~CheckMotorCompatibility( ...
                    architecture.stage(2).motor, ...
                    prop2)

                continue;

            end

            %% Stage 3

            for k = 1:length(stage3_candidates)

                prop3 = ...
                    PropellantData(stage3_candidates{k});

                if ~CheckMotorCompatibility( ...
                        architecture.stage(3).motor, ...
                        prop3)

                    continue;

                end

                %% Structural fractions

                for e1 = 1:length(eps1_range)

                    eps1 = eps1_range(e1);

                    for e2 = 1:length(eps2_range)

                        eps2 = eps2_range(e2);

                        for e3 = 1:length(eps3_range)

                            eps3 = eps3_range(e3);

                            %% Store candidate

                            counter = counter + 1;

                            candidates(counter).DV = DV;

                            candidates(counter).f1 = f1;

                            candidates(counter).f2 = f2;

                            candidates(counter).f3 = ...
                                DV3 / (DV_ascent + DV3);

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

%% Design space summary

fprintf('\n');
fprintf('DESIGN SPACE SUMMARY\n');
fprintf('--------------------------------------------------------------------------\n');

fprintf('   Total candidate configurations .... %d\n', ...
    counter);

fprintf('\n');
fprintf('DELTA-V DISTRIBUTION\n');
fprintf('--------------------------------------------------------------------------\n');

fprintf('   Stage 1 ascent fraction ........... %.2f - %.2f\n', ...
    min(params.frac1_range), ...
    max(params.frac1_range));

fprintf('   Fixed insertion Delta-V ........... %.2f m/s\n', ...
    DV3);

fprintf('\n');
fprintf('PROPULSION COMBINATIONS\n');
fprintf('--------------------------------------------------------------------------\n');

fprintf('   Stage 1 candidates ................ %d\n', ...
    length(stage1_candidates));

fprintf('   Stage 2 candidates ................ %d\n', ...
    length(stage2_candidates));

fprintf('   Stage 3 candidates ................ %d\n', ...
    length(stage3_candidates));

fprintf('\n');
fprintf('STRUCTURAL FRACTION RANGES\n');
fprintf('--------------------------------------------------------------------------\n');

fprintf('   epsilon_1 ......................... %.2f - %.2f\n', ...
    min(eps1_range), ...
    max(eps1_range));

fprintf('   epsilon_2 ......................... %.2f - %.2f\n', ...
    min(eps2_range), ...
    max(eps2_range));

fprintf('   epsilon_3 ......................... %.2f - %.2f\n', ...
    min(eps3_range), ...
    max(eps3_range));

fprintf('\n');
fprintf('==========================================================================\n');

end