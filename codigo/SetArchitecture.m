function architecture = SetArchitecture()
% SETARCHITECTURE Launcher architecture definition
%
% OUTPUT:
%   architecture : launcher architecture structure

%% Global configuration

architecture.n_stages = 3;

architecture.type = ...
    'Two-stage launcher with orbital insertion stage';

%% Stage 1

architecture.stage(1).name = 'Stage 1';

architecture.stage(1).motor = 'solid';

architecture.stage(1).environment = ...
    'sea_level';

architecture.stage(1).epsilon_range = ...
    linspace(0.10, 0.15, 5);

architecture.stage(1).candidates = ...
{
    'HTPB_AN_Al'
};

%% Stage 2

architecture.stage(2).name = 'Stage 2';

architecture.stage(2).motor = ...
    'pressure-fed';

architecture.stage(2).environment = ...
    'mixed';

architecture.stage(2).epsilon_range = ...
    linspace(0.15, 0.2, 5);

architecture.stage(2).candidates = ...
{
    'LOX_RP1_2',
    'LOX_CH4_2',
    'N2O4_MMH',
    'N2O4_UH25'
};

%% Stage 3

architecture.stage(3).name = 'Stage 3';

architecture.stage(3).motor = ...
    'pump-fed';

architecture.stage(3).environment = ...
    'vacuum';

architecture.stage(3).epsilon_range = ...
    linspace(0.12, 0.18, 5);

architecture.stage(3).candidates = ...
{
    'LOX_RP1_3',
    'LOX_CH4_3',
    'LOX_LH2'
};

%% Global geometric constraints

architecture.max_length = 20;

architecture.max_diameter = 2.0;

architecture.global_slenderness_max = 20;

architecture.diameter_decay_min = 0.40;

%% Payload constraint

architecture.min_payload_fraction = ...
    0.0015;

end