function fronts_profiles = soarc_processprofs(profile_index)
%% soarc_processprofs.m reads in all NetCDF profiles specified by the user index file
% This script requires the user to have run soarc_sortprofs.m before running
%
% The function is called from soarc_master.m
%
%
%
% title - soarc_getprofs
% vr - 1.0 author - rhijo/uob   date - 06/2019
%
%
%% Process Argo float data from a list of profiles specified by argo_getdata.m 

% Read in the index file output from soarc_sortprofs.m
f=fullfile(profile_index);
fid = fopen(f);
fullfile_root = textscan(fid,'%s %*d %*f %*f', 'Delimiter',',');
fclose(fid);

prof_index = fullfile_root{1}; %Chosen a small selection for quick testing

% Initialise arrays
LAT = [];
LON = [];
TIME = [];
PRES = [];
TEMP = [];
PSAL = [];

    % Loop to read all prof files
    for k = 1 : length(prof_index)

        % Scan folders for file list, and display
        file_list{k} = fullfile('dac',prof_index{k});
    
        % Test files are Argo Netcdf
               files_correct = false;

                nc = (regexp(file_list,'.nc'));

                find(~cellfun('isempty', nc));

        if (nc{k}>0)
           files_correct = true;
        end


            switch files_correct
                case false
                       % Do nothing
                case true

                % read netcdf files
                    ncid = netcdf.open(fullfile('dac',prof_index{k}),'NC_NOWRITE'); 

                %Read latitude and longitude coordinates
                    varid = netcdf.inqVarID(ncid,'LATITUDE');
                    LAT{k} = netcdf.getVar(ncid,varid,'double');

                    varid = netcdf.inqVarID(ncid,'LONGITUDE');
                    LON{k} = netcdf.getVar(ncid,varid,'double');

               % read profile datetime
                    % read argo baseline reference
                    varid = netcdf.inqVarID(ncid,'REFERENCE_DATE_TIME');
                    REF_DATE_TIME = netcdf.getVar(ncid,varid);
                    RDT=datenum(str2double(REF_DATE_TIME(1:4)),...
                     str2double(REF_DATE_TIME(5:6)),...
                     str2double(REF_DATE_TIME(7:8)),...
                     str2double(REF_DATE_TIME(9:10)),...
                     str2double(REF_DATE_TIME(11:12)),...
                     str2double(REF_DATE_TIME(13:14)));

                    % read relative time
                    varid = netcdf.inqVarID(ncid,'JULD');
                    JULD{k} = netcdf.getVar(ncid,varid,'double');

                    %Calc absolute time
                    TIME{k} = datetime(RDT + JULD{k}, 'ConvertFrom','datenum','Format','yyyyMMddHHmmss');

                    % Read in profile pressure measurements
                    varid = netcdf.inqVarID(ncid,'PRES');
                    PRES{k} = netcdf.getVar(ncid,varid,'double');

                    %Read in profile temperature measurements
                    varid = netcdf.inqVarID(ncid,'TEMP');
                    TEMP{k} = netcdf.getVar(ncid,varid,'double'); 

                    %Read in profile salinity measurements
                    varid = netcdf.inqVarID(ncid,'PSAL');
                    PSAL{k} = netcdf.getVar(ncid,varid,'double');


                % read in profile quality control flags
                % flags 1, 2 --> data is good
                % flags 3 - 9 --> data is not good

                % PRES
                    varid = netcdf.inqVarID(ncid,'PRES_QC');
                    PRES_QC{k} = netcdf.getVar(ncid,varid);
                    presqc=cellfun(@str2num,PRES_QC,'un',0);
                    isbadpqc = cellfun(@(x) x >=3,presqc,'un',0);

                % TEMP 
                    varid = netcdf.inqVarID(ncid,'TEMP_QC');
                    TEMP_QC{k} = netcdf.getVar(ncid,varid);                           
                    tempqc=cellfun(@str2num,TEMP_QC,'un',0);
                    isbadtqc = cellfun(@(x) x >=3,tempqc,'un',0);

                % PSAL
                    varid = netcdf.inqVarID(ncid,'PSAL_QC');
                    PSAL_QC{k} = netcdf.getVar(ncid,varid);
                    psalqc = cellfun(@str2num,PSAL_QC,'un',0);
                    isbadsqc = cellfun(@(x) x>=3, psalqc,'un',0);

                 netcdf.close(ncid);

            end 
    end


isbadpqc = cellfun(@(x) any(x==1),isbadpqc,'UniformOutput',false);
isbadtqc = cellfun(@(x) any(x==1),isbadtqc,'UniformOutput',false);
isbadsqc = cellfun(@(x) any(x==1),isbadsqc,'UniformOutput',false);
% Combine all returned bad qc flags (P,T,S) and remove flagged profiles
allbadqc = cellfun(@(x,y,z) any(x==1 | y==1 | z==1),isbadpqc,isbadtqc,isbadsqc,'UniformOutput',false);
for i = length(allbadqc):-1:1
    
        prof_index(allbadqc{i}) = [];
        LAT(allbadqc{i}) = [];
        LON(allbadqc{i}) = [];
        TIME(allbadqc{i}) = [];
        PRES(allbadqc{i}) = [];
        TEMP(allbadqc{i}) = [];
        PSAL(allbadqc{i}) = [];
        
end

% match cell array dimensions to account for multiprofiles
for i = numel(LAT):-1:1
    lat_dbl(1:numel(LAT{i}),i) = LAT{i};
    lon_dbl(1:numel(LON{i}),i) = LON{i};
    time_dbl(1:numel(TIME{i}),i) = TIME{i};
end

    LAT = num2cell(lat_dbl);
    LON = num2cell(lon_dbl);
    TIME = num2cell(time_dbl);

% Output profile data as structure
fronts_profiles = struct('profid',{prof_index}','lat',{LAT},'lon',{LON},...
    'time',{TIME},'pres',{PRES},'temp',{TEMP},'psal',{PSAL});


end





