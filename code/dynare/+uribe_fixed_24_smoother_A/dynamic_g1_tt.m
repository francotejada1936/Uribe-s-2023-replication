function [T_order, T] = dynamic_g1_tt(y, x, params, steady_state, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = uribe_fixed_24_smoother_A.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
T_order = 1;
if size(T, 1) < 54
    T = [T; NaN(54 - size(T, 1), 1)];
end
T(27) = getPowerDeriv(y(33)-exp((-y(49)))*params(2)*y(13),(-params(3)),1);
T(28) = getPowerDeriv(y(33),params(10),1);
T(29) = T(23)*T(28);
T(30) = getPowerDeriv(T(24),1-params(11),1);
T(31) = getPowerDeriv(T(2),params(4)*(1-params(3)),1);
T(32) = (-(params(4)*exp(y(47))*(y(33)-exp((-y(49)))*params(2)*y(13))*(-exp(y(47)))));
T(33) = (-(exp(y(48))*getPowerDeriv(y(34),params(5),1)));
T(34) = params(5)*exp(y(48))*getPowerDeriv(y(34),params(5)-1,1);
T(35) = (-(y(63)*params(1)*params(7)*exp((1-params(3))*y(77))))/(y(35)*y(35))/(1+y(66));
T(36) = (1+y(68))*T(35);
T(37) = params(1)*(1+y(39))/(1+y(68));
T(38) = params(1)*params(7)*exp((1-params(3))*y(77))/y(35)/(1+y(66));
T(39) = (1+y(68))*T(38);
T(40) = (1+y(40))*(-params(7))/((1+y(38))*(1+y(38)));
T(41) = (-(1+y(40)))/((1+y(38))*(1+y(38)));
T(42) = (-(y(63)*params(1)*params(7)*exp((1-params(3))*y(77))/y(35)))/((1+y(66))*(1+y(66)));
T(43) = (1+y(68))*T(42);
T(44) = (-(1+y(68)))/((1+y(66))*(1+y(66)));
T(45) = T(22)*getPowerDeriv(1+y(40),params(9),1);
T(46) = getPowerDeriv(1+y(40),1-params(8),1);
T(47) = (-(params(1)*(1+y(39))*y(63)))/((1+y(68))*(1+y(68)));
T(48) = 1/(1+y(66));
T(49) = getPowerDeriv(1+y(15),params(8),1);
T(50) = exp(y(52)*(-params(8)))*T(49);
T(51) = getPowerDeriv(1+y(17),params(11),1);
T(52) = params(4)*exp(y(47))*(y(33)-exp((-y(49)))*params(2)*y(13))*(-(exp(y(47))*y(34)));
T(53) = y(63)*params(1)*params(7)*(1-params(3))*exp((1-params(3))*y(77))/y(35)/(1+y(66));
T(54) = (1+y(68))*T(53);
end
