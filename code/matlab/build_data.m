function build_data
%BUILD_DATA Construct the three TP3 observables from the original Excel data.
%
% The raw Excel files remain in data/raw. The processed MATLAB file is
% written to data/processed so every Dynare file can use the same input.

matlab_dir = fileparts(mfilename('fullpath'));
P = project_paths();
raw_dir = P.data_raw;
processed_dir = P.data_processed;

if ~isfolder(processed_dir)
    mkdir(processed_dir);
end

addpath(matlab_dir);
old_dir = pwd;
cleanup = onCleanup(@() cd(old_dir));
cd(raw_dir);

[Dy,Dpai,Dff,y,pai,ff,date,readme_data] = read_data(2018.25);

% obs_dy: quarterly output growth, in percentage points, demeaned.
obs_dy = Dy - mean(Dy);

% r and Dff are annualized percentage rates in the original data.
% Divide by four to express them as quarterly percentage points.
r = ff-pai;
obs_r  = (r-mean(r))/4;
obs_di = (Dff-mean(Dff))/4;

% The change in inflation is constructed but not included as an estimated
% observable, as required by the TP3.
obs_dpi = Dpai/4;

Y = [obs_dy obs_r obs_di];
meanY = mean(Y)';
stdY  = std(Y)';
varY  = var(Y)';
T     = size(Y,1);

save(fullfile(processed_dir,'uribe_data_pp.mat'), ...
     'Y','obs_dy','obs_r','obs_di','obs_dpi', ...
     'Dy','Dpai','Dff','r','y','pai','ff','date', ...
     'meanY','stdY','varY','T','readme_data');

fprintf('Processed data saved to %s\n', ...
        fullfile(processed_dir,'uribe_data_pp.mat'));
end
