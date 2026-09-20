function [T_order, T] = static_g1_tt(y, x, params, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = uribe_fixed_24_irf_B.static_resid_tt(y, x, params, T_order, T);
T_order = 1;
if size(T, 1) < 21
    T = [T; NaN(21 - size(T, 1), 1)];
end
T(17) = getPowerDeriv(y(5)-exp((-y(21)))*params(2)*y(13),(-params(3)),1);
T(18) = getPowerDeriv(T(13),1-params(11),1);
T(19) = getPowerDeriv(1-exp(y(19))*y(6),params(4)*(1-params(3)),1);
T(20) = getPowerDeriv((1+y(12))/exp(y(23)),params(9),1);
T(21) = getPowerDeriv((1+y(17))/exp(y(14)),params(11),1);
end
