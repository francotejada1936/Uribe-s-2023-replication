function plot_point1_irfs_24()
%PLOT_POINT1_IRFS_24 Plot the four requested IRF variables.
%
% Product, inflation and the nominal rate are accumulated from their growth
% responses, following nk_irfs.m in the original replication package.
% The real-rate response is constructed as i_t-E_t*pi_{t+1}, also following
% the original plotting routine. Rates and inflation are annualized where
% this is meaningful.

P = project_paths();

initial = load(fullfile(P.initial_irf,'uribe_initial_24_irf_results.mat'), ...
               'oo_','M_');
plot_one(initial,{'eps_gm','eps_zm2','eps_zm'}, ...
         {'Permanent target growth','Transitory target','Direct monetary'}, ...
         'Uribe initial: Table 4 + Table 5 means', ...
         fullfile(P.initial_irf,'uribe_initial_24_irfs.pdf'));

A = { ...
    load(fullfile(P.uribe_A,'uribe_A_24_irf_mode5.mat'),'oo_','M_'), ...
    load(fullfile(P.uribe_A,'uribe_A_24_irf_mode6.mat'),'oo_','M_'), ...
    load(fullfile(P.uribe_A,'uribe_A_24_irf_mh_mean.mat'),'oo_','M_')};
plot_comparison(A,{'mode 5','mode 6','MH posterior mean'}, ...
    {'eps_gm','eps_zm'},{'Permanent target growth','Direct monetary'}, ...
    'Uribe-A: fixed-parameter IRFs', ...
    fullfile(P.uribe_A,'uribe_A_24_irfs.pdf'));

B = {load(fullfile(P.uribe_B,'uribe_B_24_irf_mode5.mat'),'oo_','M_')};
plot_comparison(B,{'mode 5'},{'eps_zm2','eps_zm'}, ...
    {'Transitory target','Direct monetary'}, ...
    'Uribe-B: fixed-parameter IRFs', ...
    fullfile(P.uribe_B,'uribe_B_24_irfs.pdf'));
end

function plot_comparison(S,labels,shocks,shock_labels,title_text,output_file)
f = figure('Color','w','Name',title_text);
for j = 1:numel(shocks)
    for v = 1:4
        subplot(4,numel(shocks),(v-1)*numel(shocks)+j); hold on;
        for k = 1:numel(S)
            [x,~] = get_series(S{k},shocks{j},v);
            plot(0:numel(x)-1,x,'LineWidth',1.4,'DisplayName',labels{k});
        end
        yline(0,'k:'); grid on;
        if v == 1, title(shock_labels{j}); end
        if j == 1, ylabel(variable_label(v)); end
        if v == 4, xlabel('Quarters after shock'); end
        if v == 1 && j == numel(shocks), legend('Location','best'); end
    end
end
sgtitle(title_text);
save_figure(f,output_file);
end

function plot_one(S,shocks,shock_labels,title_text,output_file)
f = figure('Color','w','Name',title_text);
for j = 1:numel(shocks)
    for v = 1:4
        subplot(4,numel(shocks),(v-1)*numel(shocks)+j); hold on;
        [x,~] = get_series(S,shocks{j},v);
        plot(0:numel(x)-1,x,'LineWidth',1.5);
        yline(0,'k:'); grid on;
        if v == 1, title(shock_labels{j}); end
        if j == 1, ylabel(variable_label(v)); end
        if v == 4, xlabel('Quarters after shock'); end
    end
end
sgtitle(title_text);
save_figure(f,output_file);
end

function [x,raw] = get_series(S,shock,v)
raw = S.oo_.irfs;

switch v
    case 1
        field = ['gy_' shock];
        assert(isfield(raw,field),'IRF field %s was not found.',field);
        r = raw.(field)(:);
        ss = steady_value(S,'gy');
        x = cumsum(100*r/ss);
    case 2
        field = ['gpai_' shock];
        assert(isfield(raw,field),'IRF field %s was not found.',field);
        r = raw.(field)(:);
        ss = steady_value(S,'gpai');
        x = cumsum(400*r/ss);
    case 3
        field = ['girate_' shock];
        assert(isfield(raw,field),'IRF field %s was not found.',field);
        r = raw.(field)(:);
        ss = steady_value(S,'girate');
        x = cumsum(400*r/ss);
    case 4
        % Ex-ante real rate: nominal rate at t minus expected inflation at
        % t+1. This is the convention used in nk_irfs.m and in Figure 12.
        field_pi = ['gpai_' shock];
        field_i  = ['girate_' shock];
        assert(isfield(raw,field_pi),'IRF field %s was not found.',field_pi);
        assert(isfield(raw,field_i),'IRF field %s was not found.',field_i);
        response_pi = cumsum(400*raw.(field_pi)(:)/steady_value(S,'gpai'));
        response_i  = cumsum(400*raw.(field_i)(:)/steady_value(S,'girate'));
        x = response_i(1:end-1)-response_pi(2:end);
end
end

function value = steady_value(S,name)
names = cellstr(S.M_.endo_names);
idx = find(strcmp(strtrim(names),name),1);
if isempty(idx), error('Steady-state variable %s was not found.',name); end
value = S.oo_.steady_state(idx);
end

function label = variable_label(v)
labels = {'Product','Inflation','Nominal interest rate','Real interest rate'};
label = labels{v};
end

function save_figure(f,file)
outdir = fileparts(file);
if ~isfolder(outdir), mkdir(outdir); end
try
    exportgraphics(f,file,'ContentType','vector');
catch
    saveas(f,file);
end
end
