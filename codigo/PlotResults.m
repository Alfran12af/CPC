function PlotResults(sol)
% PLOTRESULTS Generates preliminary launcher figures
%
% INPUT:
%   sol : optimal solution structure

fprintf('\n');
fprintf('==========================================================================\n');
fprintf('                           GENERATING FIGURES                             \n');
fprintf('==========================================================================\n');

%% ------------------------------------------------------------------------
% Delta-V distribution
% -------------------------------------------------------------------------

figure('Name','Delta-V Distribution');

bar(sol.DV);

grid on;
box on;

xlabel('Stage');
ylabel('\DeltaV [m/s]');

title('Launcher Delta-V Distribution');

xticklabels({'Booster','Stage 2','Orbital Stage'});

%% ------------------------------------------------------------------------
% Mass breakdown
% -------------------------------------------------------------------------

figure('Name','Mass Breakdown');

mass_matrix = [
    sol.stage1.m_prop ...
    sol.stage1.m_struct ...
    sol.stage2.mi;

    sol.stage2.m_prop ...
    sol.stage2.m_struct ...
    sol.stage3.mi;

    sol.stage3.m_prop ...
    sol.stage3.m_struct ...
    sol.stage3.payload
];

bar(mass_matrix,'stacked');

grid on;
box on;

xlabel('Stage');
ylabel('Mass [kg]');

title('Launcher Mass Breakdown');

xticklabels({'Booster','Stage 2','Orbital Stage'});

legend( ...
    'Propellant', ...
    'Structure', ...
    'Upper Stage / Payload', ...
    'Location','best');

%% ------------------------------------------------------------------------
% Geometry comparison
% -------------------------------------------------------------------------

figure('Name','Stage Geometry');

geometry_matrix = [
    sol.geom1.D ...
    sol.geom1.total_length ...
    sol.geom1.aspect_ratio;

    sol.geom2.D ...
    sol.geom2.total_length ...
    sol.geom2.aspect_ratio;

    sol.geom3.D ...
    sol.geom3.total_length ...
    sol.geom3.aspect_ratio
];

subplot(3,1,1)

bar(geometry_matrix(:,1));

grid on;
box on;

ylabel('Diameter [m]');

title('Stage Diameters');

xticklabels({'S1','S2','S3'});

subplot(3,1,2)

bar(geometry_matrix(:,2));

grid on;
box on;

ylabel('Length [m]');

title('Stage Lengths');

xticklabels({'S1','S2','S3'});

subplot(3,1,3)

bar(geometry_matrix(:,3));

grid on;
box on;

ylabel('Aspect Ratio [-]');

title('Stage Aspect Ratios');

xticklabels({'S1','S2','S3'});

%% ------------------------------------------------------------------------
% Launcher side view
% -------------------------------------------------------------------------

figure('Name','Launcher Geometry');

hold on;

axis equal;
grid on;
box on;

title('Preliminary Launcher Geometry');

xlabel('Radius [m]');
ylabel('Height [m]');

D1 = sol.geom1.D;
D2 = sol.geom2.D;
D3 = sol.geom3.D;

L1 = sol.geom1.total_length;
L2 = sol.geom2.total_length;
L3 = sol.geom3.total_length;

y1 = 0;
y2 = L1;
y3 = L1 + L2;

%% Booster

rectangle( ...
    'Position',[-D1/2 y1 D1 L1], ...
    'FaceColor',[0.8 0.2 0.2]);

%% Stage 2

rectangle( ...
    'Position',[-D2/2 y2 D2 L2], ...
    'FaceColor',[0.2 0.6 0.8]);

%% Orbital stage

rectangle( ...
    'Position',[-D3/2 y3 D3 L3], ...
    'FaceColor',[0.2 0.8 0.4]);

%% Fairing

fairing_length = 1.5 * D3;

y4 = L1 + L2 + L3;

fairing_x = [-D3/2 0 D3/2];
fairing_y = [y4 y4 + fairing_length y4];

fill( ...
    fairing_x, ...
    fairing_y, ...
    [0.7 0.7 0.7]);

%% Labels

text(0, L1/2, ...
    'Booster', ...
    'HorizontalAlignment','center');

text(0, L1 + L2/2, ...
    'Stage 2', ...
    'HorizontalAlignment','center');

text(0, L1 + L2 + L3/2, ...
    'Orbital Stage', ...
    'HorizontalAlignment','center');

ylim([0 y4 + fairing_length + 1]);

xlim([-D1 D1]);

hold off;

%% ------------------------------------------------------------------------
% Propulsion performance
% -------------------------------------------------------------------------

figure('Name','Propulsion Performance');

subplot(2,1,1)

bar(sol.Isp);

grid on;
box on;

ylabel('Isp [s]');

title('Stage Specific Impulse');

xticklabels({'S1','S2','S3'});

subplot(2,1,2)

bar(sol.mr);

grid on;
box on;

ylabel('Mass Ratio [-]');

title('Stage Mass Ratios');

xticklabels({'S1','S2','S3'});

fprintf('   Figure generation status ........... COMPLETED\n');

fprintf('\n');
fprintf('==========================================================================\n');

end