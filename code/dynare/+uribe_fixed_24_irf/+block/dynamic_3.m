function [y, T] = dynamic_3(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(40)=y(36);
  T(24)=exp(y(48));
  y(28)=T(24)*(1+y(36))/(1+y(16));
  y(26)=(1+y(35))/(1+y(36));
  y(25)=exp(y(45))*y(29)/y(13);
  y(27)=T(24)*(1+y(35))/(1+y(17));
end
