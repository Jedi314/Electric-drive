% discretization time
T = 0.00064; % s

% get system parameters
p = get_params();

% calculayte dependent parameters
tau_e = 0.005;
omega0 = 20;
m = calculate_model(p, T, tau_e);

%regulator synthesis
%reg = syn_regulator(m, 0.2, T);
reg = syn_regulator(m, 0.1, T);
% reg = syn_regulator(m, 0.05, T);
% reg = syn_regulator(m, 0.04, T);

% closed loop model
[Wcls, Wclz, Wols, Wolz] = calculate_cls_tf(m, reg, T);