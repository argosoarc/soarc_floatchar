function [fileout,driver] = soarc_sortprofs(EXPID)
%
% soarc_sortprofs filters all *real-time* argo profiles at a latitude 
% greater than 30 degrees south by user-defined latitude/longitude/time
% 
% The function is called from soarc_master.m
%
% Requires driver file (example provided with soarc_argo package)
%
%
% 
% title - soarc_sortprofs
% vr - 1.0 author - rhijo/uob - date - 06/2019
%
%
%% User - enter the parameter driver file
driver = 'soarc_param_driver_userexample.txt';

%% Filter index file for floats greater than 30 degrees South

dum_expID = EXPID;

% read in index file ar_index_global_prof.txt
fid=fopen('ar_index_global_prof.txt');
[P]=textscan(fid,'%s %f %f %f %*s %*f %*s %*f','HeaderLines',9,'Delimiter',',','CollectOutput',true);
fclose(fid);

%Search and remove profiles greater than -30 degrees latitude
profID = P{1};
d = P{2};%(:,1);

idx = any(d(:,2) > -30,2);
d(idx,:)=[];
profID(idx,:)=[];

%Search and remove any NaN from lat/lon column
profID(any(isnan(d),2),:) = [];
d(any(isnan(d),2),:) = [];

%Return cell array for all columns to write file
dln_cell = num2cell(d);
prof_dln = [profID dln_cell];

%Write new index file - all profile indexes for Southern Ocean floats
so_filename = ['ar_index_soarc_',datestr(now,'ddmmyy'),'.txt'];
fileID = fopen(so_filename,'w');
 
formatSpec = '%s, %d, %f, %f \n';
 
[nrows, ncols ] = size(prof_dln);
for row = 1:nrows
fprintf(fileID, formatSpec, prof_dln{row,:});
end
fclose(fileID);

%% Open the Southern Ocean float file

fid=fopen(so_filename);
[S]=textscan(fid,'%s %{yyyyMMddHHmmss}D %f %f','Delimiter',',','CollectOutput',true);
fclose(fid);

%Create arrays of index, date, lat, lon
prof = S{1};
date = S{2};
lat = S{3}(:,1);
lon = S{3}(:,2);

% Option to split profiles by longitude
param_input = 'Would you like to read in a driver file for lat/lon/year? Y/N:';
str = input(param_input,'s');

% Filter profiles based on user input file

    if isequal (str,'Y')
        
        fid = fopen(driver);
        [d] = textscan(fid,'%s %f','Delimiter','\t','CollectOutput',true);
        fclose(fid);
        val = d{2};
 
        % filter latitude
        lat_lower = val(1);
        lat_upper = val(2);
        idx_b = lat < lat_lower | lat > lat_upper;
            lon(idx_b) = [];
            lat(idx_b) = [];
            prof(idx_b) = [];
            date(idx_b) = [];       
        
        % filter longitude
        lon_lower = val(3);
        lon_upper = val(4);
                    
        idx_a = lon < lon_lower | lon > lon_upper;
            lon(idx_a) = [];
            lat(idx_a) = [];
            prof(idx_a) = [];
            date(idx_a) = [];
        
        % filter year
        yr_start = val(5);
        yr_end = val(6);
        
        idx_c = date.Year < yr_start | date.Year > yr_end;   
            lon(idx_c) = [];
            lat(idx_c) = [];
            prof(idx_c) = [];
            date(idx_c) = [];
            
        % filter month    
        month_start = val(7);
        month_end = val(8);
        
        idx_d = date.Month < month_start | date.Month > month_end;
            lon(idx_d) = [];
            lat(idx_d) = [];
            prof(idx_d) = [];
            date(idx_d) = [];
            
    elseif isequal(str,'N')
        % Do nothing
    end

% format for file write
lat = num2cell(lat);
lon = num2cell(lon);
dat = cellstr(date);
user_profdln = [prof dat lat lon];

% create filtered SO profile index file
fileout = ['ar_index_realtimeSO_' driver];
fileID = fopen(fileout,'w');
 
formatSpec = '%s, %s, %3.2f, %3.2f \n';
 
[nrows, ncols ] = size(user_profdln);

 % write profiles to file
for row = 1:nrows

    fprintf(fileID, formatSpec, user_profdln{row,:});

end

fclose(fileID);

end