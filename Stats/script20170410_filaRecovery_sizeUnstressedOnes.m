
% Note the size of newborn cells is most interesting, none of datasets
% below have that info.


%%%%%%%%%%%%%%%%%%

% Note that I'm not sure these frames give the size of unstressed bacteria
% as it is unclear whether they have completely recovered. 
% It would be better to look at a clean M9+lac experiment.

load('G:\FilamentationRecoveryData\Rutger\F schijf AmolfBackup_3april2014\2013-12-09\pos3mw\data\pos3mw-Schnitz.mat');

FRAMENR=1704; %1685; % 1704

selectedSchnitzesIdxs = [schnitzcells.frame_nrs]==FRAMENR;
allSchnitzLengths = [schnitzcells.length_fitNew];

mean(allSchnitzLengths(selectedSchnitzesIdxs))

alllengths.data1 = [schnitzcells.length_fitNew];

%% maybe better to use Noreen's dataset
load('\\storage01\data\AMOLF\groups\tans-group\Former-Users\Walker\Experiments\Technical\2014-02-22\pos4crop\data\pos4crop-Schnitz.mat');

%
mean([schnitzcells.length_fitNew])
median([schnitzcells.length_fitNew])

% These give a pretty high average length, but also have been blasted by
% 300ms GFP every 6 frames..

%median(allSchnitzLengths(selectedSchnitzesIdxs))

figure;
histogram([schnitzcells.length_fitNew],100)

% BUT we're interested in birth sizes, so:
theBirthSizes = arrayfun(@(i) schnitzcells(i).length_fitNew(1), 1:numel(schnitzcells));
meanBirthSize = mean(theBirthSizes);
    

%alllengths.data1 = [schnitzcells.length_fitNew];

%% Or maybe another of Rutger's data sets

load('G:\FilamentationRecoveryData\Rutger\F schijf AmolfBackup_3april2014\2013-12-16\pos5mw\data\pos5mw-Schnitz.mat');
mean([schnitzcells.length_fitNew])

histogram([schnitzcells.length_fitNew],100)

alllengths.data3 = [schnitzcells.length_fitNew];


%%

totalMeanRR = mean([alllengths.data1 alllengths.data3]);