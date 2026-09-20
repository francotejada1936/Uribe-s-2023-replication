function [T_order, T] = dynamic_resid_tt(y, x, params, steady_state, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 26
    T = [T; NaN(26 - size(T, 1), 1)];
end
T(1) = exp(params(14)+params(12)*params(3))/params(1);
T(2) = 1-exp(y(47))*y(34);
T(3) = T(2)^(params(4)*(1-params(3)));
T(4) = params(1)*(1+y(39))*y(63)/(1+y(68));
T(5) = exp((-y(80))-params(3)*y(77));
T(6) = exp(y(48))*y(34)^params(5);
T(7) = params(5)*exp(y(48))*y(34)^(params(5)-1);
T(8) = 1/params(15)-1/y(37);
T(9) = params(7)/(1+y(38));
T(10) = T(9)*(1+y(40));
T(11) = (1+y(40))/(1+y(38))-1;
T(12) = y(63)*params(1)*params(7)*exp((1-params(3))*y(77))/y(35)/(1+y(66));
T(13) = (1+y(68))*T(12);
T(14) = (1+y(68))/(1+y(66))-1;
T(15) = y(33)^params(10);
T(16) = (1+y(40))^(1-params(8));
T(17) = exp(y(46))*(y(33)-exp((-y(49)))*params(2)*y(13))^(-params(3));
T(18) = (1+y(15))^params(8);
T(19) = exp(y(52)*(-params(8)))*T(18);
T(20) = (1+y(17))^params(11);
T(21) = y(29)/exp(params(12));
T(22) = T(1)/((params(5)/(exp(params(13))*(params(5)+params(15)*params(4)*(1-params(2)*exp((-params(12)))))))^params(5))^params(10);
T(23) = (1+y(40))^params(9)*T(22);
T(24) = T(15)*T(23);
T(25) = T(24)^(1-params(11));
T(26) = y(30)/T(1);
end
