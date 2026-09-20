function [T_order, T] = dynamic_g2_tt(y, x, params, steady_state, T_order, T)
if T_order >= 2
    return
end
[T_order, T] = uribe_fixed_24_smoother_A.dynamic_g1_tt(y, x, params, steady_state, T_order, T);
T_order = 2;
if size(T, 1) < 58
    T = [T; NaN(58 - size(T, 1), 1)];
end
T(55) = getPowerDeriv(y(33)-exp((-y(49)))*params(2)*y(13),(-params(3)),2);
T(56) = getPowerDeriv(T(2),params(4)*(1-params(3)),2);
T(57) = T(40)*T(41);
T(58) = getPowerDeriv(T(24),1-params(11),2);
end
