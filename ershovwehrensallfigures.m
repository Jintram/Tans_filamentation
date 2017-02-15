

%% This script generates all figures for the Ershov/Wehrens et al paper.
% 
% 

OUTPUTFOLDER = 'D:\Local_Data\Dropbox\Dropbox\Filamentation recovery\MW\figures_new\Matlab_export2\';
optionalParameters.style='CBmanuscript';

%% Figure 1 ===============================================================
% D:\Local_Data\Dropbox\Dropbox\Filamentation recovery\MW\figures_new\2017_fig1_DiviLocs_v1.svg

%% (1a) 
% Picture of Rutger experiment.
snapshot=imread('G:\FilamentationRecoveryData\Rutger\F schijf AmolfBackup_3april2014\2013-12-09\pos3crop\images\pos3crop-p-2-1285.tif');
h1a=figure; imshow(snapshot,[]);

%% (1b), (1c) 
% cartoon made with Inkscape, see .svg file

%% (1d) 
% Data from Rutger's experiment.
WHATDATA = 'tetracycline';
NOSAVEPLEASE=1;

RUNSECTIONSFILADIV = 'loadData';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'calculateRatios';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'rutgerPlotFinal';
COLORCODEMARKERS=0;
script20160429_filamentRecoveryDivisionRatioss

% saving the figure
SIZE=[6.8,6.8];
OFFSET = [2,2];
set(figure1DHandle,'Units','centimeters','Position',[OFFSET SIZE]*2)
MW_makeplotlookbetter(10*2,optionalParameters);

set(figure1DHandle,'RendererMode','manual','Renderer','Painters');

saveas(figure1DHandle,[OUTPUTFOLDER 'SVG_Figure1D.svg']);
saveas(figure1DHandle,[OUTPUTFOLDER 'TIF_Figure1D.tif']);
saveas(figure1DHandle,[OUTPUTFOLDER 'FIG_Figure1D.fig']);

%% (e)
% cartoon made with Inkscape, see .svg file

%% Figure 2 ===============================================================

%% (2a) 
% Traces of cell sizes for tetracycline.

WHATDATA = 'tetracycline';
NOSAVEPLEASE=1;

MYTLIM = [-200,300];

RUNSECTIONSFILADIV = 'loadData';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'sizeTraces';
script20160429_filamentRecoveryDivisionRatioss

% saving the figure
figure(hFig2AC);
SIZE=[7.5,5.63];
OFFSET = [2,2];
set(hFig2AC,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFig2AC,'RendererMode','manual','Renderer','Painters');

saveas(hFig2AC,[OUTPUTFOLDER 'SVG_Figure2A.svg'],'svg');
saveas(hFig2AC,[OUTPUTFOLDER 'TIF_Figure2A.tif'],'tif');
saveas(hFig2AC,[OUTPUTFOLDER 'FIG_Figure2A.fig'],'fig');
saveas(hFig2AC,[OUTPUTFOLDER 'EPS_Figure2A.eps'],'epsc');

%print([OUTPUTFOLDER 'EPS_Figure2A.eps'],'-depsc');

%% (2b) 
% Interdivision time against birth size for tetracycline
WHATDATA = 'tetracycline';
NOSAVEPLEASE=1;

YLIMbirthlife=[0,200];

RUNSECTIONSFILADIV = 'loadData'; % (same as a but reload when executed per section)
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'lifeTimeVsBirthLength2';
script20160429_filamentRecoveryDivisionRatioss

% saving the figure
figure(hFig2BD);
SIZE=[7.5,5.63];
OFFSET = [2,2];
set(hFig2AC,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFig2BD,'RendererMode','manual','Renderer','Painters');

saveas(hFig2BD,[OUTPUTFOLDER 'SVG_Figure2B.svg'],'svg');
saveas(hFig2BD,[OUTPUTFOLDER 'TIF_Figure2B.tif'],'tif');
saveas(hFig2BD,[OUTPUTFOLDER 'FIG_Figure2B.fig'],'fig');
saveas(hFig2BD,[OUTPUTFOLDER 'EPS_Figure2B.eps'],'epsc');

%% (2c) 
% Traces of cell sizes for sulA

WHATDATA = 'sulA';
NOSAVEPLEASE=1;

MYTLIM = [0,200];

RUNSECTIONSFILADIV = 'loadData';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'sizeTraces';
script20160429_filamentRecoveryDivisionRatioss

% saving the figure
figure(hFig2AC);
SIZE=[7.5, 5.63];
OFFSET = [2,2];
MW_makeplotlookbetter(10*2);
set(hFig2AC,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE*2);

saveas(hFig2AC,[OUTPUTFOLDER 'SVG_Figure2C.svg']);
saveas(hFig2AC,[OUTPUTFOLDER 'TIF_Figure2C.tif']);
saveas(hFig2AC,[OUTPUTFOLDER 'FIG_Figure2C.fig']);

%% (2d) 
% Interdivision time against birth size for sulA
WHATDATA = 'sulA';
NOSAVEPLEASE=1;

YLIMbirthlife=[0,200];

RUNSECTIONSFILADIV = 'loadData'; % (same as a but reload when executed per section)
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'lifeTimeVsBirthLength2';
script20160429_filamentRecoveryDivisionRatioss

% saving the figure
figure(hFig2BD);
SIZE=[7.5,5.63];
OFFSET = [2,2];
set(hFig2BD,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFig2BD,'RendererMode','manual','Renderer','Painters');

saveas(hFig2BD,[OUTPUTFOLDER 'SVG_Figure2D.svg'],'svg');
saveas(hFig2BD,[OUTPUTFOLDER 'TIF_Figure2D.tif'],'tif');
saveas(hFig2BD,[OUTPUTFOLDER 'FIG_Figure2D.fig'],'fig');
saveas(hFig2BD,[OUTPUTFOLDER 'EPS_Figure2D.eps'],'epsc');


%% Supplemental figures (which extend Fig. 2)  ============================


%% supp (s2a) 

WHATDATA = 'temperature';
NOSAVEPLEASE=1;

MYTLIM = [-200,300];

RUNSECTIONSFILADIV = 'loadData';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'sizeTraces';
script20160429_filamentRecoveryDivisionRatioss

% saving the figure
figure(hFig2AC);
SIZE=[7.5,5.63];
OFFSET = [2,2];
set(hFig2AC,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFig2AC,'RendererMode','manual','Renderer','Painters');

saveas(hFig2AC,[OUTPUTFOLDER 'SVG_FigureS_II_A.svg'],'svg');
saveas(hFig2AC,[OUTPUTFOLDER 'TIF_FigureS_II_A.tif'],'tif');
saveas(hFig2AC,[OUTPUTFOLDER 'FIG_FigureS_II_A.fig'],'fig');
saveas(hFig2AC,[OUTPUTFOLDER 'EPS_FigureS_II_A.eps'],'epsc');

%% supp (s2b) 
% Interdivision time against birth size for sulA
WHATDATA = 'temperature';
NOSAVEPLEASE=1;

YLIMbirthlife=[0,200];

RUNSECTIONSFILADIV = 'loadData'; % (same as a but reload when executed per section)
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'lifeTimeVsBirthLength2';
script20160429_filamentRecoveryDivisionRatioss

% saving the figure
figure(hFig2BD);
SIZE=[7.5,5.63];
OFFSET = [2,2];
set(hFig2AC,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFig2BD,'RendererMode','manual','Renderer','Painters');

saveas(hFig2BD,[OUTPUTFOLDER 'SVG_FigureS_II_B.svg'],'svg');
saveas(hFig2BD,[OUTPUTFOLDER 'TIF_FigureS_II_B.tif'],'tif');
saveas(hFig2BD,[OUTPUTFOLDER 'FIG_FigureS_II_B.fig'],'fig');
saveas(hFig2BD,[OUTPUTFOLDER 'EPS_FigureS_II_B.eps'],'epsc');

%% supp (s2c), all data together

script20161221_filarecovery_birthSizeLifeTimeDynamics_all

figure(hFigSIIC);
SIZE=[7.5,5.63];
OFFSET = [2,2];
set(hFigSIIC,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFigSIIC,'RendererMode','manual','Renderer','Painters');

saveas(hFigSIIC,[OUTPUTFOLDER 'SVG_FigureS_II_C.svg'],'svg');
saveas(hFigSIIC,[OUTPUTFOLDER 'TIF_FigureS_II_C.tif'],'tif');
saveas(hFigSIIC,[OUTPUTFOLDER 'FIG_FigureS_II_C.fig'],'fig');
saveas(hFigSIIC,[OUTPUTFOLDER 'EPS_FigureS_II_C.eps'],'epsc');

%% Figure 3 ===============================================================

%% (3a)

% Cartoon, see 
% D:\Local_Data\Dropbox\Dropbox\Filamentation recovery\MW\figures_new\Svg_files\cartoons_bacteria.svg

%% (3b)

script20170104_FtsAPrettySnapshot

saveas(hFig3a,[OUTPUTFOLDER 'SVG_Figure3A.svg'],'svg');
saveas(hFig3a,[OUTPUTFOLDER 'TIF_Figure3A.tif'],'tif');
saveas(hFig3a,[OUTPUTFOLDER 'FIG_Figure3A.fig'],'fig');
saveas(hFig3a,[OUTPUTFOLDER 'EPS_Figure3A.eps'],'epsc');

%% (3c)
NOSAVEPLEASE=1;

script20170105_kymoSinglePretty; %SCHNITZIDX=11;

figure(hFig3b);
SIZE=[7.5, 6.7];
OFFSET = [2,2];
set(hFig3b,'Units','centimeters','Position',[OFFSET SIZE]*2,...
            'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFig3b,'RendererMode','manual','Renderer','Painters');

saveas(hFig3b,[OUTPUTFOLDER 'SVG_Figure3B.svg'],'svg');
saveas(hFig3b,[OUTPUTFOLDER 'TIF_Figure3B.tif'],'tif');
saveas(hFig3b,[OUTPUTFOLDER 'FIG_Figure3B.fig'],'fig');
saveas(hFig3b,[OUTPUTFOLDER 'EPS_Figure3B.eps'],'epsc');

%% (3d)

CUSTOMXLIM=[0,40];

RUNSECTIONSFILEFTS='loadData';
script20160422_filamentRecoveryFtslabelLocations

RUNSECTIONSFILEFTS='LengthVsDivisionLocation';
script20160422_filamentRecoveryFtslabelLocations

figure(hFig3c);
SIZE=[7.5, 6.5];
OFFSET = [2,2];
set(hFig3c,'Units','centimeters','Position',[OFFSET SIZE]*2,...
            'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFig3c,'RendererMode','manual','Renderer','Painters');

saveas(hFig3c,[OUTPUTFOLDER 'SVG_Figure3C.svg'],'svg');
saveas(hFig3c,[OUTPUTFOLDER 'TIF_Figure3C.tif'],'tif');
saveas(hFig3c,[OUTPUTFOLDER 'FIG_Figure3C.fig'],'fig');
saveas(hFig3c,[OUTPUTFOLDER 'EPS_Figure3C.eps'],'epsc');

%% (3e)

DE_case = 20; DE_timeBetweenFrames = 845; % Parameters from comments DE
opts.hideExtraInfo = 1; opts.whiteBackground=1;
myHs = DE_ftsA_kymo_and_divisions(DE_case, DE_timeBetweenFrames,opts);
close(myHs(1,3:end));
hFig3d=myHs(2);

% saving the figure
figure(hFig3d);
SIZE=[7.5,5.63];
OFFSET = [2,2];
set(hFig3d,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFig3d,'RendererMode','manual','Renderer','Painters');

saveas(hFig3d,[OUTPUTFOLDER 'SVG_Figure3D.svg'],'svg');
saveas(hFig3d,[OUTPUTFOLDER 'TIF_Figure3D.tif'],'tif');
saveas(hFig3d,[OUTPUTFOLDER 'FIG_Figure3D.fig'],'fig');
saveas(hFig3d,[OUTPUTFOLDER 'EPS_Figure3D.eps'],'epsc');


%% Figure 3 ===============================================================

%% (4b-c)

mw_getstatisticsandmakefigure;
%hfig4B = h1;
hfig4B = h2;

mw_fitdivisiondatatosimulations

% saving the figure
figure(hfig4B);
SIZE=[7.5,5.63];
OFFSET = [2,2];
set(hfig4B,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hfig4B,'RendererMode','manual','Renderer','Painters');

saveas(hfig4B,[OUTPUTFOLDER 'SVG_Figure4B.svg'],'svg');
saveas(hfig4B,[OUTPUTFOLDER 'TIF_Figure4B.tif'],'tif');
saveas(hfig4B,[OUTPUTFOLDER 'FIG_Figure4B.fig'],'fig');
saveas(hfig4B,[OUTPUTFOLDER 'EPS_Figure4B.eps'],'epsc');

%%

NOSIMPLOTTING=1;

DE_plot_rescaled_profiles_MinD
mw_experimentalandsimulatedminD

hfig4C = hExpMinFigs;

% save figure in desired size
figure(hfig4C);
SIZE=[7.5,5.63];
OFFSET = [2,2];
set(hfig4C,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hfig4C,'RendererMode','manual','Renderer','Painters');

saveas(hfig4C,[OUTPUTFOLDER 'SVG_Figure4C.svg'],'svg');
saveas(hfig4C,[OUTPUTFOLDER 'TIF_Figure4C.tif'],'tif');
saveas(hfig4C,[OUTPUTFOLDER 'FIG_Figure4C.fig'],'fig');
saveas(hfig4C,[OUTPUTFOLDER 'EPS_Figure4C.eps'],'epsc');

%%

disp('This is the end of the ershovwehrensallfigures.m script.');
















