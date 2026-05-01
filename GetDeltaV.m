function DV = GetDeltaV(phi, h)
% Obtiene el impulso teorico necesario
% INPUT:
%       phi: latitud
%       h: altura de la orbita final
% OUTPUT: 
%       DV: delta V

R_T = 6371e3;                   % Radio de la Tierra [kg]
G = 6.67e-11;                   % Constante gravitacional [N*m^2/kg^2]
M = 5.975e24;                   % Masa de la Tierra [kg]
T = 23*3600+56*60+4;            % Periodo de rotacion de la Tierra [s]

v_orb = sqrt(G*M/(R_T+h));
v_rot = 2*pi*R_T*cos(phi)/T;

DV = v_orb - v_rot;

% Hay pérdidas por drag y por gravedad, hay que investigar sobre estas dos



end