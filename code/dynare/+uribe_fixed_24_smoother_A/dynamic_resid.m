function [residual, T_order, T] = dynamic_resid(y, x, params, steady_state, T_order, T)
if nargin < 6
    T_order = -1;
    T = NaN(26, 1);
end
[T_order, T] = uribe_fixed_24_smoother_A.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
residual = NaN(28, 1);
    residual(1) = (y(35)) - (T(3)*T(17));
    residual(2) = (y(36)) - (params(4)*exp(y(47))*(y(33)-exp((-y(49)))*params(2)*y(13))/T(2));
    residual(3) = (y(35)) - (T(4)*T(5));
    residual(4) = (y(33)) - (T(6));
    residual(5) = (y(36)) - (T(7)/y(37));
residual(6) = y(33)*(-params(6))*T(8)-T(10)*T(11)+T(13)*T(14);
    residual(7) = (1+y(39)) - (exp(y(50))*T(20)*T(25));
    residual(8) = (y(32)) - (exp(y(52))*(1+y(40))/(1+y(16)));
    residual(9) = (y(31)) - (exp(y(52))*(1+y(39))/(1+y(17)));
    residual(10) = (y(29)) - (exp(y(49))*y(33)/y(13));
    residual(11) = (y(46)) - (params(16)*y(18)+params(21)/100*x(1));
    residual(12) = (y(47)) - (params(13)*(1-params(17))+params(17)*y(19)+params(22)/100*x(2));
    residual(13) = (y(49)) - (params(12)*(1-params(19))+params(19)*y(21)+params(24)/100*x(4));
    residual(14) = (y(48)) - (params(18)*y(20)+params(23)/100*x(3));
    residual(15) = (y(52)) - (params(29)*y(24)+params(30)/100*x(6));
    residual(16) = (y(50)) - (params(20)*y(22)+params(25)/100*x(5));
    residual(17) = (y(44)) - (y(40));
    residual(18) = (y(45)) - (y(39));
    residual(19) = (y(41)) - (y(33));
    residual(20) = (1+y(38)) - (T(16)*T(19));
    residual(21) = (y(43)) - (y(38));
    residual(22) = (y(30)) - ((1+y(39))/(1+y(40)));
residual(23) = y(51);
residual(24) = y(42);
    residual(25) = (y(53)) - (100*log(T(21)));
    residual(26) = (y(54)) - (100*log(T(26)));
    residual(27) = (y(55)) - (100*log(y(31)));
    residual(28) = (y(56)) - (100*log(y(32)));
end
