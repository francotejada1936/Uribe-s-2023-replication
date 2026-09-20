function save_24_variance_decomposition()
%SAVE_24_VARIANCE_DECOMPOSITION Save the requested variance decompositions.
%
% The decomposed variables are gy, gpai and girate: respectively the change
% in product, inflation and the nominal interest rate in the exact model.

P = project_paths();
sets = { ...
    struct('model','Uribe-A','parameterization','mode 5','file',fullfile(P.uribe_A,'uribe_A_24_irf_mode5.mat')), ...
    struct('model','Uribe-A','parameterization','mode 6','file',fullfile(P.uribe_A,'uribe_A_24_irf_mode6.mat')), ...
    struct('model','Uribe-A','parameterization','MH posterior mean','file',fullfile(P.uribe_A,'uribe_A_24_irf_mh_mean.mat')), ...
    struct('model','Uribe-B','parameterization','mode 5','file',fullfile(P.uribe_B,'uribe_B_24_irf_mode5.mat'))};
target_names = {'gy','gpai','girate'};
rows = table();

for j = 1:numel(sets)
    S = load(sets{j}.file,'oo_','M_');
    VD = S.oo_.variance_decomposition;
    endo = cellstr(S.M_.endo_names);
    exo = cellstr(S.M_.exo_names);
    for v = 1:numel(target_names)
        i = find(strcmp(strtrim(endo),target_names{v}),1);
        if isempty(i), error('Variable %s not found.',target_names{v}); end
        for e = 1:numel(exo)
            block = table(string(sets{j}.model), ...
                string(sets{j}.parameterization), string(target_names{v}), ...
                string(strtrim(exo{e})), VD(i,e), ...
                'VariableNames',{'model','parameterization','variable','shock','share'});
            if isempty(rows)
                rows = block;
            else
                rows = [rows; block]; %#ok<AGROW>
            end
        end
    end
end

out = fullfile(P.results,'uribe_24_variance_decomposition.csv');
writetable(rows,out);
save(fullfile(P.results,'uribe_24_variance_decomposition.mat'),'rows');

% Compact graphical version: one panel for each parameterization.
f = figure('Color','w','Name','Variance decomposition');
for j = 1:numel(sets)
    subplot(2,2,j);
    mask = rows.model == string(sets{j}.model) & ...
           rows.parameterization == string(sets{j}.parameterization);
    block = rows(mask,:);
    vars = unique(block.variable,'stable');
    shocks = unique(block.shock,'stable');
    B = zeros(numel(vars),numel(shocks));
    for v = 1:numel(vars)
        for e = 1:numel(shocks)
            hit = block.variable == vars(v) & block.shock == shocks(e);
            B(v,e) = block.share(find(hit,1));
        end
    end
    bar(B,'stacked'); grid on; ylim([0 100]);
    title([sets{j}.model ' — ' sets{j}.parameterization]);
    xticklabels({'\Delta output','\Delta inflation','\Delta nominal rate'});
    if j == 1, ylabel('Percent of variance'); end
    if j == numel(sets), legend(cellstr(shocks),'Location','bestoutside'); end
end
exportgraphics(f,fullfile(P.results,'uribe_24_variance_decomposition.pdf'), ...
               'ContentType','vector');
end
