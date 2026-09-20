function nk_model
% nk_model returns  the symbolic first- order approximation to the equilibrium conditions of the  
%New Keynesian model with nonstationary 
%monetary shocks developed  in Martín Uribe, ``The Neo-Fisher Effect: Econometric Evidence from Empirical and Optimizing Models.'' 
%  No need to re-run this program
%when parameter values change. 
%model.m computes a symbolic  log-linear approximation to the  function f, which contains the equilibrium conditions of   the model:  
%  E_t f(yp,y,xp,x) =0. 
%here, a p denotes next-period variables.  
%
%Output: Analytical expressions for f and its first derivatives as well as x and y. 
%The output is written to  <filename>_num_eval.m, where filename is a string given in the program. 
%
%Calls: anal_deriv.m and anal_deriv_print2f.m 
%
%© Martín Uribe, July 2018. 

filename = 'nk_model';

syms SIGG DELTA ALFA ETA  THETA CHI G BETTA_TILDE BETTA PHI A ALFApai ALFAy GAMAm GAMAI

mu = sym('mu'); zp=sym('zp'); syms  pai h theta y w  xi  gm  la  g irate irateback iratebackp  paitilde paitildeback z  zm zm2 zm2back gpai girate gy gpaiback girateback gyback paiback iback yback irate_pai_diff irate_pai_diffp

syms  paip hp thetap yp wp  xip  gmp  lap  gp iratep  paitildep paitildebackp zp mup zmp zm2p zm2backp   gpaip giratep gyp gpaibackp giratebackp gybackp paibackp iratebackp ybackp

syms RHOxi SIGxi  RHOtheta SIGtheta RHOz  SIGz RHOg  SIGg  RHOgm SIGgm RHOzm RHOzm2   SIGzm SIGzm2


%markup 
MU = ETA/(ETA-1) ; 

%Equilibrium conditions. The symbols e1, e2, ... denote equation 1, equation2, ...

%FOC wrt consumption 
e1 = -la + exp(xi) * (y-DELTA*yback/exp(g))^(-SIGG) * (1-exp(theta)*h)^(CHI*(1-SIGG));  

%labor supply
e2 = -w + CHI * exp(theta) * (y-DELTA*yback/exp(g)) / (1-exp(theta)*h);  

%Euler equation 
e3 = -la + BETTA * (1+irate) * lap / (1+paip) * exp(-gmp -SIGG*gp);

%output
e4 = -y + exp(z) * h^ALFA;

%Labor demand
e5 = -w + ALFA * exp(z) *  h^(ALFA-1) / mu;

%Phillips curve 
e6 = -ETA*y * (1/MU-1/mu) - PHI * 1/(1+paitilde) * (1+pai)*((1+pai)/(1+paitilde)-1) + PHI * BETTA * exp((1-SIGG)*gp) * lap/la * 1/(1+paitildep) * (1+paip) * ((1+paip)/(1+paitildep)-1); 

%Taylor-type Interest-rate feedback rule
e7 = -(1+irate) / exp(zm2) + (A * ((1+pai)/exp(zm2))^(ALFApai) * y^ALFAy)^(1-GAMAI) * ((1+irateback)/exp(zm2back))^(GAMAI)  * exp(zm) ;

e8 = -gpai + (1+pai)/(1+paiback) * exp(gm);

e9 = -girate + (1+irate)/(1+irateback) * exp(gm);

e10 = -gy + y/yback * exp(g);

e11 = -xip + RHOxi * xi;

e12 = -(thetap-THETA) + RHOtheta * (theta-THETA);

e13 = -(gp-G) + RHOg * (g-G);

e14 = -zp + RHOz * z;

e15 = -gmp + RHOgm * gm;

e16 = -zmp + RHOzm * zm;

e17 = -paibackp + pai;

e18 =- iratebackp + irate;

e19 = -ybackp + y;

e20 = -(1+paitilde) + exp(-GAMAm*gm) * (1+paitildeback)^GAMAm * (1+pai)^(1-GAMAm);

e21 = -paitildebackp +paitilde;

%interest-rate inflation differential
e22 = -irate_pai_diff  + (1+irate)/(1+pai); 

% Transitory inflation-target shock
e23 = -zm2p + RHOzm2 * zm2;

e24 = -zm2 + zm2backp;


%Create function f

f = eval([ e1; e2; e3; e4; e5;e6;e7;e8;e9;e10;e11;e12;e13;e14;e15;e16;e17;e18;e19;e20;e21;e22;e23;e24])

%Define vectors of states and controls, distinguishing between those that will be log-linearized and those that will be linearized. Define vectos of standard deviations of states  (0 for endogenous states) for constructing ETASHOCK. 

states_in_logs = [yback ];
std_states_in_logs = sym([ 0 ]); 

states_in_levels = [zm2back paitildeback paiback irateback xi theta z g zm zm2 gm];
std_states_in_levels = sym([ 0 0 0 0  SIGxi SIGtheta SIGz SIGg SIGzm SIGzm2 SIGgm]);

controls_in_logs = [gy  irate_pai_diff  girate  gpai y h la w mu ];
controls_in_levels = [paitilde irate pai];

%Produce next period versions of controls and states (variables with suffix p)
aux = 'states_in_logs';
aux1 = [aux 'p = [']
for iaux=1:eval(['numel(' aux ')'])
aux1 = [aux1 ' ' char(eval([aux '(' num2str(iaux) ')'])) 'p']
end
aux1 = [aux1 ']'];
eval(aux1)

aux = 'states_in_levels';
aux1 = [aux 'p = [']
for iaux=1:eval(['numel(' aux ')'])
aux1 = [aux1 ' ' char(eval([aux '(' num2str(iaux) ')'])) 'p']
end
aux1 = [aux1 ']'];
eval(aux1)

aux = 'controls_in_logs';
aux1 = [aux 'p = [']
for iaux=1:eval(['numel(' aux ')'])
aux1 = [aux1 ' ' char(eval([aux '(' num2str(iaux) ')'])) 'p']
end
aux1 = [aux1 ']'];
eval(aux1)

aux = 'controls_in_levels';
aux1 = [aux 'p = [']
for iaux=1:eval(['numel(' aux ')'])
aux1 = [aux1 ' ' char(eval([aux '(' num2str(iaux) ')'])) 'p']
end
aux1 = [aux1 ']'];
eval(aux1)

states = [states_in_logs states_in_levels];
statesp = [states_in_logsp states_in_levelsp];

controls = [controls_in_logs controls_in_levels]; 
controlsp = [controls_in_logsp controls_in_levelsp]; 

std_states = [std_states_in_logs  std_states_in_levels];

%Number of states, controls, and shocks
nstates = length(states);
ncontrols = length(controls);
nshocks = nstates-numel(find(std_states==sym(0)));

%Make f a function of the logarithm of the state and control vector

%variables to substitute from levels to logs
variables_in_logs = transpose([states_in_logs, controls_in_logs, states_in_logsp, controls_in_logsp]);

%variable transformations
f = subs(f, variables_in_logs, exp(variables_in_logs));

approx = 1;

%Compute analytical derivatives of f
[fx,fxp,fy,fyp]=anal_deriv(f,states,controls,statesp,controlsp,approx);

%Make f and its derivatives a function of the level of its arguments rather than the log
f = subs(f, variables_in_logs, log(variables_in_logs));
fx = subs(fx, variables_in_logs, log(variables_in_logs));
fy = subs(fy, variables_in_logs, log(variables_in_logs));
fxp = subs(fxp, variables_in_logs, log(variables_in_logs));
fyp = subs(fyp, variables_in_logs, log(variables_in_logs));

%Symbolically evaluate f and its derivatives at the nonstochastic steady state (c=cp, etc.)
cu = transpose([states controls]);
cup = transpose([statesp controlsp]);

for subcb=1:2 %substitution must be run twice  in case the original system is a stochastic difference equation of order higher than one. For example, the current model features k_t, k_t+1, and k_t+2 and thus is a 2nd order difference equation

try 
f = subs(f, cup,cu,0);
fx = subs(fx, cup,cu,0);
fy = subs(fy, cup,cu,0);
fxp = subs(fxp, cup,cu,0);
fyp = subs(fyp, cup,cu,0);
catch
f = subs(f, cup,cu);
fx = subs(fx, cup,cu);
fy = subs(fy, cup,cu);
fxp = subs(fxp, cup,cu);
fyp = subs(fyp, cup,cu);
end %try
end

%Construct ETASHOCK matrix, which determines the var/cov of the forcing term of the system. Specifically, the state vector evolves over time according to 
%x_t+1 = hx x_t + ETASHOCK epsilon_t+1
ETASHOCK =diag(std_states);

 for i=1:ncontrols
eval(['n' char(controls(i)) '=' num2str(i)])
end

 for i=1:nstates
eval(['n' char(states(i)) '=' num2str(i)])
end


%Print derivatives to file <filename>_num_eval.m'  for model evaluation
try 
eval(['!del ' filename '_num_eval.m'])
end
first_order_print2f(filename,fx,fxp,fy,fyp,f,ETASHOCK,states,controls,mfilename('fullpath'));

eval(['save ' filename '.mat'])
