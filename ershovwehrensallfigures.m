



%% This script generates all figures for the Ershov/Wehrens et al paper.
% 
% 

% TODOs
% 1) Add line in fig 1d
% 2) Create distributions for division times for different lengths

OUTPUTFOLDER = 'D:\Local_Data\Dropbox\Dropbox\Filamentation recovery\MW\figures_new\Matlab_export2\';
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
saveas(hFig2AC,[OUTPUTFOLDER 'TIF_Figure2A.tif'],'tif');
saveas(hFig2AC,[OUTPUTFOLDER 'FIG_Figure2A.fig'],'fig');
saveas(hFig2AC,[OUTPUTFOLDER 'EPS_Figure2A.eps'],'epsc');

%print([OUTPUTFOLDER 'EPS_Figure2A.eps'],'-depsc');

%% (2b) 
% Interdivision time against birth size for tetracycline
WHATDATA = 'tetracycline';
NOSAVEPLEASE=1;
LENGTHFIELD = 'length_fitNew';

YLIMbirthlife=[0,150];

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

script20161221_filarecovery_birthSizeLifeTimeDynamics_all

figure(hFigSIIC);
SIZE=[7.5,5.63];
%SIZE=[5,5.63];
OFFSET = [2,2];
set(hFigSIIC,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFigSIIC,'RendererMode','manual','Renderer','Painters');

saveas(hFigSIIC,[OUTPUTFOLDER 'SVG_Figure2C.svg'],'svg');
saveas(hFigSIIC,[OUTPUTFOLDER 'TIF_Figure2C.tif'],'tif');
saveas(hFigSIIC,[OUTPUTFOLDER 'FIG_Figure2C.fig'],'fig');
saveas(hFigSIIC,[OUTPUTFOLDER 'EPS_Figure2C.eps'],'epsc');

%% (2d)+supp 
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
FIGLABELS={'','E','F'};
for whichFig=2:3
    figure(hAdderFigs(whichFig));
    %SIZE=[7.5,5.63];
    SIZE=[7.5,5.63];
    OFFSET = [2,2];
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
SIZE=[7.5, 5.63];
OFFSET = [2,2];
MW_makeplotlookbetter(10*2);
set(hFig2AC,'Units','centimeters','Position',[OFFSET SIZE]*2);%,...
            %'PaperUnits','centimeters','PaperSize',SIZE*2);

saveas(hFig2AC,[OUTPUTFOLDER 'SVG_FigureS_IIA.svg']);
saveas(hFig2AC,[OUTPUTFOLDER 'TIF_FigureS_IIA.tif']);
saveas(hFig2AC,[OUTPUTFOLDER 'FIG_FigureS_IIA.fig']);

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
SIZE=[7.5,5.63];
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

YLIMbirthlife=[0,150];

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

saveas(hFig2BD,[OUTPUTFOLDER 'SVG_FigureS_II_C.svg'],'svg');
saveas(hFig2BD,[OUTPUTFOLDER 'TIF_Figure_II_C.tif'],'tif');
saveas(hFig2BD,[OUTPUTFOLDER 'FIG_Figure_II_C.fig'],'fig');
saveas(hFig2BD,[OUTPUTFOLDER 'EPS_Figure_II_C.eps'],'epsc');



%% supp (s2b) 
% Interdivision time against birth size for sulA
WHATDATA = 'temperature';
LENGTHFIELD = 'length_skeleton';
NOSAVEPLEASE=1;

YLIMbirthlife=[0,150];

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

%% (4b)
clear schnitzcells;
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

saveas(hfig4B,[OUTPUTFOLDER 'SVG_Figure4B.svg'],'svg');
saveas(hfig4B,[OUTPUTFOLDER 'TIF_Figure4B.tif'],'tif');
saveas(hfig4B,[OUTPUTFOLDER 'FIG_Figure4B.fig'],'fig');
saveas(hfig4B,[OUTPUTFOLDER 'EPS_Figure4B.eps'],'epsc');

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

%% (4c)

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
SIZE=[7.5,5.63];
OFFSET = [2,2];
set(hSupp5,'Units','centimeters','Position',[OFFSET SIZE]*2)
MW_makeplotlookbetter(10*2,optionalParameters);

set(hSupp5,'RendererMode','manual','Renderer','Painters');

saveas(hSupp5,[OUTPUTFOLDER 'SVG_SFigure4A.svg']);
saveas(hSupp5,[OUTPUTFOLDER 'TIF_SFigure4A.tif']);
saveas(hSupp5,[OUTPUTFOLDER 'FIG_SFigure4A.fig']);

%% (s4b)
% Temperature data divisions
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
SIZE=[7.5,5.63];
OFFSET = [2,2];
set(hSupp5,'Units','centimeters','Position',[OFFSET SIZE]*2)
MW_makeplotlookbetter(10*2,optionalParameters);

set(hSupp5,'RendererMode','manual','Renderer','Painters');

saveas(hSupp5,[OUTPUTFOLDER 'SVG_SFigure4B.svg']);
saveas(hSupp5,[OUTPUTFOLDER 'TIF_SFigure4B.tif']);
saveas(hSupp5,[OUTPUTFOLDER 'FIG_SFigure4B.fig']);


%%

%% (s4c)
% Temperature data divisions
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

    % saving the figure
    %SIZE=[6.8,6.8];
    SIZE=[7.5,5.63];
    OFFSET = [2,2];
    set(hSupp5,'Units','centimeters','Position',[OFFSET SIZE]*2)
    MW_makeplotlookbetter(10*2,optionalParameters);

    set(hSupp5,'RendererMode','manual','Renderer','Painters');

    saveas(hSupp5,[OUTPUTFOLDER 'SVG_SFigure4' figLetters{otherConcentrationIdx} '.svg']);
    saveas(hSupp5,[OUTPUTFOLDER 'TIF_SFigure4' figLetters{otherConcentrationIdx} '.tif']);
    saveas(hSupp5,[OUTPUTFOLDER 'FIG_SFigure4' figLetters{otherConcentrationIdx} '.fig']);
    
end
    

%% (s5) Relative division location against time

WHATDATAS = {'tetracycline','temperature','sulA'};
LENGTHFIELDS = {'length_fitNew','length_skeleton','length_skeleton'};
FIGLABELS = {'A','B','C'}
NOSAVEPLEASE=1;

for conditionIdx=1:3

    WHATDATA=WHATDATAS{conditionIdx};
    LENGTHFIELD=LENGTHFIELDS{conditionIdx};

    RUNSECTIONSFILADIV = 'loadData';
    script20160429_filamentRecoveryDivisionRatioss

    RUNSECTIONSFILADIV = 'calculateRatios';
    script20160429_filamentRecoveryDivisionRatioss

    RUNSECTIONSFILADIV = 'SlocationAgainstTime';
    script20160429_filamentRecoveryDivisionRatioss

    hS6 = hSvsT;

    % saving the figure
    SIZE=[5 5];
    %SIZE=[7.5,5.63];
    OFFSET = [2,2];
    set(hS6,'Units','centimeters','Position',[OFFSET SIZE]*2)
    MW_makeplotlookbetter(10*2,optionalParameters);

    set(hS6,'RendererMode','manual','Renderer','Painters');

    saveas(hS6,[OUTPUTFOLDER 'SVG_SFigure5' FIGLABELS{conditionIdx} '.svg']);
    saveas(hS6,[OUTPUTFOLDER 'TIF_SFigure5' FIGLABELS{conditionIdx} '.tif']);
    saveas(hS6,[OUTPUTFOLDER 'FIG_SFigure5' FIGLABELS{conditionIdx} '.fig']);
    
end

%% (s7b) ring count versus length

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

%% (s7c) show interdivision time normalized with ring count

% run previous section first to load and analyze data (s7b)

% obtain interdiv plots for all datasets
script20161221_filarecovery_birthSizeLifeTimeDynamics_all

% get specific required data for the temperature stuff
WHATDATA     = 'temperature'; %'tetracycline','temperature','sulA'};
LENGTHFIELD  = 'length_skeleton'; %'length_fitNew','length_skeleton','length_skeleton'};

CUSTOMXLIM=[0,40];

RUNSECTIONSFILADIV='loadData';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILEFTS='getAges';
script20160422_filamentRecoveryFtslabelLocations

RUNSECTIONSFILEFTS='analyzeData';
script20160422_filamentRecoveryFtslabelLocations

RUNSECTIONSFILADIV = 'lifeTimeVsBirthLength2';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILEFTS='ringCountVsLength';
script20160422_filamentRecoveryFtslabelLocations

RUNSECTIONSFILADIV = 'interdivVsLengthNormalizedWithRingCount';
script20160429_filamentRecoveryDivisionRatioss

figure(hFigS7C);
SIZE=[7.5, 6.5];
OFFSET = [2,2];
set(hFigS7C,'Units','centimeters','Position',[OFFSET SIZE]*2,...
            'PaperUnits','centimeters','PaperSize',SIZE);
MW_makeplotlookbetter(10*2);

set(hFigS7B,'RendererMode','manual','Renderer','Painters');

saveas(hFigS7C,[OUTPUTFOLDER 'SVG_FigureS7C_' WHATDATA '.svg'],'svg');
saveas(hFigS7C,[OUTPUTFOLDER 'TIF_FigureS7C_' WHATDATA '.tif'],'tif');
saveas(hFigS7C,[OUTPUTFOLDER 'FIG_FigureS7C_' WHATDATA '.fig'],'fig');
saveas(hFigS7C,[OUTPUTFOLDER 'EPS_FigureS7C_' WHATDATA '.eps'],'epsc');
    
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

%% (s9a)

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
SIZE=[7.5,5.63];
OFFSET = [2,2];
set(hlocPref,'Units','centimeters','Position',[OFFSET SIZE]*2)
MW_makeplotlookbetter(10*2,optionalParameters);

set(hlocPref,'RendererMode','manual','Renderer','Painters');

saveas(hlocPref,[OUTPUTFOLDER 'SVG_FigureS9A.svg']);
saveas(hlocPref,[OUTPUTFOLDER 'TIF_FigureS9A.tif']);
saveas(hlocPref,[OUTPUTFOLDER 'FIG_FigureS9A.fig']);

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

%% (s9b) manual plotting based on figure & caption Dmitry
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
SIZE=[7.5,5.63];
OFFSET = [2,2];
set(hDECorrRing,'Units','centimeters','Position',[OFFSET SIZE]*2)
MW_makeplotlookbetter(10*2,optionalParameters);

set(hDECorrRing,'RendererMode','manual','Renderer','Painters');

saveas(hDECorrRing,[OUTPUTFOLDER 'SVG_FigureS9B.svg']);
saveas(hDECorrRing,[OUTPUTFOLDER 'TIF_FigureS9B.tif']);
saveas(hDECorrRing,[OUTPUTFOLDER 'FIG_FigureS9B.fig']);

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

%%
disp('This is the end of the ershovwehrensallfigures.m script.');
















