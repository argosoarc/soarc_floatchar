%% SOARC master script
%
% title - soarc_master 
% vr - 1.0 author - rhijo/uob   date - 06/2019
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Run soarc_sortprofs
% Input profile index file from ftp.ifremer.fr/ifremer/argo
% Filter for desired profs
[profile_index] = soarc_sortprofs('ar_index_global_prof.txt');

%% Run soarc_processprofs
[fronts_profiles]=soarc_processprofs(profile_index);

%% Run soarc_fzlogical
[fronts_logical] = soarc_fzlogical(fronts_profiles);

%% Run soarc_fzclass
[fronts_char] = soarc_fzchar(fronts_logical,fronts_profiles);

%% Run soarc_ar_outfile.m
soarc_ar_outfile(fronts_char);

%% Run soarc_plotzones.m
% plot characterised float profiles
soarc_plotzones(fronts_char);