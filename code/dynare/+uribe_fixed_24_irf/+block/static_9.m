function [y, T] = static_9(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(16)=y(12);
  T(26)=exp(y(24));
  y(4)=T(26)*(1+y(12))/(1+y(16));
  y(2)=(1+y(11))/(1+y(12));
  y(1)=exp(y(21))*y(5)/y(13);
  y(3)=T(26)*(1+y(11))/(1+y(17));
end
