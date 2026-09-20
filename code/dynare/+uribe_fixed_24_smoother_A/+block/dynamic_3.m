function [y, T] = dynamic_3(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(44)=y(40);
  T(26)=exp(y(52));
  y(32)=T(26)*(1+y(40))/(1+y(16));
  y(31)=T(26)*(1+y(39))/(1+y(17));
  y(56)=100*log(y(32));
  y(55)=100*log(y(31));
  y(30)=(1+y(39))/(1+y(40));
  y(29)=exp(y(49))*y(33)/y(13);
  y(54)=100*log(y(30)/T(10));
  T(27)=exp(params(12));
  y(53)=100*log(y(29)/T(27));
end
