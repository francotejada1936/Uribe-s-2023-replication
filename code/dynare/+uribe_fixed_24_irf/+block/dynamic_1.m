function [y, T] = dynamic_1(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(42)=params(16)*y(18)+params(21)/100*x(1);
  y(43)=params(13)*(1-params(17))+params(17)*y(19)+params(22)/100*x(2);
  y(45)=params(12)*(1-params(19))+params(19)*y(21)+params(24)/100*x(4);
  y(44)=params(18)*y(20)+params(23)/100*x(3);
  y(48)=params(29)*y(24)+params(30)/100*x(6);
  y(46)=params(20)*y(22)+params(25)/100*x(5);
  y(47)=0;
  y(38)=0;
end
