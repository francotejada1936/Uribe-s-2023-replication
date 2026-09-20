function [T_order, T] = dynamic_g1_tt(y, x, params, steady_state, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = uribe_fixed_24_irf_B.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
T_order = 1;
if size(T, 1) < 23
    T = [T; NaN(23 - size(T, 1), 1)];
end
T(19) = getPowerDeriv(y(29)-exp((-y(45)))*params(2)*y(13),(-params(3)),1);
T(20) = getPowerDeriv(T(17),1-params(11),1);
T(21) = getPowerDeriv(1-exp(y(43))*y(30),params(4)*(1-params(3)),1);
T(22) = getPowerDeriv((1+y(36))/exp(y(47)),params(9),1);
T(23) = getPowerDeriv((1+y(17))/exp(y(14)),params(11),1);
end
