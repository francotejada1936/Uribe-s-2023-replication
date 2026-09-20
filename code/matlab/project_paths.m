function P = project_paths()
%PROJECT_PATHS Return absolute paths used by the reproducible TP3 package.

here = fileparts(mfilename('fullpath'));
% This file lives in <package>/code/matlab.  Starting from that directory,
% two parent folders lead to the package root: matlab -> code -> package.
P.root = fileparts(fileparts(here));
P.dynare = fullfile(P.root,'code','dynare');
P.matlab = fullfile(P.root,'code','matlab');
P.data_raw = fullfile(P.root,'data','raw');
P.data_processed = fullfile(P.root,'data','processed');
P.results = fullfile(P.root,'results');
P.initial_irf = fullfile(P.results,'initial_irf');
P.uribe_A = fullfile(P.results,'uribe_A');
P.uribe_B = fullfile(P.results,'uribe_B');

addpath(P.matlab);
end
