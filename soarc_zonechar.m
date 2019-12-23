function [fronts_char] = soarc_zonechar(fronts_logical,fronts_profiles)
% The function is called from soarc_master.m
% title - soarc_zonechar
% vr - 1.0  author - rhijo/uob   date - 06/2019
%
% this function takes the structural arrays fronts_logical and
% fronts_profiles and characterises profile data into zones

%% characterise zones
% STZ
index_unclass = fronts_logical.index_unclass;
index_stz = fronts_logical.index_stz;

for i = 1 : length(fronts_logical.proflist)
    if (index_stz{i} == 1 && index_unclass{i} ~= 1)
            stz_prof{i} = fronts_logical.proflist{i};
            stz_lat{:,i} = fronts_profiles.lat{:,i};
            stz_lon{:,i} = fronts_profiles.lon{:,i};
            stz_time{:,i} = fronts_profiles.time{:,i};
            stz_pres{i} = fronts_profiles.pres{i};
            stz_psal{i} = fronts_profiles.psal{i};
            stz_temp{i} = fronts_profiles.temp{i};
        
            stz_prof = stz_prof(~cellfun(@isempty,stz_prof));
            stz_lat = stz_lat(~cellfun(@isempty,stz_lat));
            stz_lon = stz_lon(~cellfun(@isempty,stz_lon));
            stz_time = stz_time(~cellfun(@isempty,stz_time));
            stz_pres = stz_pres(~cellfun(@isempty,stz_pres));
            stz_psal = stz_psal(~cellfun(@isempty,stz_psal));
            stz_temp = stz_temp(~cellfun(@isempty,stz_temp));
            
        fronts_char.stz = struct('stf',stz_prof,'lat',stz_lat,'lon',stz_lon,...
            'time',stz_time,'pres',stz_pres,'psal',stz_psal,'temp',stz_temp);
 
    end
end

         
% SAZ
index_saz = fronts_logical.index_saz;
for i = 1 : length(fronts_logical.proflist)
    if (index_saz{i} == 1 && index_unclass{i} ~= 1)
            saz_prof{i} = fronts_logical.proflist{i};
            saz_lat{:,i} = fronts_profiles.lat{:,i};
            saz_lon{:,i} = fronts_profiles.lon{:,i};
            saz_time{:,i} = fronts_profiles.time{:,i};
            saz_pres{i} = fronts_profiles.pres{i};
            saz_psal{i} = fronts_profiles.psal{i};
            saz_temp{i} = fronts_profiles.temp{i}; 

            saz_prof = saz_prof(~cellfun(@isempty,saz_prof));
            saz_lat = saz_lat(~cellfun(@isempty,saz_lat));
            saz_lon = saz_lon(~cellfun(@isempty,saz_lon));
            saz_time = saz_time(~cellfun(@isempty,saz_time));
            saz_pres = saz_pres(~cellfun(@isempty,saz_pres));
            saz_psal = saz_psal(~cellfun(@isempty,saz_psal));
            saz_temp = saz_temp(~cellfun(@isempty,saz_temp));
            
        fronts_char.saz = struct('saz',saz_prof,'lat',saz_lat,'lon',saz_lon,...
            'time',saz_time,'pres',saz_pres,'psal',saz_psal,'temp',saz_temp);
         
    end
end   


% PZ
index_pz = fronts_logical.index_pz;
for i = 1 : length(fronts_logical.proflist)
    if (index_pz{i} == 1 && index_unclass{i} ~= 1)
            pz_prof{i} = fronts_logical.proflist{i};
            pz_lat{:,i} = fronts_profiles.lat{:,i};
            pz_lon{:,i} = fronts_profiles.lon{:,i};
            pz_time{:,i} = fronts_profiles.time{:,i};
            pz_pres{i} = fronts_profiles.pres{i};
            pz_psal{i} = fronts_profiles.psal{i};
            pz_temp{i} = fronts_profiles.temp{i}; 

            pz_prof = pz_prof(~cellfun(@isempty,pz_prof));
            pz_lat = pz_lat(~cellfun(@isempty,pz_lat));
            pz_lon = pz_lon(~cellfun(@isempty,pz_lon));
            pz_time = pz_time(~cellfun(@isempty,pz_time));
            pz_pres = pz_pres(~cellfun(@isempty,pz_pres));
            pz_psal = pz_psal(~cellfun(@isempty,pz_psal));
            pz_temp = pz_temp(~cellfun(@isempty,pz_temp));
                   
        fronts_char.pz = struct('pz',pz_prof,'lat',pz_lat,'lon',pz_lon,...
            'time',pz_time,'pres',pz_pres,'psal',pz_psal,'temp',pz_temp);

    end
end


% AZ
index_az = fronts_logical.index_az;
for i = 1 : length(fronts_logical.proflist)
    if (index_az{i} == 1 && index_unclass{i} ~= 1)
            az_prof{i} = fronts_logical.proflist{i};
            az_lat{:,i} = fronts_profiles.lat{:,i};
            az_lon{:,i} = fronts_profiles.lon{:,i};
            az_time{:,i} = fronts_profiles.time{:,i};
            az_pres{i} = fronts_profiles.pres{i};
            az_psal{i} = fronts_profiles.psal{i};
            az_temp{i} = fronts_profiles.temp{i}; 
       
            az_prof = az_prof(~cellfun(@isempty,az_prof));
            az_lat = az_lat(~cellfun(@isempty,az_lat));
            az_lon = az_lon(~cellfun(@isempty,az_lon));
            az_time = az_time(~cellfun(@isempty,az_time));
            az_pres = az_pres(~cellfun(@isempty,az_pres));
            az_psal = az_psal(~cellfun(@isempty,az_psal));
            az_temp = az_temp(~cellfun(@isempty,az_temp));
            
        fronts_char.az = struct('az',az_prof,'lat',az_lat,'lon',az_lon,...
            'time',az_time,'pres',az_pres,'psal',az_psal,'temp',az_temp);  
        
    end     
end 


% SZ
index_sz = fronts_logical.index_sz;
for i = 1 : length(fronts_logical.proflist)
    if (index_sz{i} == 1 && index_unclass{i} ~= 1)
            sz_prof{i} = fronts_logical.proflist{i};
            sz_lat{:,i} = fronts_profiles.lat{:,i};
            sz_lon{:,i} = fronts_profiles.lon{:,i};
            sz_time{:,i} = fronts_profiles.time{:,i};
            sz_pres{i} = fronts_profiles.pres{i};
            sz_psal{i} = fronts_profiles.psal{i};
            sz_temp{i} = fronts_profiles.temp{i};
            
            sz_prof = sz_prof(~cellfun(@isempty,sz_prof));
            sz_lat = sz_lat(~cellfun(@isempty,sz_lat));
            sz_lon = sz_lon(~cellfun(@isempty,sz_lon));
            sz_time = sz_time(~cellfun(@isempty,sz_time));
            sz_pres = sz_pres(~cellfun(@isempty,sz_pres));
            sz_psal = sz_psal(~cellfun(@isempty,sz_psal));
            sz_temp = sz_temp(~cellfun(@isempty,sz_temp));         
            
        fronts_char.sz = struct('sz',sz_prof,'lat',sz_lat,'lon',sz_lon,...
            'time',sz_time,'pres',sz_pres,'psal',sz_psal,'temp',sz_temp);      
    end
end


% SPR
index_spr = fronts_logical.index_spr;
for i = 1 : length(fronts_logical.proflist)
    if (index_spr{i} == 1 && index_unclass{i} ~= 1)
            spr_prof{i} = fronts_logical.proflist{i};
            spr_lat{:,i} = fronts_profiles.lat{:,i};
            spr_lon{:,i} = fronts_profiles.lon{:,i};
            spr_time{:,i} = fronts_profiles.time{:,i};
            spr_pres{i} = fronts_profiles.pres{i};
            spr_psal{i} = fronts_profiles.psal{i};
            spr_temp{i} = fronts_profiles.temp{i}; 

            spr_prof = spr_prof(~cellfun(@isempty,spr_prof));
            spr_lat = spr_lat(~cellfun(@isempty,spr_lat));
            spr_lon = spr_lon(~cellfun(@isempty,spr_lon));
            spr_time = spr_time(~cellfun(@isempty,spr_time));
            spr_pres = spr_pres(~cellfun(@isempty,spr_pres));
            spr_psal = spr_psal(~cellfun(@isempty,spr_psal));
            spr_temp = spr_temp(~cellfun(@isempty,spr_temp));
            
        fronts_char.spr = struct('spr',spr_prof,'lat',spr_lat,'lon',spr_lon,...
            'time',spr_time,'pres',spr_pres,'psal',spr_psal,'temp',spr_temp);

   end
end


%% characterise the profiles that fit into more than one front/zone
for i = 1 : length(fronts_logical.proflist)
    if index_unclass{i} == 1
       
        unclass_prof{i} = fronts_logical.proflist{i};
        unclass_lat{:,i} = fronts_profiles.lat{:,i};
        unclass_lon{:,i} = fronts_profiles.lon{:,i};
        unclass_time{:,i} = fronts_profiles.time{:,i};
        unclass_pres{i} = fronts_profiles.pres{i};
        unclass_psal{i} = fronts_profiles.psal{i};
        unclass_temp{i} = fronts_profiles.temp{i}; 

        unclass_prof = unclass_prof(~cellfun(@isempty,unclass_prof));
        unclass_lat = unclass_lat(~cellfun(@isempty,unclass_lat));
        unclass_lon = unclass_lon(~cellfun(@isempty,unclass_lon));
        unclass_time = unclass_time(~cellfun(@isempty,unclass_time));
        unclass_pres = unclass_pres(~cellfun(@isempty,unclass_pres));
        unclass_psal = unclass_psal(~cellfun(@isempty,unclass_psal));
        unclass_temp = unclass_temp(~cellfun(@isempty,unclass_temp));
            
        fronts_char.unclass = struct('unclass',unclass_prof,'lat',...
            unclass_lat,'lon',unclass_lon,'time',unclass_time,'pres',...
            unclass_pres,'psal',unclass_psal,'temp',unclass_temp);

    end
end
 
%% characterise the profiles that fit into no category
index_noclass = fronts_logical.index_noclass;
for i = 1 : length(fronts_logical.proflist)
    if index_noclass{i} == 1
        noclass_prof{i} = fronts_logical.proflist{i};
        noclass_lat{:,i} = fronts_profiles.lat{:,i};
        noclass_lon{:,i} = fronts_profiles.lon{:,i};
        noclass_time{:,i} = fronts_profiles.time{:,i};
        noclass_pres{i} = fronts_profiles.pres{i};
        noclass_psal{i} = fronts_profiles.psal{i};
        noclass_temp{i} = fronts_profiles.temp{i}; 

        noclass_prof = noclass_prof(~cellfun(@isempty,noclass_prof));
        noclass_lat = noclass_lat(~cellfun(@isempty,noclass_lat));
        noclass_lon = noclass_lon(~cellfun(@isempty,noclass_lon));
        noclass_time = noclass_time(~cellfun(@isempty,noclass_time));
        noclass_pres = noclass_pres(~cellfun(@isempty,noclass_pres));
        noclass_psal = noclass_psal(~cellfun(@isempty,noclass_psal));
        noclass_temp = noclass_temp(~cellfun(@isempty,noclass_temp));

        fronts_char.noclass = struct('noclass',noclass_prof,'lat',...
            noclass_lat,'lon',noclass_lon,'time',noclass_time,'pres',...
            noclass_pres,'psal',noclass_psal,'temp',noclass_temp);
        
    end
end                   

end
 
