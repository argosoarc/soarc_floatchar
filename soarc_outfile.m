function [] = soarc_ar_outfile(fronts_char)
% title - soarc_fzchar
% vr - 1.0  author - rhijo/uob   date - 06/2019
%
% The function is called from soarc_master.m
% Create output index file for characterised float profiles from
% soarc_master
% 
%% Save characterised index file
% write file to working directory dated today
version = 'v1.0';
filename = ['ar_index_soarc_char_',version,'_',datestr(now,'ddmmyy'),'.txt'];
fid = fopen(filename,'at');
str = 'Title: Profile directory file of Southern Ocean Argo data';
dt = ['Date of creation: ',datestr(now,'dd-mm-yy')];
cdsrc = 'Code source: github.com/argosoarc/soarc_floatchar';
vno = 'Version number: V1';
auth = 'Rhiannon Jones, UoB';
format = 'Format: file/latitude/longitude/date(yyyyMMddHHmmss)/zone';

% write file header
fprintf(fid, '%s\n %s\n %s\n %s\n %s\n %s\n',str,dt,cdsrc,vno,auth,format);

%% write zone structures to index file
% STZ
if isfield(fronts_char,'stz')
    for i = 1 : numel(fronts_char.stz)
        fronts_stz{i} = struct2cell(fronts_char.stz(i));
        if ~isempty(fronts_stz{i}(1))
        fprintf(fid,'%s,%3.2f,%3.2f,%s,%s \n',fronts_stz{i}{1:4},'STZ');
        end
    end
end

% SAZ
    if isfield(fronts_char,'saz')
        for i = 1 : numel(fronts_char.saz)
            fronts_saz{i} = struct2cell(fronts_char.saz(i));
            if ~isempty(fronts_saz{i}(1))
            fprintf(fid,'%s,%3.2f,%3.2f,%s, %s \n',fronts_saz{i}{1:4},'SAZ');
            end
        end
    end
    
% PZ
if isfield(fronts_char,'pz')
    for i = 1 : numel(fronts_char.pz)
        fronts_pz{i} = struct2cell(fronts_char.pz(i));        
        if ~isempty(fronts_pz{i}(1))
        fprintf(fid,'%s,%3.2f,%3.2f,%s, %s \n',fronts_pz{i}{1:4},'PZ');
        end            
    end
end

% AZ
if isfield(fronts_char,'az')
    for i = 1 : numel(fronts_char.az)
        fronts_az{i} = struct2cell(fronts_char.az(i));        
        if ~isempty(fronts_az{i}(1))
        fprintf(fid,'%s,%3.2f,%3.2f,%s, %s \n',fronts_az{i}{1:4},'AZ');
        end            
    end
end

% SZ
if isfield(fronts_char,'sz')
    for i = 1 : numel(fronts_char.sz)
        fronts_sz{i} = struct2cell(fronts_char.sz(i));        
        if ~isempty(fronts_sz{i}(1))
        fprintf(fid,'%s,%3.2f,%3.2f,%s, %s \n',fronts_sz{i}{1:4},'SZ');
        end
    end
end
    
% SPR
if isfield(fronts_char,'spr')
    for i = 1 : numel(fronts_char.spr)
        fronts_spr{i} = struct2cell(fronts_char.spr(i));
        if ~isempty(fronts_spr{i}(1))
        fprintf(fid,'%s,%3.2f,%3.2f,%s, %s \n',fronts_spr{i}{1:4},'SPR');
        end
    end
end

% Uncharacterised profiles
if isfield(fronts_char,'unclass')
    for i = 1 : numel(fronts_char.unclass)
        fronts_unchar{i} = struct2cell(fronts_char.unclass(i));
        if ~isempty(fronts_unchar{i}(1))
        fprintf(fid,'%s,%3.2f,%3.2f,%s, %s \n',fronts_unchar{i}{1:4},'UNCHAR');
        end
    end
end

% Non-characterised profiles
if isfield(fronts_char,'noclass')
    for i = 1 : numel(fronts_char.noclass)
        fronts_nochar{i} = struct2cell(fronts_char.noclass(i));
        if ~isempty(fronts_nochar{i}(1))
        fprintf(fid,'%s,%3.2f,%3.2f,%s, %s \n',fronts_nochar{i}{1:4},'NOCHAR');
        end
    end
end

fid = fclose(fid);

end
