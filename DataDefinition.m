%% Definicion de los datos




%% Datos problema
H = 600e3;                              % Altura orbita [m]
m_PL = 20;                              % Massa de la payload [kg]
Pc_max = 50e6;                          % Presion maxima de cámara [Pa]

%% Datos asumidos

% Velocity increment
S1.DeltaV = [];
S2.DeltaV = [];
S3.DeltaV = [];

% Relacio estructural ( epsilon = ms/(ms+mp) )
S1.epsilon = [];
S2.epsilon = [];
S3.epsilon = [];

% Relacio de repartiment ( lambda = m_pl/(ms+mp) )
S1.lambda = [];
S2.lambda = [];
S3.lambda = [];

% Fraccio de payload ( r = m_pl/mi = lambda/(1+lambda) )
S1.PL_ratio = [];
S2.PL_ratio = [];
S3.PL_ratio = [];


%% Datos geométricos








%% Standard values sea level
ISA.rho0 = 1.225;                       % Air density sea level [kg/m^3]
ISA.T0 = 15+273.15;                     % Ambient temperature sea level [K]
ISA.P0 = 101325;                        % Sea level preassure [Pa]

g0 = 9.0665;                            % Sea level gravity [m/s^2]
v_sound = 340.29;                       % Sound speed at sea level [m/s]
Visc = 1.7894e-5;                       % Sea level viscosity [Pa*s]
M_air = 28.9644;                        % Sea level molar mass [kg/mol]
R_air = 287.053;                        % Sea level air constant [J/(kg*K)]
gamma_air = 1.4;                        % Ratio of specific heats




%% Lugar de lanzamiento

latitud = 38 + 2/60;                    % Latitud de Murcia [deg]  -  Por definir









