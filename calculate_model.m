function m = calculate_model(m, T, tau_e)
% CALCULATE_MODEL returns dependent plant parameters and models
% MODEL = calculate_model(PARAMS, Q0, T)
% Q0 is linearization point, discretization period

	% calculate dependent parameters and add them to m structure
    
	% ОУ
    m.c1 = m.V/(m.k_g*m.omega_free);
    m.R = m.V^2/(m.omega_free*m.M_stall);
    m.tau_f = 0.1*m.c1*m.I_free;
    m.tau = m.tau_f + tau_e;
    m.I0 = m.tau/m.c1;
    m.V0 = m.I0*m.R;
    m.freq_tau_f = 0.1*m.c1*m.I_free/(m.k_g*m.omega_free);
    m.k1 = 1/m.c1;
    m.k2 = m.R/(m.c1^2);
    m.T_em = m.J*m.R/(m.c1^2*m.k_g^2);
    m.T_ya = m.L/m.R;
    m.b0 = m.k1*m.V/(2^m.N_pwm);
    m.W_u = tf([m.k1],[m.T_ya*m.T_em, m.T_em, 1]);
    m.W_tau = tf([m.k2*m.T_ya, m.k2], [m.T_ya*m.T_em, m.T_em, 1]);
    % zpk
    m.Ws = m.W_u*m.V/(2^m.N_pwm);
	m.Ws_u = zpk(m.W_u);
	m.Wz_u = c2d(m.Ws_u, T); % ZT-transform of Ws_u multiplied by T
    m.Ws_tau = zpk(m.W_tau);
	m.Wz_tau = c2d(m.Ws_tau, T); % ZT-transform of Ws_tau multiplied by T
    
    % m.D = tf([m.T_em, 0], [m.T_ya, 1]);
    m.Tf = 4*m.T_ya/m.T_em;
    m.D = tf([1, 0], [m.Tf, 1]);
    m.Ds = zpk(m.D);
    m.Dz = c2d(m.Ds, T); % ZT-transform of Ws_tau multiplied by T
    m.Dz1 = tf(m.Dz);
	% PWM modulator
	m.Tpwm = 2^m.N_pwm / m.freq_mcu;
end