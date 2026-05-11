function PlotResults(sol)
% PLOTRESULTS Generates preliminary launcher plots
%
% INPUT:
%   sol : optimal launcher solution
%
% DESCRIPTION:
%
%   Generates:
%
%   1) Delta-V distribution
%   2) Mass breakdown
%   3) Stage geometry comparison
%   4) Launcher side view
%
% ==========================================================

fprintf('\nGenerating plots...\n');

%% =========================================================
%% 1. DELTA-V DISTRIBUTION
%% =========================================================

figure('Name','Delta-V Distribution');

bar(sol.DV);

grid on;

xlabel('Stage');

ylabel('\DeltaV [m/s]');

title('Launcher Delta-V Distribution');

xticklabels({'Stage 1','Stage 2','Stage 3'});

%% =========================================================
%% 2. MASS BREAKDOWN
%% =========================================================

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

xlabel('Stage');

ylabel('Mass [kg]');

title('Launcher Mass Breakdown');

xticklabels({'Stage 1','Stage 2','Stage 3'});

legend( ...
    'Propellant', ...
    'Structure', ...
    'Upper Stage / Payload', ...
    'Location','best');

%% =========================================================
%% 3. STAGE GEOMETRY COMPARISON
%% =========================================================

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

ylabel('Diameter [m]');

title('Stage Diameters');

xticklabels({'S1','S2','S3'});

subplot(3,1,2)

bar(geometry_matrix(:,2));

grid on;

ylabel('Length [m]');

title('Stage Lengths');

xticklabels({'S1','S2','S3'});

subplot(3,1,3)

bar(geometry_matrix(:,3));

grid on;

ylabel('L/D');

title('Stage Aspect Ratios');

xticklabels({'S1','S2','S3'});

%% =========================================================
%% 4. VERTICAL LAUNCHER VIEW
%% =========================================================

figure('Name','Launcher Geometry');

hold on;
axis equal;
grid on;

title('Preliminary Launcher Geometry');

xlabel('Radius [m]');

ylabel('Height [m]');

%% =========================================================
%% STAGE DATA
%% =========================================================

D1 = sol.geom1.D;
D2 = sol.geom2.D;
D3 = sol.geom3.D;

L1 = sol.geom1.total_length;
L2 = sol.geom2.total_length;
L3 = sol.geom3.total_length;

%% =========================================================
%% STAGE 1
%% =========================================================

y1 = 0;

rectangle( ...
    'Position', ...
    [-D1/2 y1 D1 L1], ...
    'FaceColor',[0.8 0.2 0.2]);

%% =========================================================
%% STAGE 2
%% =========================================================

y2 = L1;

rectangle( ...
    'Position', ...
    [-D2/2 y2 D2 L2], ...
    'FaceColor',[0.2 0.6 0.8]);

%% =========================================================
%% STAGE 3
%% =========================================================

y3 = L1 + L2;

rectangle( ...
    'Position', ...
    [-D3/2 y3 D3 L3], ...
    'FaceColor',[0.2 0.8 0.4]);

%% =========================================================
%% FAIRING
%% =========================================================

fairing_length = 1.5 * D3;

y4 = L1 + L2 + L3;

fairing_x = [-D3/2 0 D3/2];

fairing_y = [y4 y4+fairing_length y4];

fill(fairing_x, ...
     fairing_y, ...
     [0.7 0.7 0.7]);

%% =========================================================
%% LABELS
%% =========================================================

text(0,L1/2,'Stage 1', ...
    'HorizontalAlignment','center');

text(0,L1 + L2/2,'Stage 2', ...
    'HorizontalAlignment','center');

text(0,L1 + L2 + L3/2,'Stage 3', ...
    'HorizontalAlignment','center');

%% =========================================================
%% LIMITS
%% =========================================================

ylim([0 y4 + fairing_length + 1]);

xlim([-D1 D1]);

hold off;

%% =========================================================
%% 5. PROPULSION PERFORMANCE
%% =========================================================

figure('Name','Propulsion Performance');

subplot(2,1,1)

bar(sol.Isp);

grid on;

ylabel('Isp [s]');

title('Specific Impulse');

xticklabels({'S1','S2','S3'});

subplot(2,1,2)

bar(sol.mr);

grid on;

ylabel('Mass Ratio');

title('Stage Mass Ratios');

xticklabels({'S1','S2','S3'});

fprintf('Plots generated successfully.\n');

end