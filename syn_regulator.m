function r = syn_regulator(m, Treg, T)
% SYN_REGULATOR performs regulator synthesis for given model
%
% REG = SYN_REGULATOR(MODEL, TREG, T)
%
% REG is regulator structure, MODEL is model strcture, 
% TREG is settling time and T is discretization period.

	r.lambda = 3.7 / Treg;
    r.kp = (2.5*r.lambda*m.T_em-1)/m.b0;
    r.ki = r.lambda^2*m.T_em/m.b0;


    % r.kp = (r.lambda^2*m.T_ya*m.T_em-1)/m.b0;
    % r.kd = (2.5*r.lambda-1/m.T_ya)*m.T_ya*m.T_em/m.b0;

    % r.lambda = 3.2 / Treg;
    % r.kp = (r.lambda^2*m.T_ya*m.T_em-1)/m.b0;
    % r.kd = (1.38*r.lambda-1/m.T_ya)*m.T_ya*m.T_em/m.b0;

    % r.lambda = 4.6 / Treg;
    % r.kp = (r.lambda^2*m.T_ya*m.T_em-1)/m.b0;
    % r.kd = (2*r.lambda-1/m.T_ya)*m.T_ya*m.T_em/m.b0;
    
	% transfer function
	r.Rs = tf([r.kp, r.ki], [1, 0]);
	r.Rz = c2d(r.Rs, T); % discrete model
end