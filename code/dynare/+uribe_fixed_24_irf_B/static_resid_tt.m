function [T_order, T] = static_resid_tt(y, x, params, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 16
    T = [T; NaN(16 - size(T, 1), 1)];
end
T(1) = exp(params(14)+params(12)*params(3))/params(1)/((params(5)/(exp(params(13))*(params(5)+params(15)*params(4)*(1-params(2)*exp((-params(12)))))))^params(5))^params(10);
T(2) = (1-exp(y(19))*y(6))^(params(4)*(1-params(3)));
T(3) = exp(y(18))*(y(5)-exp((-y(21)))*params(2)*y(13))^(-params(3));
T(4) = exp(y(20))*y(6)^params(5);
T(5) = params(5)*exp(y(20))*y(6)^(params(5)-1);
T(6) = 1/params(15)-1/y(9);
T(7) = (1+y(12))*params(7)/(1+y(10));
T(8) = (1+y(12))/(1+y(10))-1;
T(9) = (1+y(12))*params(1)*params(7)*exp((1-params(3))*y(21))/(1+y(10));
T(10) = ((1+y(17))/exp(y(14)))^params(11);
T(11) = y(5)^params(10);
T(12) = T(1)*((1+y(12))/exp(y(23)))^params(9);
T(13) = T(11)*T(12);
T(14) = T(13)^(1-params(11));
T(15) = (1+y(12))^(1-params(8));
T(16) = (1+y(15))^params(8);
end
