function [pe,Te,rhoe,ae,g] = AtmosferaISA(h)
% Valores de la atmosfera estandar internacional
%
% INPUTS:
%       h: altitud [m]
% OUTPUTS:
%       pe: presion [Pa]
%       Te: Temperatura [K]
%       rhoe: densidad [kg/m^3]
%       ae: velocidad del sonido [m/s]
%       g: gravedad [m/s^2]


%Troposfera
g0 = 9.807; %[m/s^2]
Tsea = 288.15; %[K]
psea = 101325; %[Pa]
Raire = 287; %[Nm/kgK]
Rt = 6371e3; %[m]
g = g0/(1+h/Rt)^2; %[m/s^2]
gamma = 1.4;

if 0 <= h && h<11000
 lambda = -0.00649; %[K/m]   

 Te = Tsea + lambda*h; %[K]
 pe = psea*(Te/Tsea)^(-g/(lambda*Raire)); %[Pa]
 rhoe = pe/(Raire*Te);%[kg/m^3]  
 
 %Tropopausa
elseif 11000 <= h && h<20000   
 T0 = 216.76; %[K]
 p0 = 22632; %[Pa]
 h0 = 11000; %[m]
 
 Te = T0;
 pe = p0*exp(-(g/(Raire*T0))*(h-h0));%[Pa]
 rhoe = pe/(Raire*Te);%[kg/m^3] 
 
 %Estratosfera 1
elseif h >= 20000 && h<32000
 lambda = 0.001; %[K/m] 
 T0 = 216.76; %[K]
 p0 = 5474.9; %[Pa]
 %h0 = 20000; %[m]   
 
 Te = T0 + lambda*h; %[K]
 pe = p0*(Te/T0)^(g/(lambda*Raire)); %[Pa]
 rhoe = pe/(Raire*Te);%[kg/m^3]  
 
  %Estratosfera 2
 elseif h >= 32000 && h<47000
 lambda = 0.0028; %[K/m] 
 T0 = 228.65; %[K]
 p0 = 868.02; %[Pa]
 %h0 = 32000; %[m]   
 
 Te = T0 + lambda*h; %[K]
 pe = p0*(Te/T0)^(-g/(lambda*Raire)); %[Pa]
 rhoe = pe/(Raire*Te);%[kg/m^3]  
 
%Estratopausa
elseif h >= 47000 && h<51000
 T0 = 270.65; %[K]
 p0 = 110.91; %[Pa]
 h0 = 47000; %[m]
 
 Te = T0;
 pe = p0*exp(-(g/(Raire*T0))*(h-h0));%[Pa]
 rhoe = pe/(Raire*Te);%[kg/m^3] 
 
%Mesosfera 1
elseif h >= 51000 && h<71000
 lambda = -0.0028; %[K/m] 
 T0 = 270.65; %[K]
 p0 = 66.939; %[Pa]
 %h0 = 51000; %[m]
 
 Te = T0 + lambda*h; %[K]
 pe = p0*(Te/T0)^(-g/(lambda*Raire)); %[Pa]
 rhoe = pe/(Raire*Te);%[kg/m^3]  
 
 %Mesosfera 2
 elseif h >= 71000 && h<84852
 lambda = -0.002; %[K/m]
 T0 = 214.65; %[K]
 p0 = 3.9564; %[Pa]
 %h0 = 71000; %[m]
 
 Te = T0 + lambda*h; %[K]
 pe = p0*(Te/T0)^(-g/(lambda*Raire)); %[Pa]
 rhoe = pe/(Raire*Te);%[kg/m^3] 
 
elseif h>84852
 T0 = 186.87; %[K]
 p0 = 0.374; %[Pa]
 h0 = 84852; %[m]
 
 Te = T0;
 pe = p0*exp(-(g/(Raire*T0))*(h-h0));%[Pa]
 rhoe = pe/(Raire*Te);%[kg/m^3] 

end

ae = sqrt(gamma*Raire*Te);

end

