function I_s = Tsiolkovski(deltaV, m_r)
% Devuelve el I_s a partir de la de DeltaV y mass ratio


    g0 = 9.0665;                            % Sea level gravity [m/s^2]
    I_s = deltaV/(g0 * ln(m_r));

end

