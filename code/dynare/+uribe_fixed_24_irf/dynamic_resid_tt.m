function [T_order, T] = dynamic_resid_tt(y, x, params, steady_state, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 20
    T = [T; NaN(20 - size(T, 1), 1)];
end
T(1) = (1-exp(y(43))*y(30))^(params(4)*(1-params(3)));
T(2) = params(1)*(1+y(35))*y(55)/(1+y(60));
T(3) = exp(y(44))*y(30)^params(5);
T(4) = params(5)*exp(y(44))*y(30)^(params(5)-1);
T(5) = 1/params(15)-1/y(33);
T(6) = params(7)/(1+y(34))*(1+y(36));
T(7) = (1+y(36))/(1+y(34))-1;
T(8) = y(55)*params(1)*params(7)*exp((1-params(3))*y(69))/y(31)/(1+y(58));
T(9) = (1+y(60))*T(8);
T(10) = (1+y(60))/(1+y(58))-1;
T(11) = y(29)^params(10);
T(12) = (1+y(36))^(1-params(8));
T(13) = exp(y(42))*(y(29)-exp((-y(45)))*params(2)*y(13))^(-params(3));
T(14) = (1+y(15))^params(8);
T(15) = exp(y(48)*(-params(8)))*T(14);
T(16) = (1+y(17))^params(11);
T(17) = exp(params(14)+params(12)*params(3))/params(1)/((params(5)/(exp(params(13))*(params(5)+params(15)*params(4)*(1-params(2)*exp((-params(12)))))))^params(5))^params(10);
T(18) = (1+y(36))^params(9)*T(17);
T(19) = T(11)*T(18);
T(20) = T(19)^(1-params(11));
end
