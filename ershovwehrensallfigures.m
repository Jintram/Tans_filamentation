



%% This script generates all figures for the Ershov/Wehrens et al paper.
% 
% 

% TODOs
% 1) Add line in fig 1d
% 2) Create distributions for division times for different lengths

OUTPUTFOLDER = 'D:\Local_Data\Dropbox\Dropbox\Filamentation_recovery_Personal\MW\figures_new\Matlab_export3\';
optionalParameters.style='CBmanuscript';

%% Figure 1 ===============================================================
% D:\Local_Data\Dropbox\Dropbox\Filamentation recovery\MW\figures_new\2017_fig1_DiviLocs_v1.svg

%% (1a) 
FRAMEIDX=1285 % 1442; % 1285

% Picture of Rutger experiment.
snapshot=imread(['G:\FilamentationRecoveryData\Rutger\F schijf AmolfBackup_3april2014\2013-12-09\pos3crop\images\pos3crop-p-2-' num2str(FRAMEIDX) '.tif']);
h1a=figure; imshow(snapshot,[]);

% Determine time at which it was taken:
load 'G:\FilamentationRecoveryData\Rutger\F schijf AmolfBackup_3april2014\USE_DIV\1uM_pos3_long.mat'


% Find the frame and it's time
for i = 1:numel(schnitzcellspos3_1uM_long)
    if any(schnitzcellspos3_1uM_long(i).frames==FRAMEIDX)
        fr_idx = find(schnitzcellspos3_1uM_long(i).frames==FRAMEIDX);
        timeForSnapShot = schnitzcellspos3_1uM_long(i).time(fr_idx)
        break;
    end
end

% 
% Judging from the plot, the switch time was around 1200 minutes.
theSwitchTime = 1373.5417;
relativeTime = timeForSnapShot-theSwitchTime

%% (1b), (1c) 
% cartoon made with Inkscape, see .svg file

%% (1d) 
% Data from Rutger's experiment.
WHATDATA = 'tetracycline';
LENGTHFIELD = 'length_fitNew';
%WHATDATA = 'tetracycline_skel';
%LENGTHFIELD = 'length_skeleton';
%warning('Taking skel data!');
NOSAVEPLEASE=1;
MYXLIM=[0,40];

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
MW_makeplotlookbetter(10*2);%,optionalParameters);

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
LENGTHFIELD = 'length_fitNew';
NOSAVEPLEASE=1;

%MYTLIM = [-200,300];
MYTLIM = [0 565];

RUNSECTIONSFILADIV = 'loadData';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'sizeTraces';
script20160429_filamentRecoveryDivisionRatioss

% saving the figure
figure(hFig2AC);
SIZE=[7.5,5.63];
%SIZE=[5,5.63];
OFFSET = [2,2];
set(hFig2AC,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFig2AC,'RendererMode','manual','Renderer','Painters');

saveas(hFig2AC,[OUTPUTFOLDER 'SVG_Figure2A.svg'],'svg');
saveas(hFig2AC,[OUTPUTFOLDER 'FIG_Figure2A.fig'],'fig');
saveas(hFig2AC,[OUTPUTFOLDER 'TIF_Figure2A.tif'],'tif');
%saveas(hFig2AC,[OUTPUTFOLDER 'EPS_Figure2A.eps'],'epsc');

%print([OUTPUTFOLDER 'EPS_Figure2A.eps'],'-depsc');

%% (2b) 
% Interdivision time against birth size for tetracycline
WHATDATA = 'tetracycline';
NOSAVEPLEASE=1;
LENGTHFIELD = 'length_fitNew';

YLIMbirthlife=[0,150];
CUSTOMCOLOR=[0,0,0];

RUNSECTIONSFILADIV = 'loadData'; % (same as a but reload when executed per section)
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'lifeTimeVsBirthLength2';
script20160429_filamentRecoveryDivisionRatioss

% saving the figure
figure(hFig2BD);
SIZE=[7.5,5.63];
%SIZE=[5,5.63];
OFFSET = [2,2];
set(hFig2BD,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFig2BD,'RendererMode','manual','Renderer','Painters');

saveas(hFig2BD,[OUTPUTFOLDER 'SVG_Figure2B.svg'],'svg');
saveas(hFig2BD,[OUTPUTFOLDER 'TIF_Figure2B.tif'],'tif');
saveas(hFig2BD,[OUTPUTFOLDER 'FIG_Figure2B.fig'],'fig');
saveas(hFig2BD,[OUTPUTFOLDER 'EPS_Figure2B.eps'],'epsc');

%% create plot for possible inset (2bsub)
% Run above section first to load correct data!

RUNSECTIONSFILADIV = 'lifeTimeVsBirthLengthPDFs';
script20160429_filamentRecoveryDivisionRatioss

% saving the figure
figure(hFig2Bsub);
%SIZE=[7.5,5.63];
SIZE=[2.5,2.8];
OFFSET = [2,2];
set(hFig2Bsub,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(9.09*2);
legend(gca,'off'); xlim([0,3]);
xlabel('Time (min)'); ylabel('Probability');

set(hFig2Bsub,'RendererMode','manual','Renderer','Painters');

saveas(hFig2Bsub,[OUTPUTFOLDER 'SVG_Figure2Bsub.svg'],'svg');
saveas(hFig2Bsub,[OUTPUTFOLDER 'TIF_Figure2Bsub.tif'],'tif');
saveas(hFig2Bsub,[OUTPUTFOLDER 'FIG_Figure2Bsub.fig'],'fig');
saveas(hFig2Bsub,[OUTPUTFOLDER 'EPS_Figure2Bsub.eps'],'epsc');

%% (2c), all data together
% ALSOPLOTDELTAMIN controls plotting of delta min data and is activated
% from within the script below

HIDESQUARES=1;
script20161221_filarecovery_birthSizeLifeTimeDynamics_all

figure(hFigSIIC);
SIZE=[7.5,5.63];
%SIZE=[5,5.63];
OFFSET = [2,2];
set(hFigSIIC,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFigSIIC,'RendererMode','manual','Renderer','Painters');

legend boxoff

saveas(hFigSIIC,[OUTPUTFOLDER 'SVG_Figure2C.svg'],'svg');
saveas(hFigSIIC,[OUTPUTFOLDER 'TIF_Figure2C.tif'],'tif');
saveas(hFigSIIC,[OUTPUTFOLDER 'FIG_Figure2C.fig'],'fig');
saveas(hFigSIIC,[OUTPUTFOLDER 'EPS_Figure2C.eps'],'epsc');

%% Also save the Min statistics
% execute previous section fo this
% (This also displays data manually extracted from the Donachie & Begg
% plot.)

figure(hInterdivMin);
%SIZE=[7.5,5.63]; %SIZE=[5,5.63];
SIZE=[5.5,4];
OFFSET = [2,2];
set(hInterdivMin,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hInterdivMin,'RendererMode','manual','Renderer','Painters');
%legend boxoff

saveas(hInterdivMin,[OUTPUTFOLDER 'SVG_SuppFigureDMin.svg'],'svg');
saveas(hInterdivMin,[OUTPUTFOLDER 'TIF_SuppFigureDMin.tif'],'tif');
saveas(hInterdivMin,[OUTPUTFOLDER 'FIG_SuppFigureDMin.fig'],'fig');
saveas(hInterdivMin,[OUTPUTFOLDER 'EPS_SuppFigureDMin.eps'],'epsc');



%% (s2)
% execute section n-2 fo this

ALSOPLOTDELTAMINFLAG2=1;
script20161221_filarecovery_birthSizeLifeTimeDynamics_all
figure(hStatisticsTimeCollapse);
%SIZE=[7.5,5.63];
SIZE=[5,4];
OFFSET = [2,2];
set(hStatisticsTimeCollapse,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(8*2);

set(hStatisticsTimeCollapse,'RendererMode','manual','Renderer','Painters');

saveas(hStatisticsTimeCollapse,[OUTPUTFOLDER 'SVG_SuppFigure2_collapseStatsDMin.svg'],'svg');
saveas(hStatisticsTimeCollapse,[OUTPUTFOLDER 'TIF_SuppFigure2_collapseStatsDMin.tif'],'tif');
saveas(hStatisticsTimeCollapse,[OUTPUTFOLDER 'FIG_SuppFigure2_collapseStatsDMin.fig'],'fig');
saveas(hStatisticsTimeCollapse,[OUTPUTFOLDER 'EPS_SuppFigure2_collapseStatsDMin.eps'],'epsc');

% without the delta min dataset

clear ALSOPLOTDELTAMINFLAG2
script20161221_filarecovery_birthSizeLifeTimeDynamics_all
figure(hStatisticsTimeCollapse);
%SIZE=[7.5,5.63];
SIZE=[5,4];
OFFSET = [2,2];
set(hStatisticsTimeCollapse,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(8*2);

set(hStatisticsTimeCollapse,'RendererMode','manual','Renderer','Painters');

saveas(hStatisticsTimeCollapse,[OUTPUTFOLDER 'SVG_SuppFigure2_collapseStats.svg'],'svg');
saveas(hStatisticsTimeCollapse,[OUTPUTFOLDER 'TIF_SuppFigure2_collapseStats.tif'],'tif');
saveas(hStatisticsTimeCollapse,[OUTPUTFOLDER 'FIG_SuppFigure2_collapseStats.fig'],'fig');
saveas(hStatisticsTimeCollapse,[OUTPUTFOLDER 'EPS_SuppFigure2_collapseStats.eps'],'epsc');


%% (2d)+supp (adder figure)
% adder plots (added length vs. birth size)

script20170203_combinedadderplots
hFig2D=hAdderFigs(1);

% saving the figure
figure(hFig2D);
SIZE=[7.5,5.63];
%SIZE=[5,5.63];
OFFSET = [2,2];
set(hFig2D,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFig2D,'RendererMode','manual','Renderer','Painters');

saveas(hFig2D,[OUTPUTFOLDER 'SVG_Figure2D.svg'],'svg');
saveas(hFig2D,[OUTPUTFOLDER 'TIF_Figure2D.tif'],'tif');
saveas(hFig2D,[OUTPUTFOLDER 'FIG_Figure2D.fig'],'fig');
saveas(hFig2D,[OUTPUTFOLDER 'EPS_Figure2D.eps'],'epsc');

% Saving suppl. figures too
FIGLABELS={'','E','F','G'};
for whichFig=2:4
    figure(hAdderFigs(whichFig));
    %SIZE=[7.5,5.63];
    SIZE=[7.5,5.63];
    SIZE=[5.5,4];
    OFFSET = [0,0];
    set(hAdderFigs(whichFig),'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
                %'PaperUnits','centimeters','PaperSize',SIZE);
    MW_makeplotlookbetter(10*2);

    set(hAdderFigs(whichFig),'RendererMode','manual','Renderer','Painters');

    saveas(hAdderFigs(whichFig),[OUTPUTFOLDER 'SVG_FigureS_II_' FIGLABELS{whichFig} '.svg'],'svg');
    saveas(hAdderFigs(whichFig),[OUTPUTFOLDER 'TIF_FigureS_II_' FIGLABELS{whichFig} '.tif'],'tif');
    saveas(hAdderFigs(whichFig),[OUTPUTFOLDER 'FIG_FigureS_II_' FIGLABELS{whichFig} '.fig'],'fig');
    saveas(hAdderFigs(whichFig),[OUTPUTFOLDER 'EPS_FigureS_II_' FIGLABELS{whichFig} '.eps'],'epsc');
end

%% summary statistics
% execute previous section first.

% added length on average
CONDITIONS = {'tetracycline', 'temperature', 'sulA'};
for conditionIndex = 1:3
    disp(['Condtion: ' CONDITIONS{conditionIndex}]);
    theData = combinedDataAdder.(CONDITIONS{conditionIndex}).alldatay(~isnan(combinedDataAdder.(CONDITIONS{conditionIndex}).alldatay));
    currentMean = mean(theData);
    currentStdDivN = std(theData)./numel(theData);
    disp(['Mean = ' num2str(currentMean) ' +/- ' num2str(currentStdDivN)]);
end

% compared to wild type
% See: D:\Local_Software\Repository_sizedivisionlaws\Stats\script20170410_filaRecovery_sizeUnstressedOnes.m
% = 2.2um
%% Supplemental figures (which extend Fig. 2)  ============================

%% (supp s2A) 
% Traces of cell sizes for sulA

WHATDATA = 'sulA';
LENGTHFIELD = 'length_skeleton';
NOSAVEPLEASE=1;

MYTLIM = [0,200];

RUNSECTIONSFILADIV = 'loadData';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'sizeTraces';
script20160429_filamentRecoveryDivisionRatioss

% saving the figure
figure(hFig2AC);
SIZE=[5.5, 4]; %SIZE=[7.5, 5.63];
OFFSET = [2,2];
MW_makeplotlookbetter(10*2);
set(hFig2AC,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE*2);

saveas(hFig2AC,[OUTPUTFOLDER 'SVG_FigureS_II_A.svg']);
saveas(hFig2AC,[OUTPUTFOLDER 'TIF_FigureS_II_A.tif']);
saveas(hFig2AC,[OUTPUTFOLDER 'FIG_FigureS_II_A.fig']);

%% supp (s2b) - traces for temperature

WHATDATA = 'temperature';
LENGTHFIELD = 'length_skeleton';
NOSAVEPLEASE=1;

%MYTLIM = [-200,300];
MYTLIM = [0,250];

RUNSECTIONSFILADIV = 'loadData';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'sizeTraces';
script20160429_filamentRecoveryDivisionRatioss

% saving the figure
figure(hFig2AC);
SIZE=[5.5, 4]; %SIZE=[7.5, 5.63];
OFFSET = [2,2];
set(hFig2AC,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFig2AC,'RendererMode','manual','Renderer','Painters');

saveas(hFig2AC,[OUTPUTFOLDER 'SVG_FigureS_II_B.svg'],'svg');
saveas(hFig2AC,[OUTPUTFOLDER 'TIF_FigureS_II_B.tif'],'tif');
saveas(hFig2AC,[OUTPUTFOLDER 'FIG_FigureS_II_B.fig'],'fig');
saveas(hFig2AC,[OUTPUTFOLDER 'EPS_FigureS_II_B.eps'],'epsc');

%% (supp s2C) 
% Interdivision time against birth size for sulA
WHATDATA = 'sulA';
LENGTHFIELD = 'length_skeleton';
NOSAVEPLEASE=1;
THREECOLORS = linspecer(3);
CUSTOMCOLOR=THREECOLORS(3,:);

YLIMbirthlife=[0,150];

RUNSECTIONSFILADIV = 'loadData'; % (same as a but reload when executed per section)
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'lifeTimeVsBirthLength2';
script20160429_filamentRecoveryDivisionRatioss

% saving the figure
figure(hFig2BD);
SIZE=[5.5, 4]; %SIZE=[7.5, 5.63];
OFFSET = [2,2];
set(hFig2BD,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFig2BD,'RendererMode','manual','Renderer','Painters');

saveas(hFig2BD,[OUTPUTFOLDER 'SVG_FigureS_II_C.svg'],'svg');
saveas(hFig2BD,[OUTPUTFOLDER 'TIF_Figure_II_C.tif'],'tif');
saveas(hFig2BD,[OUTPUTFOLDER 'FIG_Figure_II_C.fig'],'fig');
saveas(hFig2BD,[OUTPUTFOLDER 'EPS_Figure_II_C.eps'],'epsc');



%% supp (s2b) 
% Interdivision time against birth size for sulA
WHATDATA = 'temperature';
LENGTHFIELD = 'length_skeleton';
NOSAVEPLEASE=1;
THREECOLORS = linspecer(3);
CUSTOMCOLOR=THREECOLORS(2,:);

YLIMbirthlife=[0,150];

RUNSECTIONSFILADIV = 'loadData'; % (same as a but reload when executed per section)
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'lifeTimeVsBirthLength2';
script20160429_filamentRecoveryDivisionRatioss

% saving the figure
figure(hFig2BD);
SIZE=[5.5, 4]; %SIZE=[7.5, 5.63];
OFFSET = [2,2];
set(hFig2AC,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFig2BD,'RendererMode','manual','Renderer','Painters');

saveas(hFig2BD,[OUTPUTFOLDER 'SVG_FigureS_II_D.svg'],'svg');
saveas(hFig2BD,[OUTPUTFOLDER 'TIF_FigureS_II_D.tif'],'tif');
saveas(hFig2BD,[OUTPUTFOLDER 'FIG_FigureS_II_D.fig'],'fig');
saveas(hFig2BD,[OUTPUTFOLDER 'EPS_FigureS_II_D.eps'],'epsc');

%% supp. (s2e) - interdivision time normalized #runs (based regime)

% First re-run sections non-normalized figure
WHATDATA = 'tetracycline';
NOSAVEPLEASE=1;
LENGTHFIELD = 'length_fitNew';

YLIMbirthlife=[0,150];

RUNSECTIONSFILADIV = 'loadData'; % (same as a but reload when executed per section)
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'lifeTimeVsBirthLength2';
script20160429_filamentRecoveryDivisionRatioss

% Then run the one for normalized figure
RUNSECTIONSFILADIV = 'birthSizeLifeTimeRingNorm';
script20160429_filamentRecoveryDivisionRatioss

% saving the figure
figure(hSupp2e);
SIZE=[7.5,5.63];
OFFSET = [2,2];
set(hSupp2e,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hSupp2e,'RendererMode','manual','Renderer','Painters');

saveas(hSupp2e,[OUTPUTFOLDER 'SVG_FigureS7.svg'],'svg');
saveas(hSupp2e,[OUTPUTFOLDER 'TIF_FigureS7.tif'],'tif');
saveas(hSupp2e,[OUTPUTFOLDER 'FIG_FigureS7.fig'],'fig');
saveas(hSupp2e,[OUTPUTFOLDER 'EPS_FigureS7.eps'],'epsc');

%% Figure 3 ===============================================================

%% (3a)

% Cartoon, see 
% D:\Local_Data\Dropbox\Dropbox\Filamentation recovery\MW\figures_new\Svg_files\cartoons_bacteria.svg

%% (3b)

script20170104_FtsAPrettySnapshot

saveas(hFig3a,[OUTPUTFOLDER 'SVG_Figure3B.svg'],'svg');
saveas(hFig3a,[OUTPUTFOLDER 'TIF_Figure3B.tif'],'tif');
saveas(hFig3a,[OUTPUTFOLDER 'FIG_Figure3B.fig'],'fig');
saveas(hFig3a,[OUTPUTFOLDER 'EPS_Figure3B.eps'],'epsc');

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

saveas(hFig3b,[OUTPUTFOLDER 'SVG_Figure3C.svg'],'svg');
saveas(hFig3b,[OUTPUTFOLDER 'TIF_Figure3C.tif'],'tif');
saveas(hFig3b,[OUTPUTFOLDER 'FIG_Figure3C.fig'],'fig');
saveas(hFig3b,[OUTPUTFOLDER 'EPS_Figure3B.eps'],'epsc');

%% (3d)

CUSTOMXLIM=[0,40];

RUNSECTIONSFILEFTS='loadData';
script20160422_filamentRecoveryFtslabelLocations

RUNSECTIONSFILEFTS='getAges';
script20160422_filamentRecoveryFtslabelLocations

RUNSECTIONSFILEFTS='analyzeData';
script20160422_filamentRecoveryFtslabelLocations

RUNSECTIONSFILEFTS='LengthVsDivisionLocation';
% Use PAINTWITHTIME=1 if you want to see lifetime of cells
script20160422_filamentRecoveryFtslabelLocations


figure(hFig3c);
SIZE=[7.5, 6.5];
OFFSET = [2,2];
set(hFig3c,'Units','centimeters','Position',[OFFSET SIZE]*2,...
            'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFig3c,'RendererMode','manual','Renderer','Painters');

saveas(hFig3c,[OUTPUTFOLDER 'SVG_Figure3D.svg'],'svg');
saveas(hFig3c,[OUTPUTFOLDER 'TIF_Figure3D.tif'],'tif');
saveas(hFig3c,[OUTPUTFOLDER 'FIG_Figure3D.fig'],'fig');
saveas(hFig3c,[OUTPUTFOLDER 'EPS_Figure3D.eps'],'epsc');

%% (3e)

DE_case = 20; DE_timeBetweenFrames = 845; % Parameters from comments DE
opts.hideExtraInfo = 1; opts.whiteBackground=1; opts.normalize=1;
opts.contrast_int_against_black_background=0; 
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

saveas(hFig3d,[OUTPUTFOLDER 'SVG_Figure3E.svg'],'svg');
saveas(hFig3d,[OUTPUTFOLDER 'TIF_Figure3E.tif'],'tif');
saveas(hFig3d,[OUTPUTFOLDER 'FIG_Figure3E.fig'],'fig');
saveas(hFig3d,[OUTPUTFOLDER 'EPS_Figure3E.eps'],'epsc');

%% Statistics w/o figure ==================================================

% Numbers for divisions in the 3rd regime
WHATDATA = 'tetracycline';
LENGTHFIELD = 'length_fitNew';
NOSAVEPLEASE=1;

MYTLIM = [0,200];

RUNSECTIONSFILADIV = 'loadData';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'calculateRatios';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'RutgerPlotCombinedHistogram';
script20160429_filamentRecoveryDivisionRatioss

XXX

%%
% Statistical test for ring:
script20170227_filarecovery_binomialStatsRings

% TODO: find where the ring statistics are generated. There are also 
% figures related to this.

%% Figure 4 ===============================================================

%% (4a) Simulated delta min data by Meinhardt & De Boer model

clear schnitzcells;
WHATDATA = 'tetracycline';
LENGTHFIELD = 'length_fitNew';
inputSettings.desiredDecimalsTicks = 2;

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

saveas(hfig4B,[OUTPUTFOLDER 'SVG_Figure4A.svg'],'svg');
saveas(hfig4B,[OUTPUTFOLDER 'TIF_Figure4A.tif'],'tif');
saveas(hfig4B,[OUTPUTFOLDER 'FIG_Figure4A.fig'],'fig');
saveas(hfig4B,[OUTPUTFOLDER 'EPS_Figure4A.eps'],'epsc');

%{
Movies were made manually with options=
    showResultFigure: 1
           lengthSet: 20
          showFrames: 1
           outputDir: '\\storage01\data\AMOLF\users\wehrens\PRESENTATIONS\SLIDESHOWS\2017_04_03_kleijn_filarecovery\'
            video_MW: 1
N_frames=100
options.lengthSet= 12 and 50
With script D:\Local_Software\Repository_sizedivisionlaws\Fig4_MinD\Scripts\f0_simulations.m
(See folder \\storage01\data\AMOLF\users\wehrens\PRESENTATIONS\SLIDESHOWS\2017_04_03_kleijn_filarecovery)
%}

%% (4b) experimental Min data

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

saveas(hfig4C,[OUTPUTFOLDER 'SVG_Figure4B.svg'],'svg');
saveas(hfig4C,[OUTPUTFOLDER 'TIF_Figure4B.tif'],'tif');
saveas(hfig4C,[OUTPUTFOLDER 'FIG_Figure4B.fig'],'fig');
saveas(hfig4C,[OUTPUTFOLDER 'EPS_Figure4B.eps'],'epsc');

%% Extra MinD plots (not used because we suspect that the
% overexpression of MinD actually alters the profile)

script20170925_newMinProfiles3;

figure(hMinD);

SIZE=[7.5,5.63];
OFFSET = [2,2];
set(hMinD,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hMinD,'RendererMode','manual','Renderer','Painters');

saveas(hMinD,[OUTPUTFOLDER 'SVG_Figure4B_more.svg'],'svg');
saveas(hMinD,[OUTPUTFOLDER 'TIF_Figure4B_more.tif'],'tif');
saveas(hMinD,[OUTPUTFOLDER 'FIG_Figure4B_more.fig'],'fig');
saveas(hMinD,[OUTPUTFOLDER 'EPS_Figure4B_more.eps'],'epsc');

%% Additional supp. figures

%% 1-3 made by Dmitry Ershov / Rutger Rozendaal

%% (s4a) 
% Temperature data divisions
WHATDATA = 'temperature';
LENGTHFIELD = 'length_skeleton';
NOSAVEPLEASE=1;
MYLLIM=[0,40];

RUNSECTIONSFILADIV = 'loadData';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'calculateRatios';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'rutgerPlotBlackWhiteTimecoding';
%RUNSECTIONSFILADIV = 'rutgerPlotFinal';
COLORCODEMARKERS=0;
script20160429_filamentRecoveryDivisionRatioss

% saving the figure
%SIZE=[6.8,6.8];
%SIZE=[7.5,5.63];
SIZE=[5.53, 4];
OFFSET = [2,2];
set(hSupp5,'Units','centimeters','Position',[OFFSET SIZE]*2)
MW_makeplotlookbetter(10*2);%,optionalParameters);

set(hSupp5,'RendererMode','manual','Renderer','Painters');

saveas(hSupp5,[OUTPUTFOLDER 'SVG_SFigure4A.svg']);
saveas(hSupp5,[OUTPUTFOLDER 'TIF_SFigure4A.tif']);
saveas(hSupp5,[OUTPUTFOLDER 'FIG_SFigure4A.fig']);

%% (s4b)
% SulA data divisions
WHATDATA = 'sulA';
LENGTHFIELD = 'length_skeleton';
NOSAVEPLEASE=1;
MYLLIM=[0,40];

RUNSECTIONSFILADIV = 'loadData';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'calculateRatios';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'rutgerPlotBlackWhiteTimecoding';
%RUNSECTIONSFILADIV = 'rutgerPlotFinal';
COLORCODEMARKERS=0;
script20160429_filamentRecoveryDivisionRatioss

% saving the figure
%SIZE=[6.8,6.8];
%SIZE=[7.5,5.63];
SIZE=[5.53, 4];
OFFSET = [2,2];
set(hSupp5,'Units','centimeters','Position',[OFFSET SIZE]*2)
MW_makeplotlookbetter(10*2,optionalParameters);

set(hSupp5,'RendererMode','manual','Renderer','Painters');

saveas(hSupp5,[OUTPUTFOLDER 'SVG_SFigure4B.svg']);
saveas(hSupp5,[OUTPUTFOLDER 'TIF_SFigure4B.tif']);
saveas(hSupp5,[OUTPUTFOLDER 'FIG_SFigure4B.fig']);


%%

%% (s4c)
% Other tetracycline concentrations (TET=2um and 10um)
WHATDATA = 'tetracycline';
LENGTHFIELD = 'length_fitNew';
NOSAVEPLEASE=1;
MYLLIM=[0,40];

datasetsTetOtherConcentrations = {[6:8], [9:11]};
figLetters = {'C','D'};
for otherConcentrationIdx = 1:2
    
    SPECIALONESTOTAKE=datasetsTetOtherConcentrations{otherConcentrationIdx};
    RUNSECTIONSFILADIV = 'loadData';
    script20160429_filamentRecoveryDivisionRatioss

    RUNSECTIONSFILADIV = 'calculateRatios';
    script20160429_filamentRecoveryDivisionRatioss

    %RUNSECTIONSFILADIV = 'rutgerPlotBlackWhiteTimecoding';
    RUNSECTIONSFILADIV = 'rutgerPlotFinal';
    COLORCODEMARKERS=0;
    script20160429_filamentRecoveryDivisionRatioss

    xlabel('Mother length L_m (µm)');
    ylabel('Division location S');
    
    % saving the figure
    %SIZE=[6.8,6.8];
    %SIZE=[7.5,5.63];
    SIZE=[5.53, 4];
    OFFSET = [2,2];
    set(hSupp5,'Units','centimeters','Position',[OFFSET SIZE]*2)
    MW_makeplotlookbetter(10*2,optionalParameters);

    set(hSupp5,'RendererMode','manual','Renderer','Painters');

    saveas(hSupp5,[OUTPUTFOLDER 'SVG_SFigure4' figLetters{otherConcentrationIdx} '.svg']);
    saveas(hSupp5,[OUTPUTFOLDER 'TIF_SFigure4' figLetters{otherConcentrationIdx} '.tif']);
    saveas(hSupp5,[OUTPUTFOLDER 'FIG_SFigure4' figLetters{otherConcentrationIdx} '.fig']);
    
    clear SPECIALONESTOTAKE;
end


%% (4E) Delta Min TET data divisions vs. length
WHATDATA = 'deltaMinTET';
LENGTHFIELD = 'length_skeleton';
NOSAVEPLEASE=1;
MYLLIM=[0,40];

%datasetsTetOtherConcentrations = {[6:8], [9:11]};
%figLetters = {'C','D'};

RUNSECTIONSFILADIV = 'loadData';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'calculateRatios';
script20160429_filamentRecoveryDivisionRatioss

%
for PLOTHELPINGLINES=1 %0:1
    
    THINHELPINGLINES=1;
    %PLOTHELPINGLINES=0;
    %RUNSECTIONSFILADIV = 'rutgerPlotBlackWhiteTimecoding';
    RUNSECTIONSFILADIV = 'rutgerPlotFinal';
    COLORCODEMARKERS=0;
    script20160429_filamentRecoveryDivisionRatioss

    xlabel('Mother length L_m (µm)');
    ylabel('Division location S');

    % saving the figure
    %SIZE=[6.8,6.8];
    SIZE=[7.5,5.63];
    %SIZE=[5.53, 4];
    OFFSET = [2,2];
    set(hSupp5,'Units','centimeters','Position',[OFFSET SIZE]*2)
    MW_makeplotlookbetter(10*2,optionalParameters);

    title('MinCDE mutant cells');

    set(hSupp5,'RendererMode','manual','Renderer','Painters');
    
    saveas(hSupp5,[OUTPUTFOLDER 'SVG_Figure4_deltaMin_Pattern_' num2str(PLOTHELPINGLINES) '.svg']);
    saveas(hSupp5,[OUTPUTFOLDER 'TIF_Figure4_deltaMin_Pattern_' num2str(PLOTHELPINGLINES) '.tif']);
    saveas(hSupp5,[OUTPUTFOLDER 'FIG_Figure4_deltaMin_Pattern_' num2str(PLOTHELPINGLINES) '.fig']);
    
end
clear THINHELPINGLINES

% helping figure for indicating area of minicell divisions, use of
% "pathfinder" in adobe illustrator is convenient.
script20171122_minicellsarea_extremelysimpleplot

%% (1e) Relative division location against time, grey dots

TIMEDIVPLOTMAINFIG=1;

WHATDATA='tetracycline';
LENGTHFIELD='length_fitNew';

RUNSECTIONSFILADIV = 'loadData';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'calculateRatios';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'SlocationAgainstTime';
MYSUBPLOT = conditionIdx;
script20160429_filamentRecoveryDivisionRatioss

h1D = hSvsT;
figure(h1D);
SIZE=[3 3];
MW_makeplotlookbetter(10*2,[],SIZE);

saveas(h1D,[OUTPUTFOLDER 'SVG_Figure1Ev2' FIGLABELS{conditionIdx} '.svg']);
saveas(h1D,[OUTPUTFOLDER 'TIF_Figure1Ev2' FIGLABELS{conditionIdx} '.tif']);
saveas(h1D,[OUTPUTFOLDER 'FIG_Figure1Ev2' FIGLABELS{conditionIdx} '.fig']);

clear TIMEDIVPLOTMAINFIG

%% (s5) Relative division location against time

WHATDATAS = {'tetracycline','temperature','sulA','deltaMinTET'};
LENGTHFIELDS = {'length_fitNew','length_skeleton','length_skeleton','length_skeleton'};
FIGLABELS = {'','','','_deltaMin'}; %can be removed, used to be %FIGLABELS = {'A','B','C'}
NOSAVEPLEASE=1;

for conditionIdx=1:3

    %%
    WHATDATA=WHATDATAS{conditionIdx};
    LENGTHFIELD=LENGTHFIELDS{conditionIdx};

    RUNSECTIONSFILADIV = 'loadData';
    script20160429_filamentRecoveryDivisionRatioss

    RUNSECTIONSFILADIV = 'calculateRatios';
    script20160429_filamentRecoveryDivisionRatioss

    RUNSECTIONSFILADIV = 'SlocationAgainstTime';
    MYSUBPLOT = conditionIdx;
    script20160429_filamentRecoveryDivisionRatioss
    
end

hS6 = hSvsT;

% saving the figure    
SIZE=[11.5 4];
%SIZE=[5 5];
%SIZE=[7.5,5.63];
OFFSET = [2,2];
set(hS6,'Units','centimeters','Position',[OFFSET SIZE]*2)
MW_makeplotlookbetter(10*2);%,optionalParameters);

set(hS6,'RendererMode','manual','Renderer','Painters');

saveas(hS6,[OUTPUTFOLDER 'SVG_SFigure5' FIGLABELS{conditionIdx} '.svg']);
saveas(hS6,[OUTPUTFOLDER 'TIF_SFigure5' FIGLABELS{conditionIdx} '.tif']);
saveas(hS6,[OUTPUTFOLDER 'FIG_SFigure5' FIGLABELS{conditionIdx} '.fig']);


%% (s7b) ring count versus length
%{
WHATDATA     = 'temperature'; %'tetracycline','temperature','sulA'};
LENGTHFIELD  = 'length_skeleton'; %'length_fitNew','length_skeleton','length_skeleton'};

CUSTOMXLIM=[0,40];

RUNSECTIONSFILEFTS='loadData';
script20160422_filamentRecoveryFtslabelLocations

RUNSECTIONSFILEFTS='getAges';
script20160422_filamentRecoveryFtslabelLocations

RUNSECTIONSFILEFTS='analyzeData';
script20160422_filamentRecoveryFtslabelLocations

RUNSECTIONSFILEFTS='ringCountVsLength';
% Use PAINTWITHTIME=1 if you want to see lifetime of cells
script20160422_filamentRecoveryFtslabelLocations


figure(hFigS7B);
SIZE=[7.5, 6.5];
OFFSET = [2,2];
set(hFigS7B,'Units','centimeters','Position',[OFFSET SIZE]*2,...
            'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFigS7B,'RendererMode','manual','Renderer','Painters');

saveas(hFigS7B,[OUTPUTFOLDER 'SVG_FigureS7B.svg'],'svg');
saveas(hFigS7B,[OUTPUTFOLDER 'TIF_FigureS7B.tif'],'tif');
saveas(hFigS7B,[OUTPUTFOLDER 'FIG_FigureS7B.fig'],'fig');
saveas(hFigS7B,[OUTPUTFOLDER 'EPS_FigureS7B.eps'],'epsc');
%}

%% (s7) fit 1/L to interdiv time and also get nr. rings vs. lengths

% run previous section first to load and analyze data (s7b)

% obtain interdiv plots for all datasets
script20161221_filarecovery_birthSizeLifeTimeDynamics_all

% get specific required data for the temperature stuff
WHATDATA     = 'temperature'; %'tetracycline','temperature','sulA'};
LENGTHFIELD  = 'length_skeleton'; %'length_fitNew','length_skeleton','length_skeleton'};

CUSTOMXLIM=[0,40];

%RUNSECTIONSFILADIV='loadData';
%script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILEFTS='loadData';
script20160422_filamentRecoveryFtslabelLocations

RUNSECTIONSFILEFTS='getAges';
script20160422_filamentRecoveryFtslabelLocations

RUNSECTIONSFILEFTS='analyzeData';
script20160422_filamentRecoveryFtslabelLocations

%RUNSECTIONSFILADIV = 'lifeTimeVsBirthLength2';
%script20160429_filamentRecoveryDivisionRatioss

%RUNSECTIONSFILEFTS='ringCountVsLength';
%script20160422_filamentRecoveryFtslabelLocations

RUNSECTIONSFILADIV = 'interdivVsLengthNormalizedWithRingCount';
script20160429_filamentRecoveryDivisionRatioss

% Now save the four figures
theLabels = {'A','B','C','D'};
for idx=1:4
    figure(hFigS7(idx));
    
    SIZE=[7.5, 6.5];
    OFFSET = [2,2];
    set(hFigS7(idx),'Units','centimeters','Position',[OFFSET SIZE]*2,...
                'PaperUnits','centimeters','PaperSize',SIZE);
    MW_makeplotlookbetter(10*2);

    set(hFigS7(idx),'RendererMode','manual','Renderer','Painters');

    saveas(hFigS7(idx),[OUTPUTFOLDER 'SVG_FigureS7' theLabels{idx} '.svg'],'svg');
    saveas(hFigS7(idx),[OUTPUTFOLDER 'TIF_FigureS7' theLabels{idx} '.tif'],'tif');
    saveas(hFigS7(idx),[OUTPUTFOLDER 'FIG_FigureS7' theLabels{idx} '.fig'],'fig');
    saveas(hFigS7(idx),[OUTPUTFOLDER 'EPS_FigureS7' theLabels{idx} '.eps'],'epsc');
end
    
disp(['Assuming line = L/(2w)+b, predicted parameter w=' num2str((1/ringNrFit(1))/2)]);

%% (s8) Newborn stats
% Note there was already a similair figure in the supp. material.

WHATDATA = 'tetracycline';
LENGTHFIELD = 'length_fitNew';
NOSAVEPLEASE=1;

RUNSECTIONSFILADIV = 'loadData';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'calculateRatios';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'newbornStats';
script20160429_filamentRecoveryDivisionRatioss

% saving the figure
figure(hNBS);
SIZE=[7.5,5.63];
OFFSET = [2,2];
set(hNBS,'Units','centimeters','Position',[OFFSET SIZE]*2)
MW_makeplotlookbetter(10*2,optionalParameters);

set(hNBS,'RendererMode','manual','Renderer','Painters');

saveas(hNBS,[OUTPUTFOLDER 'SVG_FigureS8.svg']);
saveas(hNBS,[OUTPUTFOLDER 'TIF_FigureS8.tif']);
saveas(hNBS,[OUTPUTFOLDER 'FIG_FigureS8.fig']);

figure(hNBSInset);
SIZE=[5,3.5];
OFFSET = [2,2];
set(hNBSInset,'Units','centimeters','Position',[OFFSET SIZE]*2)
MW_makeplotlookbetter(10*2,optionalParameters);

set(hNBSInset,'RendererMode','manual','Renderer','Painters');

saveas(hNBSInset,[OUTPUTFOLDER 'SVG_FigureS8inset.svg']);
saveas(hNBSInset,[OUTPUTFOLDER 'TIF_FigureS8inset.tif']);
saveas(hNBSInset,[OUTPUTFOLDER 'FIG_FigureS8inset.fig']);

%% (1f) Preference (distribution) of division location (random)

WHATDATA = 'tetracycline';
LENGTHFIELD = 'length_fitNew';
NOSAVEPLEASE=1;

RUNSECTIONSFILADIV = 'loadData';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'calculateRatios';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'locationPreference';
script20160429_filamentRecoveryDivisionRatioss

figure(hlocPref);
%SIZE=[7.5,5.63];
SIZE=[2, 3];
MW_makeplotlookbetter(10*2,[],SIZE);

set(hlocPref,'RendererMode','manual','Renderer','Painters');

saveas(hlocPref,[OUTPUTFOLDER 'SVG_Figure2_sitePreference.svg']);
saveas(hlocPref,[OUTPUTFOLDER 'TIF_Figure2_sitePreference.tif']);
saveas(hlocPref,[OUTPUTFOLDER 'FIG_Figure2_sitePreference.fig']);

% see 
% script20161208_statistics101_applied_ring_preference.m 
% for binomial statistics 

%{
% For temperature data there's also info about the rings:
%RUNSECTIONSFILEFTS='loadData';
%script20160422_filamentRecoveryFtslabelLocations

RUNSECTIONSFILEFTS='analyzeData';
script20160422_filamentRecoveryFtslabelLocations

RUNSECTIONSFILEFTS='lengthHistogramAndPerGroup';
script20160422_filamentRecoveryFtslabelLocations

RUNSECTIONSFILEFTS='compareDivisionsWRings';
script20160422_filamentRecoveryFtslabelLocations
%}

%% (s2h) manual plotting based on figure & caption Dmitry
% Dmitry plot re. division at brightest rings or not
% "Correlation of intensity of FtsA-YFP ring and probability of division at
% this ring; only 11 out of 31 (about 35%) of observed divisions occurred at the most intense FtsA ring (red bar)."
hDECorrRing=figure; hold on; 

twoColors=linspecer(2);

bar(1,11,'FaceColor',twoColors(1,:)); 
bar(2,20,'FaceColor',twoColors(1,:));
set(gca, 'XTickLabel',{'Brightest','Rest'}, 'XTick',1:2)
MW_makeplotlookbetter(20);
xlim([0.25,2.75]);
ylim([0,25]);
ylabel('Frequency'); 

figure(hDECorrRing);
%SIZE=[7.5,5.63];
SIZE=[2.5,4];
xtickangle(90)
OFFSET = [2,2];
set(hDECorrRing,'Units','centimeters','Position',[OFFSET SIZE]*2)
MW_makeplotlookbetter(10*2,optionalParameters);

set(hDECorrRing,'RendererMode','manual','Renderer','Painters');

saveas(hDECorrRing,[OUTPUTFOLDER 'SVG_SuppFigure2H.svg']);
saveas(hDECorrRing,[OUTPUTFOLDER 'TIF_SuppFigure2H.tif']);
saveas(hDECorrRing,[OUTPUTFOLDER 'FIG_SuppFigure2H.fig']);

%% (s11) sup extra kymographs
EXTRAKYMOS = [9,7,10,17,14]; % max is 35, 11 is the one shown as main
NOSAVEPLEASE=1;

labels={'a','b','c','d','e','f','g','e','h'};
for kymoIdx = 1:numel(EXTRAKYMOS)
    %%
    SCHNITZIDX=EXTRAKYMOS(kymoIdx);
    %%
    % SCHNITZIDX = 9
    
    script20170105_kymoSinglePretty; %SCHNITZIDX=11;
    hFig3supp=hFig3b;

    figure(hFig3supp);
    
    if SCHNITZIDX==9
        SIZE=[16.2, 6.7];
    else
        SIZE=[7.5, 6.7];
    end
    OFFSET = [2,2];
    set(hFig3b,'Units','centimeters','Position',[OFFSET SIZE]*2,...
                'PaperUnits','centimeters','PaperSize',SIZE);
    MW_makeplotlookbetter(10*2);

    set(hFig3supp,'RendererMode','manual','Renderer','Painters');

    %%
    saveas(hFig3supp,[OUTPUTFOLDER 'SVG_FigureS11' labels{kymoIdx} '.svg'],'svg');
    saveas(hFig3supp,[OUTPUTFOLDER 'TIF_FigureS11' labels{kymoIdx} '.tif'],'tif');
    saveas(hFig3supp,[OUTPUTFOLDER 'FIG_FigureS11' labels{kymoIdx} '.fig'],'fig');
    saveas(hFig3supp,[OUTPUTFOLDER 'EPS_FigureS11' labels{kymoIdx} '.eps'],'epsc');
end

%% (SX) Yet another plot, stats for growth rate w. length

WHATDATAS = {'tetracycline','temperature','sulA'};
LENGTHFIELDS = {'length_fitNew','length_skeleton','length_skeleton'};
GROWTHFIELDS = {'muP15_fitNew_all','muP9_skeleton_all','muP5_skeleton_all'};
FIGLABELS = {'A','B','C'}
LEGENDLABELS = {'Tetracycline','Temperature','SulA'};
NOSAVEPLEASE=1;

for conditionIdx=1:3
    %%
    WHATDATA = WHATDATAS{conditionIdx};
    LENGTHFIELD = LENGTHFIELDS{conditionIdx};
    GROWTHRATEFIELD = GROWTHFIELDS{conditionIdx};
    NOSAVEPLEASE=1;
    LEGENDLABEL = LEGENDLABELS{conditionIdx};
    FIGURENR = figure();

    RUNSECTIONSFILADIV = 'loadData';
    script20160429_filamentRecoveryDivisionRatioss

    % note that script below re-loads schnitzcells on its own, it is not yet
    % adapted to handle other datasets..
    script20170523_fila_scattergrowthratelengthtime
        
    
    hSX = hScatterLenMuTime;
    figure(hSX);
    
    % saving the figure
    SIZE=[4.25 4];
    %SIZE=[7.5,5.63]; SIZE=[4.25 5];
    OFFSET = [2,2];
    set(hSX,'Units','centimeters','Position',[OFFSET SIZE]*2)
    MW_makeplotlookbetter(10*2);%,optionalParameters);
    
    legend(LEGENDLABEL);    
    
    set(hSX,'RendererMode','manual','Renderer','Painters');

    saveas(hSX,[OUTPUTFOLDER 'SVG_SFigureSXscat' FIGLABELS{conditionIdx} '.svg']);
    saveas(hSX,[OUTPUTFOLDER 'TIF_SFigureSXscat' FIGLABELS{conditionIdx} '.tif']);
    saveas(hSX,[OUTPUTFOLDER 'FIG_SFigureSXscat' FIGLABELS{conditionIdx} '.fig']);
end

figure(hTheColorbarWithScatter);
set(hTheColorbarWithScatter,'RendererMode','manual','Renderer','Painters');
set(hTheColorbarWithScatter,'Units','centimeters','Position',[OFFSET 8 4]*2)
MW_makeplotlookbetter(10*2);

saveas(hTheColorbarWithScatter,[OUTPUTFOLDER 'SVG_SFigureSXscat_cbar'  '.svg']);
saveas(hTheColorbarWithScatter,[OUTPUTFOLDER 'TIF_SFigureSXscat_cbar'  '.tif']);
saveas(hTheColorbarWithScatter,[OUTPUTFOLDER 'FIG_SFigureSXscat_cbar'  '.fig']);

%% Dmitry's clustering analysis

WHATDATA = 'tetracycline';
LENGTHFIELD = 'length_fitNew';
NOSAVEPLEASE=1;

RUNSECTIONSFILADIV = 'loadData';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'calculateRatios';
script20160429_filamentRecoveryDivisionRatioss

% Dmitry's analysis
MARTIJNSTYLE=1;
x=[myLengthSumNewborns{:}]'; y=[Ratios{:}]';
DE_asymetry_pattern_clustering

% This analysis shows length window widths of 
% 3.3100 5.9487 4.4667 5.9487 4.7236 6.8250 7.3331  6.8250 6.0239   6.0239
% mean([5.9487 4.4667 5.9487 4.7236 6.8250 7.3331  6.8250 6.0239   6.0239])
% =  6.0132
% so w = 3.
% (For 0-3um cells don't have clear div sites, and the first window could
% be considered 0-6um.)

%% Simple plot showing n=L/2w being consistent with data

figure; clf; hold on;
x=[0:.1:40]; 

plot(x,round(x./(2*3)),'k','LineWidth',2)
title('N=round(L/2w), w=3\mum');
xlabel('Cellular length L (\mum)');
ylabel('Number of division sites, N');

MW_makeplotlookbetter(20);

%% Plot raw traces from Rutger's data

script20161222_branchplottingrutgerdata

%% traces of mean growth over whole tetracycline experiment.

figure(hTraces);
%SIZE=[7.5,5.63];
SIZE=[5.5,4];
OFFSET = [2,2];
set(hTraces,'Units','centimeters','Position',[OFFSET SIZE]*2)
MW_makeplotlookbetter(10*2,optionalParameters);

set(hTraces,'RendererMode','manual','Renderer','Painters');

saveas(hTraces,[OUTPUTFOLDER 'SVG_rFigureS1D.svg']);
saveas(hTraces,[OUTPUTFOLDER 'TIF_rFigureS1D.tif']);
saveas(hTraces,[OUTPUTFOLDER 'FIG_rFigureS1D.fig']);

%% ------------------------------------------------------------------------
%  Extra plots for rebuttal
%

%% Distribution of cellular widths with cellular lengths

script20171006_plottingWidthDistributions_v2
    % There is some issue with the skeleton lenghts in the 5th dataset, so
    % this one is not considered.

% Figure with raw data
figure(hBacWidths);
%SIZE=[7.5,5.63];
SIZE=[5.5,4];
OFFSET = [2,2];
set(hBacWidths,'Units','centimeters','Position',[OFFSET SIZE]*2)
MW_makeplotlookbetter(10*2,optionalParameters);

H=findobj(gca,'Type','text');
set(H, 'FontSize',5*2);

set(hBacWidths,'RendererMode','manual','Renderer','Painters');

saveas(hBacWidths,[OUTPUTFOLDER 'bacWidths.svg']);
saveas(hBacWidths,[OUTPUTFOLDER 'bacWidths.tif']);
saveas(hBacWidths,[OUTPUTFOLDER 'bacWidths.fig']);
    
% Figure with KDE
figure(hWidthViolin);
%SIZE=[7.5,5.63];
SIZE=[5.5,4];
OFFSET = [2,2];
set(hWidthViolin,'Units','centimeters','Position',[OFFSET SIZE]*2)
MW_makeplotlookbetter(10*2,optionalParameters);

H=findobj(gca,'Type','text');
set(H, 'FontSize',6*2);

set(hWidthViolin,'RendererMode','manual','Renderer','Painters');

saveas(hWidthViolin,[OUTPUTFOLDER 'bacWidths_KDE.svg']);
saveas(hWidthViolin,[OUTPUTFOLDER 'bacWidths_KDE.tif']);
saveas(hWidthViolin,[OUTPUTFOLDER 'bacWidths_KDE.fig']);
    
%% Alternative width distribution plot W=A/L.
WHATDATA='tetracycline';
LENGTHFIELD = 'length_fitNew';
RUNSECTIONSFILADIV='none';
NOSAVEPLEASE=1;
script20160429_filamentRecoveryDivisionRatioss

% plot the widths
% script20171025_plottingBasterialWidth_methodB % previous version

script20171006_plottingWidthDistributions_v2


% save
figure(hBacWidths);
%SIZE=[7.5,5.63];
SIZE=[5.5,4];
OFFSET = [2,2];
set(hBacWidths,'Units','centimeters','Position',[OFFSET SIZE]*2)
MW_makeplotlookbetter(10*2,optionalParameters);

H=findobj(gca,'Type','text');
set(H, 'FontSize',5*2);

set(hBacWidths,'RendererMode','manual','Renderer','Painters');

saveas(hBacWidths,[OUTPUTFOLDER 'bacWidths_AdivL.svg']);
saveas(hBacWidths,[OUTPUTFOLDER 'bacWidths_AdivL.tif']);
saveas(hBacWidths,[OUTPUTFOLDER 'bacWidths_AdivL.fig']);

%% Analysis of area under L(t) curves

script20171006_integratedAreaL

figure(hMu);
SIZE=[5.5,4]; OFFSET = [2,2];
set(hMu,'Units','centimeters','Position',[OFFSET SIZE]*2)
set(hMu,'RendererMode','manual','Renderer','Painters');
MW_makeplotlookbetter(10*2);
saveas(hMu, [OUTPUTFOLDER 'SVG_Supp2_areaAnalysis_LvsMu.svg']);
saveas(hMu, [OUTPUTFOLDER 'FIG_Supp2_areaAnalysis_LvsMu.fig']);

figure(hA);
SIZE=[5.5,4]; OFFSET = [2,2];
set(hA,'Units','centimeters','Position',[OFFSET SIZE]*2)
set(hA,'RendererMode','manual','Renderer','Painters');
MW_makeplotlookbetter(10*2);
saveas(hA, [OUTPUTFOLDER 'SVG_Supp2_areaAnalysis_LvsA.svg']);
saveas(hA, [OUTPUTFOLDER 'FIG_Supp2_areaAnalysis_LvsA.fig']);
  
%% Derivative of L vs. L plot

WHATDATA = 'tetracycline';
LENGTHFIELD = 'length_fitNew';
NOSAVEPLEASE=1;

RUNSECTIONSFILADIV = 'derivLvsL';
script20160429_filamentRecoveryDivisionRatioss

figure(hdLdt2);
SIZE=[2.5,4]; OFFSET = [2,2];
set(hdLdt2,'Units','centimeters','Position',[OFFSET SIZE]*2)
set(hdLdt2,'RendererMode','manual','Renderer','Painters');
MW_makeplotlookbetter(10*2);
saveas(hdLdt2, [OUTPUTFOLDER 'SVG_SuppFigure2_areaAnalysis_dLdtVsL.svg']);
saveas(hdLdt2, [OUTPUTFOLDER 'FIG_SuppFigure2_areaAnalysis_dLdtVsL.fig']);
saveas(hdLdt2, [OUTPUTFOLDER 'TIF_SuppFigure2_areaAnalysis_dLdtVsL.fig']);

%% Nucleoid positions

% Note for when you have analyzed additional data:
% Note that after analyzing the data, to produce the datasets that are
% additionally necessary here, the following scripts need to be executed:
% 
% MW_straightenbacteria(p, ourSettings.currentFrameRange, 'r') 
% slookup = MW_makeslookup(p)
% save([p.tracksDir 'slookup.mat'],'slookup');
%
% Additionally, one can use the following script to generate kymographs
% for all schnitzes:
% script20170105_kymoSinglePretty_nucleoids

%
NUCLEOIDFLAG = 1;
RUNSECTIONSFILEFTS='loadNucleoidData';
script20160422_filamentRecoveryFtslabelLocations;

PLOTHELPINGLINES=1;
PLOTEXPECTEDNRNUCLEOIDS=1;
RUNSECTIONSFILEFTS = 'heightProfile';
script20160422_filamentRecoveryFtslabelLocations;

clear NUCLEOIDFLAG PLOTEXPECTEDNRNUCLEOIDS
%
figure(hNucs1);
ylabel(['Relative location' 10 'along cell']);
SIZE=[7.5,4]; OFFSET = [2,2];
set(hNucs1,'Units','centimeters','Position',[OFFSET SIZE]*2)
set(hNucs1,'RendererMode','manual','Renderer','Painters');
MW_makeplotlookbetter(10*2);
saveas(hNucs1, [OUTPUTFOLDER 'SVG_SuppX_Nucleoids_p1.svg']);
saveas(hNucs1, [OUTPUTFOLDER 'FIG_SuppX_Nucleoids_p1.fig']);
saveas(hNucs1, [OUTPUTFOLDER 'TIF_SuppX_Nucleoids_p1.fig']);

figure(hNucs2);
SIZE=[7.5,1.5]; OFFSET = [2,2];
set(hNucs2,'Units','centimeters','Position',[OFFSET SIZE]*2)
set(hNucs2,'RendererMode','manual','Renderer','Painters');
MW_makeplotlookbetter(8*2);
saveas(hNucs2, [OUTPUTFOLDER 'SVG_SuppX_Nucleoids_p2.svg']);
saveas(hNucs2, [OUTPUTFOLDER 'FIG_SuppX_Nucleoids_p2.fig']);
saveas(hNucs2, [OUTPUTFOLDER 'TIF_SuppX_Nucleoids_p2.fig']);
%% Indentations

script20171110_rebuttalplots1

%% Expected absolute sizes 
% An additional plot showing that the first peak of the absolute size
% distribution indeed coincides with 1.5*1.8*3 (i.e. 8.1µm).
% - 1.8 is the birth size parameter
% - 3 because the first peak is expected at three unit cell sizes.
% - 1.5 because middle of the absolute division regime
WHATDATA = 'tetracycline';
LENGTHFIELD = 'length_fitNew';
NOSAVEPLEASE=1;

RUNSECTIONSFILADIV = 'none';
script20160429_filamentRecoveryDivisionRatioss

script20171113_absolutesizesonemoretime

%% (s4)

% MesoRD modeling of the Huang model (Huang et al, Fange et al) results are made by Dmitry and can be found in
% D:\Local_Data\Dropbox\Dropbox\Filamentation_recovery_Personal\MW\figures_new\Supplemental_figures\s4_DE

% He used the Jet color map
hJet = figure; colormap jet; colorbar;
saveas(hJet, [OUTPUTFOLDER 'SVG_SuppFigure4_colorbarJet.svg']);
saveas(hJet, [OUTPUTFOLDER 'FIG_SuppFigure4_colorbarJet.fig']);
saveas(hJet, [OUTPUTFOLDER 'TIF_SuppFigure4_colorbarJet.TIF']);

%%
disp('This is the end of the ershovwehrensallfigures.m script.');
















