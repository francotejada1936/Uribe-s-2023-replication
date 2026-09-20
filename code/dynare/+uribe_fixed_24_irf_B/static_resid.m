function [residual, T_order, T] = static_resid(y, x, params, T_order, T)
if nargin < 5
    T_order = -1;
    T = NaN(16, 1);
end
[T_order, T] = uribe_fixed_24_irf_B.static_resid_tt(y, x, params, T_order, T);
residual = NaN(24, 1);
    residual(1) = (y(7)) - (T(2)*T(3));
    residual(2) = (y(8)) - ((y(5)-exp((-y(21)))*params(2)*y(13))*params(4)*exp(y(19))/(1-exp(y(19))*y(6)));
    residual(3) = (y(7)) - (y(7)*params(1)*(1+y(11))/(1+y(12))*exp((-(params(3)*y(21)))));
    residual(4) = (y(5)) - (T(4));
    residual(5) = (y(8)) - (T(5)/y(9));
residual(6) = y(5)*(-params(6))*T(6)-T(7)*T(8)+T(8)*T(9);
    residual(7) = ((1+y(11))/exp(y(23))) - (exp(y(22))*T(10)*T(14));
    residual(8) = (y(4)) - ((1+y(12))/(1+y(16)));
    residual(9) = (y(3)) - ((1+y(11))/(1+y(17)));
    residual(10) = (y(1)) - (exp(y(21))*y(5)/y(13));
    residual(11) = (y(18)) - (y(18)*params(16)+params(21)/100*x(1));
    residual(12) = (y(19)) - (params(13)*(1-params(17))+y(19)*params(17)+params(22)/100*x(2));
    residual(13) = (y(21)) - (params(12)*(1-params(19))+y(21)*params(19)+params(24)/100*x(4));
    residual(14) = (y(20)) - (y(20)*params(18)+params(23)/100*x(3));
residual(15) = y(24);
    residual(16) = (y(22)) - (y(22)*params(20)+params(25)/100*x(5));
    residual(17) = (y(16)) - (y(12));
    residual(18) = (y(17)) - (y(11));
    residual(19) = (y(13)) - (y(5));
    residual(20) = (1+y(10)) - (T(15)*T(16));
    residual(21) = (y(15)) - (y(10));
    residual(22) = (y(2)) - ((1+y(11))/(1+y(12)));
    residual(23) = (y(23)) - (y(23)*0.999+params(29)/100*x(6));
    residual(24) = (y(14)) - (y(23));
end
