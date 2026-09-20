function [Dy,Dpai,Dff, y, pai,ff,date, readme_data] = read_data(T)
%[Dy,Dpai,Dff, y, pai,ff,date, readme_data] = read_data
%returns the following U.S. quarterly data  from 1.954:Q4   to 2.018:Q2:
%Dy = log difference of real per capita GDP growth rate annualized
%Dpai = change of GDP-deflator inflation rate % annualized. 
%Dff=change of federal funds rate, in % annualized.
% date= calendar  date
%It also returns the levels, y, pai, and ff
%© Martín Uribe, 09-Mar-2017.

%read gdp data
[a,b]=xlsread('gdplev.xlsx');
% downloaded from www.bea.gov on 8/2018

gdp=a(:,5);%Gross Domestic Product, BEA, billions of current dollars, seasonally adjusted at annual rates.
rgdp=a(:,6); %Real Gross Domestic Product, BEA,  billions of chained 2012 dollars seasonally adjusted at annual rate.

gdp_date=(1947:0.25:2018.25)';

gdp_deflator = gdp./rgdp; 

inflation = ((gdp_deflator(2:end)./gdp_deflator(1:end-1)).^4 - 1)*100;
inflation_date = (1947.25:0.25:2018.25)'; 

Dinflation = diff(inflation);
Dinflation_date = (1947.5:0.25:2018.25)'; 

%Get population
%bls.gov
%Series Id:	LNU00000000Q				
%Not Seasonally Adjusted					
%Series title:	(Unadj) Population Level				
%Labor force status:	Civilian noninstitutional population				
%Type of data:	Number in thousands				
%Age:	16 years and over				
%Years:	1948 to 2018:Q2				
[a,b]=xlsread('LNU.xlsx');
pop = a(:,3);
pop_date= (1948:0.25:2018.25)';

%Read Fed funds rate data
%	H.15 Selected Interest Rates for August 6, 2018
%Series Description	Federal funds effective rate
%Unit:	Percent:_Per_Year
%Unique Identifier:	H15/H15/RIFSPFF_N.M
%Monthly
%1954-07
%2018-07
[a,b]=xlsread('fedfunds.xlsx');
x = a(5:end-1);
%Make monthly series into quarterly ones, again in % per year
reshape(x,3,length(x)/3);
prod(1+ans/100);
irate = (ans.^(1/3)-1)*100;irate = irate';
irate_date = (1954.5:0.25:2018.25)';

Dirate = diff(irate);
Dirate_date = (1954.75:0.25:2018.25)';

%now create a common sample, 1954Q4 to 2018Q2
t0gdp=find(gdp_date==Dirate_date(1));
t0pop=find(pop_date==Dirate_date(1));
t0Dinflation=find(Dinflation_date==Dirate_date(1));
t0inflation = find(inflation_date==Dirate_date(1)); 
t0Dirate=find(Dirate_date==Dirate_date(1));
t0irate=find(irate_date==Dirate_date(1));

y = log(rgdp(t0gdp:end)./pop(t0pop:end)); 
Dy = diff(log(rgdp(t0gdp-1:end) ./pop(t0pop-1:end))) *100; 
pai = inflation(t0inflation:end);
Dpai = Dinflation(t0Dinflation:end);
ff = irate(t0irate:end); 
Dff = Dirate(t0Dirate:end); 
date =gdp_date(t0gdp:end); 


if nargin<1
T = date(end);
end
tend = find(date==T);
series_name = {'Dy','Dpai','Dff',' y',' pai','ff','date'} ;
series_number = length(series_name);
for i=1:series_number
eval([series_name{i} '=' series_name{i} '(1:tend);'])
end

readme_data = 'y= log of real GDP per capita; Dy =  change of y in % annualized;  pai=GDP-deflator inflation rate in %; Dpai = change of pai, ff federal funds rate in % annualized; Dff=change of ff; date= calendar  date;sample 1.954:Q4 2.018:Q2; Country: USA';