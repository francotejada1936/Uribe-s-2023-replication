function process_24_smoothed_inflation()
%PROCESS_24_SMOOTHED_INFLATION Save smoothed Dpai and accumulated inflation.
%
% Dynare's obs_dpi is measured in quarterly percentage points, whereas the
% observed series pai from read_data is annualized. Therefore the smoothed
% change is multiplied by four before it is accumulated into the inflation
% level.

P = project_paths();
data = load(fullfile(P.data_processed,'uribe_data_pp.mat'),'pai','date','T');
sets = { ...
    struct('name','Uribe-A mode 5','file',fullfile(P.uribe_A,'uribe_A_24_smoother_mode5.mat')), ...
    struct('name','Uribe-A mode 6','file',fullfile(P.uribe_A,'uribe_A_24_smoother_mode6.mat')), ...
    struct('name','Uribe-A MH mean','file',fullfile(P.uribe_A,'uribe_A_24_smoother_mh_mean.mat')), ...
    struct('name','Uribe-B mode 5','file',fullfile(P.uribe_B,'uribe_B_24_smoother_mode5.mat'))};

all_rows = table();
for j = 1:numel(sets)
    S = load(sets{j}.file,'oo_');
    smoothed = S.oo_.SmoothedVariables;
    if isstruct(smoothed)
        dpi = smoothed.obs_dpi(:);
    else
        error('Unexpected Dynare smoother format in %s.',sets{j}.file);
    end
    N = min([numel(dpi),numel(data.pai),numel(data.date)]);
    dpi_quarterly = dpi(1:N);
    dpi_annualized = 4*dpi_quarterly;
    pai_smooth = data.pai(1) + [0; cumsum(dpi_annualized(1:N-1))];
    block = table(repmat(string(sets{j}.name),N,1), ...
                  data.date(1:N), dpi_annualized, dpi_quarterly, pai_smooth, ...
        'VariableNames',{'parameterization','date','smoothed_dpi', ...
                         'smoothed_dpi_quarterly','smoothed_pai'});
    if isempty(all_rows)
        all_rows = block;
    else
        all_rows = [all_rows; block]; %#ok<AGROW>
    end
end

writetable(all_rows,fullfile(P.results,'uribe_24_smoothed_inflation.csv'));
save(fullfile(P.results,'uribe_24_smoothed_inflation.mat'),'all_rows');

f = figure('Color','w','Name','Smoothed inflation');
names = unique(all_rows.parameterization,'stable');

subplot(2,1,1);
plot(data.date,data.pai,'k:','LineWidth',1.1);
hold on;
for j = 1:numel(names)
    rows = all_rows.parameterization == names(j);
    plot(all_rows.date(rows),all_rows.smoothed_pai(rows),'LineWidth',1.2, ...
         'DisplayName',names(j));
end
grid on; xlabel('Date'); ylabel('Annualized inflation (%)');
title('Observed and smoothed inflation');
legend([{'Observed'},cellstr(names')],'Location','best');

subplot(2,1,2);
hold on;
for j = 1:numel(names)
    rows = all_rows.parameterization == names(j);
    plot(all_rows.date(rows),all_rows.smoothed_dpi(rows),'LineWidth',1.2, ...
         'DisplayName',names(j));
end
yline(0,'k:');
grid on; xlabel('Date'); ylabel('Annualized percentage points');
title('Smoothed change in inflation');
legend(cellstr(names'),'Location','best');
exportgraphics(f,fullfile(P.results,'uribe_24_smoothed_inflation.pdf'), ...
               'ContentType','vector');
end
