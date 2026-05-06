%% solid_motor_star_neutral.m
% Dimensionament preliminar d'un motor coet solid
% Geometria estrella idealitzada per empenta quasi constant
%
% Model:
%   - Propergol solid no toxic preliminar: AN / polymer
%   - Gra estrella amb extrems inhibitis
%   - Area de combustio imposada aproximadament constant: Ab(t) = constant
%   - Llei de Vieille: rb = a * Pc^n
%   - Cabal generat: mdot = Ab * rho_p * rb
%   - Cabal evacuat: mdot = Pc * At / cstar
%   - KN = Ab / At
%
% Aquest codi serveix per a disseny conceptual/preliminar.
% No es valid per fabricar ni assajar motors reals.

clear; clc; close all;

%% ============================================================
%  1. CONSTANTS
% ============================================================

g0 = 9.80665;              % [m/s^2]
Pc_limit = 50e6;           % [Pa] limit de l'enunciat

%% ============================================================
%  2. DADES DEL PROPERGOL
% ============================================================
% Cas base: AN / polymer, sense alumini i sense clor.
% Valors preliminars. Cal substituir-los per resultats RPA/CEA/ProPEP
% o per dades bibliografiques definitives.

prop.name     = "AN_polymer_non_toxic";

prop.Isp      = 190;          % [s] impuls especific preliminar
prop.cstar    = 1205;         % [m/s] velocitat caracteristica
prop.rho      = 1510;         % [kg/m^3] densitat del gra
prop.n        = 0.37;         % [-] exponent de pressio

% Punt de referencia de la llei de combustio:
% rb = a * Pc^n
prop.Pc_ref   = 6.89e6;       % [Pa]
prop.rb_ref   = 2.1e-3;       % [m/s] 2.1 mm/s

prop.a_std = prop.rb_ref / prop.Pc_ref^prop.n;

% Correccio opcional per temperatura inicial del gra:
% a(T) = a_std * exp(tau*(Tgrain - Tstd))
% Si no disposeu de tau, deixar tau = 0.
prop.Tstd   = 294.15;         % [K]
prop.Tgrain = 294.15;         % [K]
prop.tau    = 0.0;            % [1/K]
prop.aT     = prop.a_std * exp(prop.tau * (prop.Tgrain - prop.Tstd));

%% ============================================================
%  3. DADES DE MISSIO / ETAPA
% ============================================================
% mUpper = massa que queda per sobre de la primera etapa:
% etapa 2 + etapa 3 + carrega util + adaptadors.

stage.massMode = "fromDeltaV";      % "fromDeltaV" o "fixedPropMass"

stage.mUpper   = 861;               % [kg]
stage.DeltaV1  = 2800;              % [m/s]
stage.dryFrac  = 0.15;              % [-]

% Nomes s'utilitza si stage.massMode = "fixedPropMass"
stage.mPropFixed = 7850;            % [kg]

stage = size_stage(stage, prop, g0);

%% ============================================================
%  4. EMPENTA I TEMPS DE COMBUSTIO
% ============================================================
% thrustMode:
%   "TW0"      -> fixa T/W inicial
%   "Favg"     -> fixa empenta mitjana
%   "burnTime" -> fixa temps de combustio

perf.thrustMode = "TW0";

perf.TW0        = 2.0;          % [-]
perf.FavgInput  = 200e3;        % [N]
perf.tbInput    = 75;           % [s]

perf.PcTarget   = 6.89e6;       % [Pa]
perf.epsNozzle  = 8.0;          % [-] Ae/At preliminar
perf.Pa         = 101325;       % [Pa]

perf = size_performance(perf, stage, prop, g0);

%% ============================================================
%  5. TOVERA
% ============================================================

noz = size_nozzle(perf, prop, g0);

%% ============================================================
%  6. BALISTICA INTERNA OBJECTIU
% ============================================================

ball = size_ballistics(perf, noz, prop);

%% ============================================================
%  7. GEOMETRIA D'ESTRELLA NEUTRA
% ============================================================
% La geometria es calcula per obtenir:
%   - volum de propergol correcte
%   - area inicial de port coherent amb volumetric loading
%   - perimetre inicial aproximat equivalent a Ab/L
%
% Nstar alt ajuda a obtenir molta area de combustio amb AN, que crema lent.
% Per al cas AN/polymer pot caldre Nstar = 10-14.

geom.model = "starNeutral";

geom.Nstar = 12;                 % [-] nombre de puntes de l'estrella
geom.Lgrain = 5.8;               % [m] longitud del gra
geom.volLoadingTarget = 0.85;    % [-] Vprop/Vcase

geom = size_star_neutral_geometry(geom, stage, prop, ball, noz);

%% ============================================================
%  8. SIMULACIO IDEAL D'EMPENTA CONSTANT
% ============================================================

sim.dt = 0.05;                   % [s]
sim = simulate_star_neutral(stage, prop, perf, noz, ball, geom, sim);

%% ============================================================
%  9. RESULTATS
% ============================================================

print_results(stage, prop, perf, noz, ball, geom, sim, Pc_limit);

%% ============================================================
%  10. GRAFIQUES
% ============================================================

plot_results(sim);
plot_star_geometry(geom);

%% ============================================================
%  FUNCIONS LOCALS
% ============================================================

function stage = size_stage(stage, prop, g0)

    switch char(stage.massMode)

        case 'fromDeltaV'

            R = exp(stage.DeltaV1 / (prop.Isp * g0));
            denom = 1 - R * stage.dryFrac;

            if denom <= 0
                error(['No es pot tancar la massa de l''etapa. ', ...
                       'Reduiu DeltaV, augmenteu Isp o reduiu dryFrac.']);
            end

            stage.massRatio = R;
            stage.mStage = stage.mUpper * (R - 1) / denom;
            stage.mDry   = stage.dryFrac * stage.mStage;
            stage.mProp  = (1 - stage.dryFrac) * stage.mStage;
            stage.m0     = stage.mUpper + stage.mStage;
            stage.mfBurn = stage.mUpper + stage.mDry;

        case 'fixedPropMass'

            stage.mProp = stage.mPropFixed;
            stage.mStage = stage.mProp / (1 - stage.dryFrac);
            stage.mDry = stage.dryFrac * stage.mStage;
            stage.m0 = stage.mUpper + stage.mStage;
            stage.mfBurn = stage.mUpper + stage.mDry;
            stage.massRatio = stage.m0 / stage.mfBurn;
            stage.DeltaV1 = prop.Isp * g0 * log(stage.massRatio);

        otherwise

            error('stage.massMode ha de ser "fromDeltaV" o "fixedPropMass".');

    end

    stage.W0 = stage.m0 * g0;

end

function perf = size_performance(perf, stage, prop, g0)

    switch char(perf.thrustMode)

        case 'TW0'

            perf.Favg = perf.TW0 * stage.W0;
            perf.mdot = perf.Favg / (prop.Isp * g0);
            perf.tb   = stage.mProp / perf.mdot;

        case 'Favg'

            perf.Favg = perf.FavgInput;
            perf.mdot = perf.Favg / (prop.Isp * g0);
            perf.tb   = stage.mProp / perf.mdot;
            perf.TW0  = perf.Favg / stage.W0;

        case 'burnTime'

            perf.tb   = perf.tbInput;
            perf.mdot = stage.mProp / perf.tb;
            perf.Favg = perf.mdot * prop.Isp * g0;
            perf.TW0  = perf.Favg / stage.W0;

        otherwise

            error('perf.thrustMode ha de ser "TW0", "Favg" o "burnTime".');

    end

    perf.Itotal = stage.mProp * prop.Isp * g0;

end

function noz = size_nozzle(perf, prop, g0)

    noz.At = perf.mdot * prop.cstar / perf.PcTarget;  % [m^2]
    noz.dt = sqrt(4 * noz.At / pi);                   % [m]

    noz.eps = perf.epsNozzle;
    noz.Ae = noz.eps * noz.At;                        % [m^2]
    noz.de = sqrt(4 * noz.Ae / pi);                   % [m]

    % Isp*g0 = Cf*cstar
    noz.Cf_equiv = prop.Isp * g0 / prop.cstar;

    noz.F_from_Cf = noz.Cf_equiv * perf.PcTarget * noz.At;

end

function ball = size_ballistics(perf, noz, prop)

    % Velocitat de regressio a la pressio objectiu
    ball.rbTarget = prop.aT * perf.PcTarget^prop.n;

    % Area de combustio necessaria per al cabal objectiu
    ball.AbReq = perf.mdot / (prop.rho * ball.rbTarget);

    % Perimetre intern necessari si els extrems estan inhibitis
    % Ab = Pport * Lgrain
    ball.KN = ball.AbReq / noz.At;

    % Pressio d'equilibri obtinguda a partir de KN
    ball.PcEq = (prop.aT * prop.rho * prop.cstar * ball.KN)^(1/(1 - prop.n));

end

function geom = size_star_neutral_geometry(geom, stage, prop, ball, noz)

    geom.Vprop = stage.mProp / prop.rho;

    geom.Vcase = geom.Vprop / geom.volLoadingTarget;
    geom.Acase = geom.Vcase / geom.Lgrain;

    geom.Rcase = sqrt(geom.Acase / pi);
    geom.Dcase = 2 * geom.Rcase;

    geom.Aport0 = geom.Acase - geom.Vprop / geom.Lgrain;

    if geom.Aport0 <= 0
        error('Aport0 <= 0. Reduiu volLoadingTarget o augmenteu Lgrain.');
    end

    geom.Ptarget = ball.AbReq / geom.Lgrain;

    [geom.rOuter, geom.rInner, geom.Ppolygon, geom.Apolygon, geom.errP] = ...
        solve_star_from_area_perimeter(geom.Aport0, geom.Ptarget, geom.Nstar);

    geom.AbInitial = geom.Ppolygon * geom.Lgrain;
    geom.KNInitial = geom.AbInitial / noz.At;

    % Web ideal si Ab es mantingues constant:
    % Vprop = Ab * web
    geom.webNeutral = geom.Vprop / ball.AbReq;

    % Marge aproximat fins que les puntes arriben a la carcassa
    geom.marginTipToWall = geom.Rcase - geom.rOuter;

    % Relacio entre area inicial del port i area de gola.
    % Convindria que fos suficientment superior a 1 per evitar bloqueig
    % o perdues excessives al port.
    geom.portToThroat = geom.Aport0 / noz.At;

    if geom.rOuter >= geom.Rcase
        warning('La punta de l''estrella queda fora de la carcassa. Ajusteu Nstar, Lgrain o volLoading.');
    end

end

function [rOuter, rInner, Pbest, Abest, errP] = solve_star_from_area_perimeter(A0, Ptarget, N)

    % Estrella regular simplificada amb 2N vertexs alternant:
    % rOuter, rInner, rOuter, rInner...
    %
    % Area exacta del poligon:
    % A = N * rOuter * rInner * sin(pi/N)
    %
    % Perimetre:
    % P = 2N * sqrt(rOuter^2 + rInner^2 - 2*rOuter*rInner*cos(pi/N))
    %
    % Es resol el ratio k = rInner/rOuter per ajustar el perimetre.

    theta = pi / N;
    s = sin(theta);
    c = cos(theta);

    P_of_k = @(k) 2*N * sqrt(A0/(N*k*s)) .* ...
        sqrt(1 + k.^2 - 2*k*c);

    objective = @(k) (P_of_k(k) - Ptarget).^2;

    kBest = fminbnd(objective, 0.03, 0.97);

    rOuter = sqrt(A0 / (N*kBest*s));
    rInner = kBest * rOuter;

    Pbest = P_of_k(kBest);
    Abest = N * rOuter * rInner * s;

    errP = (Pbest - Ptarget) / Ptarget;

end

function sim = simulate_star_neutral(stage, prop, perf, noz, ball, geom, sim)

    sim.t = 0:sim.dt:perf.tb;

    Nt = length(sim.t);

    sim.Ab = ones(1,Nt) * ball.AbReq;
    sim.KN = sim.Ab / noz.At;

    sim.Pc = ones(1,Nt) * perf.PcTarget;
    sim.rb = ones(1,Nt) * ball.rbTarget;

    sim.mdot = ones(1,Nt) * perf.mdot;
    sim.F = ones(1,Nt) * perf.Favg;

    sim.mBurned = sim.mdot .* sim.t;
    sim.mBurned(sim.mBurned > stage.mProp) = stage.mProp;

    sim.web = sim.rb .* sim.t;
    sim.web(sim.web > geom.webNeutral) = geom.webNeutral;

    sim.tb = sim.t(end);
    sim.Itotal = trapz(sim.t, sim.F);
    sim.Favg = sim.Itotal / sim.tb;

    sim.PcAvg = trapz(sim.t, sim.Pc) / sim.tb;
    sim.PcMax = max(sim.Pc);

    sim.mdotAvg = trapz(sim.t, sim.mdot) / sim.tb;
    sim.rbAvg = trapz(sim.t, sim.rb) / sim.tb;

end

function print_results(stage, prop, perf, noz, ball, geom, sim, Pc_limit)

    fprintf('\n============================================================\n');
    fprintf(' DIMENSIONAMENT PRELIMINAR MOTOR SOLID - GRA ESTRELLA\n');
    fprintf('============================================================\n');

    fprintf('\n--- PROPERGOL ---\n');
    fprintf('Nom                                  : %s\n', char(prop.name));
    fprintf('Isp                                  : %.1f s\n', prop.Isp);
    fprintf('cstar                                : %.1f m/s\n', prop.cstar);
    fprintf('rho_p                                : %.1f kg/m3\n', prop.rho);
    fprintf('n                                    : %.3f\n', prop.n);
    fprintf('a(T)                                 : %.4e SI\n', prop.aT);
    fprintf('rb(Pc target)                        : %.3f mm/s\n', ball.rbTarget*1000);

    fprintf('\n--- ETAPA ---\n');
    fprintf('mUpper                               : %.1f kg\n', stage.mUpper);
    fprintf('DeltaV etapa 1                       : %.1f m/s\n', stage.DeltaV1);
    fprintf('Mass ratio                           : %.3f\n', stage.massRatio);
    fprintf('Massa total etapa                    : %.1f kg\n', stage.mStage);
    fprintf('Massa propergol                      : %.1f kg\n', stage.mProp);
    fprintf('Massa seca                           : %.1f kg\n', stage.mDry);
    fprintf('Massa inicial vehicle                : %.1f kg\n', stage.m0);
    fprintf('Pes inicial                          : %.1f kN\n', stage.W0/1000);

    fprintf('\n--- EMPENTA OBJECTIU ---\n');
    fprintf('T/W inicial                          : %.2f\n', perf.TW0);
    fprintf('Empenta mitjana                      : %.1f kN\n', perf.Favg/1000);
    fprintf('Cabal massic                         : %.2f kg/s\n', perf.mdot);
    fprintf('Temps combustio                      : %.2f s\n', perf.tb);
    fprintf('Impuls total                         : %.2f MN*s\n', perf.Itotal/1e6);

    fprintf('\n--- TOVERA ---\n');
    fprintf('Pc target                            : %.2f MPa\n', perf.PcTarget/1e6);
    fprintf('At gola                              : %.5f m2\n', noz.At);
    fprintf('Diametre gola                        : %.1f mm\n', noz.dt*1000);
    fprintf('Relacio expansio Ae/At               : %.2f\n', noz.eps);
    fprintf('Ae sortida                           : %.5f m2\n', noz.Ae);
    fprintf('Diametre sortida                     : %.1f mm\n', noz.de*1000);
    fprintf('Cf equivalent                        : %.3f\n', noz.Cf_equiv);

    fprintf('\n--- BALISTICA INTERNA ---\n');
    fprintf('Area combustio requerida Ab          : %.2f m2\n', ball.AbReq);
    fprintf('Perimetre intern requerit            : %.2f m\n', geom.Ptarget);
    fprintf('KN = Ab/At                           : %.1f\n', ball.KN);
    fprintf('Pc equilibri amb KN                  : %.2f MPa\n', ball.PcEq/1e6);

    fprintf('\n--- GEOMETRIA ESTRELLA ---\n');
    fprintf('Nombre de puntes                     : %.0f\n', geom.Nstar);
    fprintf('Longitud gra                         : %.2f m\n', geom.Lgrain);
    fprintf('Volum propergol                      : %.2f m3\n', geom.Vprop);
    fprintf('Volum intern carcassa                : %.2f m3\n', geom.Vcase);
    fprintf('Volumetric loading                   : %.3f\n', geom.volLoadingTarget);
    fprintf('Diametre carcassa equivalent         : %.2f m\n', geom.Dcase);
    fprintf('Radi exterior puntes estrella        : %.3f m\n', geom.rOuter);
    fprintf('Radi interior valls estrella         : %.3f m\n', geom.rInner);
    fprintf('Area port inicial                    : %.3f m2\n', geom.Aport0);
    fprintf('Perimetre poligon estrella           : %.3f m\n', geom.Ppolygon);
    fprintf('Error perimetre respecte objectiu    : %.2f %%\n', 100*geom.errP);
    fprintf('Aport0/At                            : %.1f\n', geom.portToThroat);
    fprintf('Web neutral necessari                : %.3f m\n', geom.webNeutral);
    fprintf('Marge punta-paret                    : %.3f m\n', geom.marginTipToWall);

    fprintf('\n--- SIMULACIO IDEAL NEUTRA ---\n');
    fprintf('Temps combustio simulat              : %.2f s\n', sim.tb);
    fprintf('Empenta mitjana simulada             : %.1f kN\n', sim.Favg/1000);
    fprintf('Impuls total simulat                 : %.2f MN*s\n', sim.Itotal/1e6);
    fprintf('Pc mitjana simulada                  : %.2f MPa\n', sim.PcAvg/1e6);
    fprintf('Pc maxima simulada                   : %.2f MPa\n', sim.PcMax/1e6);
    fprintf('Cabal mitja simulat                  : %.2f kg/s\n', sim.mdotAvg);
    fprintf('rb mitjana simulada                  : %.3f mm/s\n', sim.rbAvg*1000);

    fprintf('\n--- AVISOS DE DISSENY ---\n');

    if prop.n >= 1
        fprintf('AVIS: n >= 1. Combustio potencialment inestable.\n');
    else
        fprintf('OK: n < 1. Model estable respecte a pressio segons Vieille.\n');
    end

    if perf.PcTarget >= Pc_limit
        fprintf('AVIS: Pc target supera o iguala 50 MPa.\n');
    else
        fprintf('OK: Pc target inferior a 50 MPa.\n');
    end

    if geom.errP > 0.05
        fprintf('AVIS: el perimetre de l''estrella no ajusta be Ab requerida.\n');
    else
        fprintf('OK: perimetre de l''estrella coherent amb Ab requerida.\n');
    end

    if geom.webNeutral > geom.marginTipToWall
        fprintf(['AVIS: el web neutral necessari supera el marge punta-paret.\n', ...
                 '      Cal augmentar Nstar, augmentar diametre, reduir volumetric loading,\n', ...
                 '      augmentar longitud o redissenyar el gra com finocyl.\n']);
    else
        fprintf('OK: marge punta-paret superior al web neutral necessari.\n');
    end

    if geom.portToThroat < 2.0
        fprintf('AVIS: Aport0/At baix. Pot haver-hi perdues o bloqueig al port.\n');
    else
        fprintf('OK: Aport0/At suficient com a primera estimacio.\n');
    end

    fprintf('\n============================================================\n\n');

end

function plot_results(sim)

    figure;
    plot(sim.t, sim.F/1000, 'LineWidth', 1.5);
    grid on;
    xlabel('Temps [s]');
    ylabel('Empenta [kN]');
    title('Llei d''empenta ideal - gra estrella neutral');

    figure;
    plot(sim.t, sim.Pc/1e6, 'LineWidth', 1.5);
    grid on;
    xlabel('Temps [s]');
    ylabel('P_c [MPa]');
    title('Pressio de cambra');

    figure;
    plot(sim.t, sim.Ab, 'LineWidth', 1.5);
    grid on;
    xlabel('Temps [s]');
    ylabel('A_b [m^2]');
    title('Area de combustio imposada constant');

    figure;
    plot(sim.t, sim.web*1000, 'LineWidth', 1.5);
    grid on;
    xlabel('Temps [s]');
    ylabel('Web consumit [mm]');
    title('Avanc del front de combustio');

end

function plot_star_geometry(geom)

    N = geom.Nstar;

    theta = linspace(0, 2*pi, 2*N + 1);
    theta(end) = [];

    r = zeros(size(theta));

    for i = 1:length(theta)
        if mod(i,2) == 1
            r(i) = geom.rOuter;
        else
            r(i) = geom.rInner;
        end
    end

    x = r .* cos(theta);
    y = r .* sin(theta);

    th = linspace(0, 2*pi, 400);
    xc = geom.Rcase * cos(th);
    yc = geom.Rcase * sin(th);

    figure;
    hold on;
    fill(x, y, [0.85 0.85 0.85], 'EdgeColor', 'k', 'LineWidth', 1.5);
    plot(xc, yc, 'k--', 'LineWidth', 1.2);
    axis equal;
    grid on;
    xlabel('x [m]');
    ylabel('y [m]');
    title('Seccio inicial del port en estrella i carcassa equivalent');
    legend('Port estrella inicial', 'Carcassa', 'Location', 'best');
    hold off;

end