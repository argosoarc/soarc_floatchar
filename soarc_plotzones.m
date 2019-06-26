function[] = soarc_plotzones(fronts_char)
%
%
% The function is called from soarc_master.m
%
%
% title - soarc_plotfronts vr - 1.0 author - rhijo/uob - date - 06/2019
%
% V1.0
%e.g.
%m_proj('equid','lon',[min(X) max(X)]+[-1 1],'lat',[min(Y) max(Y)]+[-1 1]/2);

%% Plot profiles
% read in driver file for lat / lon / time limits
path = 'argo_work';
paramfile = 'soarc_param_driver_3060S_00360E_012017.txt';
 fid = fopen(fullfile(path,paramfile));
    [d] = textscan(fid,'%s %f','Delimiter','\t','CollectOutput',true);
    fclose(fid);

% get values
val = d{2};
        
lat_min = val(1);
lat_max = val(2);
lon_min = val(3);
lon_max = val(4);
yr_min = val(5);
yr_max = val(6);
mth_min = val(7);
mth_max = val(8);

% set projection (using m_map toolbox)

% draw plot
% fullscreen
figure('units','normalized','outerposition',[0 0 1 1]);

%set projection (using m_map toolbox)

% Lamber Conformal Conic - good for longitude sections
%m_proj('Lambert Conformal Conic','long',[-120 -60],'lat',[lat_min-5 lat_max+5]);

% Polar-centric Stereographic - good for full longitudinal range
m_proj('Stereographic','lat',-90,'long',0,'radius',65);

% set colour-blind friendly colormap
map = brewermap(12,'paired');

%draw grid
m_grid('xtick',6,'tickdir','out','ytick',[-60 -30]);

% draw coastlines
m_coast('patch',[.8 .8 .8],'edgecolor','k');

% read in etopo1v1 bathymetry data
    % draw 300m and 1000m bathymetry contours
m_etopo2('contour',[-300 -1000],'linewidth',1);


% plot data present in fronts_char structure
% check existence of each front/zone defined

% plot STZ
if isfield(fronts_char,'stz')
    n = m_plot([fronts_char.stz(:).lon],[fronts_char.stz(:).lat],'DisplayName','stz');%
end
n.MarkerSize = 7;
n.Marker = '*';
n.MarkerFaceColor = map(1,:);
n.MarkerEdgeColor = map(1,:);
n.LineStyle = 'none';

% plot STF
if isfield(fronts_char,'stf')
    p = m_plot([fronts_char.stf(:).lon],[fronts_char.stf(:).lat],'DisplayName','stf');%
end
p.MarkerSize = 6;
p.Marker = 'o';
p.MarkerFaceColor = map(12,:);
p.MarkerEdgeColor = map(12,:);
p.LineStyle = 'none';

hold on

% plot SAZ
if isfield(fronts_char,'saz')
    q = m_plot([fronts_char.saz(:).lon],[fronts_char.saz(:).lat],'DisplayName','saz');
end
q.MarkerSize = 7;
q.Marker = 'square';
q.MarkerFaceColor = map(2,:);
q.MarkerEdgeColor = map(2,:);
q.LineStyle = 'none';

% plot SAF
if isfield(fronts_char,'saf')
    r = m_plot([fronts_char.saf(:).lon],[fronts_char.saf(:).lat],'DisplayName','saf');
end
r.MarkerSize = 7;
r.Marker = '+';
r.MarkerFaceColor = map(11,:);
r.MarkerEdgeColor = map(11,:);
r.LineStyle = 'none';

if isfield(fronts_char,'pz')
    s = m_plot([fronts_char.pz(:).lon],[fronts_char.pz(:).lat],'DisplayName','pz');
end
s.MarkerSize = 7;
s.Marker = 'v';
s.MarkerFaceColor = map(3,:);
s.MarkerEdgeColor = map(4,:);
s.LineStyle = 'none';

if isfield(fronts_char,'pf')
    t = m_plot([fronts_char.pf(:).lon],[fronts_char.pf(:).lat],'DisplayName','pf');
end
t.MarkerSize = 7;
t.Marker = '>';
t.MarkerFaceColor = map(10,:);
t.MarkerEdgeColor = map(10,:);
t.LineStyle = 'none';


if isfield(fronts_char,'az')
    u = m_plot([fronts_char.az(:).lon],[fronts_char.az(:).lat],'DisplayName','az');
end
u.MarkerSize = 7;
u.Marker = 'o';
u.MarkerFaceColor = map(4,:);
u.MarkerEdgeColor = map(5,:);
u.LineStyle = 'none';

if isfield(fronts_char,'saccf')
    v = m_plot([fronts_char.saccf(:).lon],[fronts_char.saccf(:).lat],'DisplayName','saccf');
end
v.MarkerSize = 7;
v.Marker = 'p';
v.MarkerFaceColor = map(9,:);
v.MarkerEdgeColor = map(9,:);
v.LineStyle = 'none';

if isfield(fronts_char,'sz')
    w = m_plot([fronts_char.sz(:).lon],[fronts_char.sz(:).lat],'DisplayName','sz');
end
w.MarkerSize = 7;
w.Marker = 'h';
w.MarkerFaceColor = map(6,:);
w.MarkerEdgeColor = map(6,:);
w.LineStyle = 'none';

if isfield(fronts_char,'sbdy')
    x = m_plot([fronts_char.sbdy(:).lon],[fronts_char.sbdy(:).lat],'DisplayName','sbdy');
end
x.MarkerSize = 7;
x.Marker = '^';
x.MarkerFaceColor = map(11,:);
x.MarkerEdgeColor = map(3,:);
x.LineStyle = 'none';

if isfield(fronts_char,'spr')
   x1 = m_plot([fronts_char.spr(:).lon],[fronts_char.spr(:).lat],'DisplayName','spr');
end
x1.MarkerSize = 7;
x1.Marker = '>';
x1.MarkerFaceColor = map(7,:);
x1.MarkerEdgeColor = map(8,:);
x1.LineStyle = 'none';


if isfield(fronts_char,'unclass')
   y = m_plot([fronts_char.unclass(:).lon],[fronts_char.unclass(:).lat]);
end
y.MarkerSize = 4;
y.Marker = 'o';
y.MarkerFaceColor = map(7,:);
y.MarkerEdgeColor = map(1,:);
y.LineStyle = 'none';

if isfield(fronts_char,'noclass')
   z = m_plot([fronts_char.noclass(:).lon],[fronts_char.noclass(:).lat],'DisplayName','Noclass');
end
z.MarkerSize = 4;
z.Marker = 's';
z.MarkerFaceColor = map(7,:);
z.MarkerEdgeColor = map(7,:);
z.LineStyle = 'none';

lgd = legend([n,q,s,u,w,y,z],'STZ','SAZ','PZ','AZ','SZ','Unchar','Nochar');
lgd.FontSize = 14;
title(["Front/zone characterisation for " + num2str(mth_min) + "/" + num2str(yr_min) + " to " + num2str(mth_max) + "/" + num2str(yr_max)]);

end
%Option 2 
