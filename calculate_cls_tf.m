function [Wcls, Wclz, Wols, Wolz] = calculate_cls_tf(m, reg, T)
% calculate_cls_tf returns transfer functions of closed-loop and open-loop system.
% WCLS, WCLSZ, WOLS, WOLZ = CALCULATE_CLS_TF(M, REG)
%
% M is model structure, REG is regualtor structure.
% WCLS and WCLZ are closed-loop tfs continous and discret respectively.
% WOLS and WOLZ are open-loop tfs.
	Wols = m.Ws_u*reg.Rs;
	Wcls = feedback(Wols, 1);
    Wolz = m.Wz_u*reg.Rz;
	Wclz = feedback(Wolz, 1);
end