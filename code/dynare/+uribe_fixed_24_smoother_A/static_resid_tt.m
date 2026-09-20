function [T_order, T] = static_resid_tt(y, x, params, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 19
    T = [T; NaN(19 - size(T, 1), 1)];
end
T(1) = exp(params(14)+params(12)*params(3))/params(1);
T(2) = T(1)/((params(5)/(exp(params(13))*(params(5)+params(15)*params(4)*(1-params(2)*exp((-params(12)))))))^params(5))^params(10);
T(3) = (1-exp(y(19))*y(6))^(params(4)*(1-params(3)));
T(4) = exp(y(18))*(y(5)-exp((-y(21)))*params(2)*y(13))^(-params(3));
T(5) = y(7)*params(1)*(1+y(11))/(1+y(12));
T(6) = exp(y(20))*y(6)^params(5);
T(7) = params(5)*exp(y(20))*y(6)^(params(5)-1);
T(8) = 1/params(15)-1/y(9);
T(9) = (1+y(12))*params(7)/(1+y(10));
T(10) = (1+y(12))/(1+y(10))-1;
T(11) = (1+y(12))*params(1)*params(7)*exp((1-params(3))*y(21))/(1+y(10));
T(12) = (1+y(17))^params(11);
T(13) = y(5)^params(10);
T(14) = T(2)*(1+y(12))^params(9);
T(15) = T(13)*T(14);
T(16) = T(15)^(1-params(11));
T(17) = (1+y(12))^(1-params(8));
T(18) = (1+y(15))^params(8);
T(19) = exp(y(24)*(-params(8)))*T(18);
end
