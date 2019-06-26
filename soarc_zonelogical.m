function [fronts_logical] = soarc_zonelogical(fronts_profiles)
%% soarc_fzlogical.m characterises the Southern Ocean fronts and zones and returns a logical array
%% for those floats that satisfy a front/zone classification
%
% The function is called from soarc_master.m
% Requires fronts_profiles structure to be in workspace before running
%
% title - soarc_zonelogical
% vr - 1.0 author - rhijo/uob - date - 06/2019
%
%
%% Set up criteria for Argo float characterisation of the ACC fronts and zones
%  Delineates the following fronts:
%  Subtropical front (STF)
%  Sub-Antarctic zone (SAZ)
%  Sub-Antarctic front (SAF)
%  Polar Frontal Zone (PZ)
%  Polar front (PF)
%  Antarctic Zone (AZ)
%  Southern Antarctic Circumpolar Current Front (SACCF)
%  Southern Zone (SZ)
%  Southern Boundary current (SBDY)
%  Subpolar region?
%  Antarctic slope front?
%  Unclassified - satisfies more than one characterisation criteria
%  No class - satisifes no characterisation criteria
%  Define based on T / S with P
%
%
%% User - Define front/zone characterisation 

%% STZ
% Orsi1995
stz_p  = 105; % pressure
stz_t_lb = 11.5; % temp
stz_s_lb = 35.05;% salinity lower bound

%% SAZ characterisation
% S < 34.55 at 100 dbar
% T > 6.85 at 400 dbar
sazs_ub = 34.6;
sazs_ub_pub = 105;

sazt_lb = 6.85;
sazt_lb_pub = 405;

%% PZ characterisation
% T < 2.63 at 400 dbar
% T < 2 at 200 dbar
pzt_ub = 2.63;
pzt_ub_pub = 405;
pzt_ub_plb = 395;

pzt_lb = 2;
pzt_lb_pub = 205;
pzt_lb_plb = 195;

%% AZ characterisation
% T > 1.8 at 500 dbar
% T < 2 at 200 dbar

az_lb = 1.8; 
az_lb_plb = 490; 
az_lb_pub = 510; 

az_ub = 2; 
az_ub_plb = 190; 
az_ub_pub = 210; 

%% SZ characterisation
% T > -0.66 at Tmin
% T < ~1.8 at 500 dbar
szt_lb = -0.66;
szt_ub = 1.75;
szt_ub_plb = 490;
szt_ub_pub = 510;

%% Subpolar region
% Tmin <= -1.24 C
spr_tmin_max = -1.24;

%% Create logical structure for zones
% initialise structure with profile list
[fronts_logical.proflist] = fronts_profiles.profid;

%% STZ
% return logical arrays for profiles that satisfy P-S conditions
fun_stz_sp = cellfun(@(x,y) (x <= stz_p & y >= stz_s_lb), fronts_profiles.pres, fronts_profiles.psal, 'un', 0);

fun_stz_tp = cellfun(@(x,y) (x <= stz_p & y >= stz_t_lb), fronts_profiles.pres, fronts_profiles.temp, 'un', 0);
% return logical array for both conditions as true
fun_stz = cellfun(@(x,y) any(x==1 & y==1),fun_stz_sp,fun_stz_tp,'un',0); 
isstz = cellfun(@(x) any(x) >= 1, fun_stz, 'un', 0);

    [fronts_logical(:).index_stz] = isstz;

%% SAZ
% Return logical arrays for profiles that satisfy P-T conditions
fun_saz_s = cellfun(@(x,y) any(x < sazs_ub & y <= sazs_ub_pub) ,...
    fronts_profiles.psal, fronts_profiles.pres,'un',0);

% Return logical arrays for profiles that satisfy P-T conditions
fun_saz_t = cellfun(@(x,y) any(x > sazt_lb & y <= sazt_lb_pub),...
    fronts_profiles.temp, fronts_profiles.pres,'un',0);

%Return logical array for both conditions as true
fun_saz = cellfun(@(x,y) x==1 & y==1, fun_saz_s, fun_saz_t,'un',0);
issaz = cellfun(@(x) sum(x) >= 1, fun_saz, 'un', 0);

% Create structure of saz profiles
    [fronts_logical(:).index_saz] = issaz;

%% PZ
% Return logical arrays for profiles that satisfy P-T conditions
fun_pz_ub = cellfun(@(x,y) any(x < pzt_ub & (y >= pzt_ub_plb & y <= pzt_ub_pub)),...
    fronts_profiles.temp, fronts_profiles.pres, 'un',0);
fun_pz_lb = cellfun(@(x,y) any(x > pzt_lb & (y >= pzt_lb_plb & y <= pzt_lb_pub)),...
    fronts_profiles.temp, fronts_profiles.pres, 'un',0);

% return logical array
fun_pz = cellfun(@(x,y) x==1 & y==1, fun_pz_ub, fun_pz_lb, 'un',0);
ispz = cellfun(@(x) sum(x) >= 1, fun_pz, 'un', 0);
        
% create structure with array length matching prof index length
    [fronts_logical(:).index_pz] = ispz;
       
%% AZ - Antarctic Zone

% Return logical array in which profiles satisfy P-T conditions
fun_az_lb = cellfun(@(x,y) any(x > az_lb & (y >= az_lb_plb & y <= az_lb_pub)),...
    fronts_profiles.temp, fronts_profiles.pres,'un',0);
fun_az_ub = cellfun(@(x,y) any(x < az_ub & (y >= az_ub_plb & y <= az_ub_pub)),...
    fronts_profiles.temp, fronts_profiles.pres,'un',0);

%Return logical array for both conditions as true

fun_az = cellfun(@(x,y) x==1 & y==1, fun_az_lb, fun_az_ub, 'un',0);
isaz = cellfun(@(x) sum(x) >= 1, fun_az, 'un', 0);

% logical array in structure
    [fronts_logical(:).index_az] = isaz;


%% SZ - Southern Zone
% Return logical array in which profiles satisfy P-T conditions
fun_szt_lb = cellfun(@(x,y) any(min(x) >= szt_lb), fronts_profiles.temp,'un',0);
fun_szt_ub = cellfun(@(x,y) any(x <= szt_ub & (y >= szt_ub_plb & y <= szt_ub_pub)),...
    fronts_profiles.temp, fronts_profiles.pres,'un',0);

%Return logical array for both conditions as true
fun_sz = cellfun(@(x,y) x==1 & y==1, fun_szt_lb, fun_szt_ub, 'un',0);
issz = cellfun(@(x) sum(x) >= 1, fun_sz, 'un', 0);

% logical array in structure
    [fronts_logical(:).index_sz] = issz;

%% SPR - Subpolar region
fun_spr = cellfun(@(x) any(x < spr_tmin_max), fronts_profiles.temp, 'un', 0);
isspr = cellfun(@(x) sum(x) == 1, fun_spr, 'un', 0);

% logical array in structure
    [fronts_logical(:).index_spr] = isspr;

%% Unclassified
% Find profiles that satisfy > 1 (unclass) or zero (noclass) front/zone
% conditions
isunclass = cell(1, length(fronts_profiles.profid));
isnoclass = cell(1, length(fronts_profiles.profid));

    for i = 1 : length(fronts_profiles.profid)
        isanyfz{i} = (isstz{i} + issaz{i} + ispz{i} + isaz{i} + issz{i}...
            + isspr{i});
    end  
    
isunclass = cellfun(@(x) sum(x) > 1, isanyfz,'un',0);
        
isnoclass = cellfun(@(x) sum(x) == 0, isanyfz,'un',0);
        
% logical array in structure
    [fronts_logical(:).index_unclass] = isunclass;
    
    [fronts_logical(:).index_noclass] = isnoclass;


end