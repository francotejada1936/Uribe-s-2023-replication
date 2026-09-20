%nk_ss.m
%Steady state of the New Keynesian model with Rotemberg pricing  and nonstationary monetary shocks. 
%developed  in the paper ``The Neo-Fisher Effect: Evidence from an Estimated New-Keynsian Model,'' by Martín Uribe. 
%© Martín Uribe,  July 2018.

%Calibration
%Time unit is a quarter

SIGG = 2; %
ALFA =0.75;% labor elasticity of output
ETA = 6;%elasticity of substitution across varieties of intermediate goods. It implies a markup of price over marginal cost of 20 percent 
G = 0.004131; %steady-state growth rate of output. Source: go to z:\uribe\fisher\us and write the command  Dy = read_data and then mean(Dy);
MU = ETA/(ETA-1); %product markup
pai = 0; %steady-state value of detrended inflation
h = 1/3; %steady-state hours;
THETA = -log(2*h); %parameter determining the wage elasticity of labor
theta = THETA; %labor supply shock
y = h^ALFA; %output 
w = ALFA*h^(ALFA-1) / MU; %real wage 
CHI = w * (1-exp(THETA)*h) / exp(THETA) / y/(1-DELTA/exp(G)); %parameter determining the  steady-state level of hours worked
z = 0; %transitory tech. shock 
zm = 0; %transitory monetary shock 
zm2 = 0; %transitorytarget shock 
zm2back = 0; %pas value of zm2
xi = 0; %preference shock
gm = 0; %permanent monetary shock
la = (y-DELTA*y/exp(G))^(-SIGG) * (1-exp(THETA)*h)^(CHI*(1-SIGG)); %marginal utility of wealth (detrended)
g = G; %permanent technology shock 
BETTA_TILDE = 0.99; %growth-adjusted subjective discount factor 
BETTA = BETTA_TILDE*exp(SIGG*g); %subjective discount factor 
irate = 1/(BETTA*exp(-SIGG*g))-1;
xntilde = 1; %steady-sate value of detrended growth  scaler  in Phillips curve
paitilde = 0; %steady-sate value of detrended price-change  scaler  in Phillips curve
irateback = irate;
paiback = pai;
yback = y;
xntildeback = xntilde;
paitildeback = paitilde;
gy = exp(G);
gpai = 1;
girate = 1;
mu = MU;
irate_pai_diff = (1+irate)/(1+pai);
A = (1+irate) /(1+pai)^ALFApai / y^ALFAy;