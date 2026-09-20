function [T_order, T] = static_g1_tt(y, x, params, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = uribe_fixed_24_smoother_A.static_resid_tt(y, x, params, T_order, T);
T_order = 1;
if size(T, 1) < 22
    T = [T; NaN(22 - size(T, 1), 1)];
end
T(20) = getPowerDeriv(y(5)-exp((-y(21)))*params(2)*y(13),(-params(3)),1);
T(21) = getPowerDeriv(T(15),1-params(11),1);
T(22) = getPowerDeriv(1-exp(y(19))*y(6),params(4)*(1-params(3)),1);
end
