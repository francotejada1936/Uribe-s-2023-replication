function [residual, T_order, T] = dynamic_resid(y, x, params, steady_state, T_order, T)
if nargin < 6
    T_order = -1;
    T = NaN(20, 1);
end
[T_order, T] = uribe_fixed_24_irf.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
residual = NaN(24, 1);
    residual(1) = (y(31)) - (T(1)*T(13));
    residual(2) = (y(32)) - (params(4)*exp(y(43))*(y(29)-exp((-y(45)))*params(2)*y(13))/(1-exp(y(43))*y(30)));
    residual(3) = (y(31)) - (T(2)*exp((-y(72))-params(3)*y(69)));
    residual(4) = (y(29)) - (T(3));
    residual(5) = (y(32)) - (T(4)/y(33));
residual(6) = y(29)*(-params(6))*T(5)-T(6)*T(7)+T(9)*T(10);
    residual(7) = (1+y(35)) - (exp(y(46))*T(16)*T(20));
    residual(8) = (y(28)) - (exp(y(48))*(1+y(36))/(1+y(16)));
    residual(9) = (y(27)) - (exp(y(48))*(1+y(35))/(1+y(17)));
    residual(10) = (y(25)) - (exp(y(45))*y(29)/y(13));
    residual(11) = (y(42)) - (params(16)*y(18)+params(21)/100*x(1));
    residual(12) = (y(43)) - (params(13)*(1-params(17))+params(17)*y(19)+params(22)/100*x(2));
    residual(13) = (y(45)) - (params(12)*(1-params(19))+params(19)*y(21)+params(24)/100*x(4));
    residual(14) = (y(44)) - (params(18)*y(20)+params(23)/100*x(3));
    residual(15) = (y(48)) - (params(29)*y(24)+params(30)/100*x(6));
    residual(16) = (y(46)) - (params(20)*y(22)+params(25)/100*x(5));
    residual(17) = (y(40)) - (y(36));
    residual(18) = (y(41)) - (y(35));
    residual(19) = (y(37)) - (y(29));
    residual(20) = (1+y(34)) - (T(12)*T(15));
    residual(21) = (y(39)) - (y(34));
    residual(22) = (y(26)) - ((1+y(35))/(1+y(36)));
residual(23) = y(47);
residual(24) = y(38);
end
