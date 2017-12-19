% Run the following code first:
%{
mw_getstatisticsandmakefigure;
%}

if ~exist('WINDOWBORDERS','var')
    WINDOWBORDERS   = [3:6:36];
end

THESIMULATEDLENGHTS = [2:101];
if numel(THESIMULATEDLENGHTS)~=size(output.F.prettyOutputImage,1)
    warning('The # elements in your simulation and given by THESIMULATEDLENGHTS are inconsistent.');
    % THESIMULATEDLENGHTS are e.g. used for calculating the x axis
end

%% Get data from Rutger's experiment.
WHATDATA = 'tetracycline';
NOSAVEPLEASE=1;

RUNSECTIONSFILADIV = 'loadData';
script20160429_filamentRecoveryDivisionRatioss

RUNSECTIONSFILADIV = 'calculateRatios';
script20160429_filamentRecoveryDivisionRatioss

%% Merge the data

allRatios = [Ratios{:}];
allLengthSumNewborns = [myLengthSumNewborns{:}];

%% Create fake data based on our regimes

allFakeRatios=[];
allFakeLenghts=[];
for L=9:.1:20.9
    n=round(L/(2*3));
    for m=1:n
        allFakeRatios(end+1)=(2*m-1)/(2*n);
        allFakeLenghts(end+1)=L;
    end
end

%{
figure; plot(allFakeLenghts,allFakeRatios, '.');
%}

%% Fit the data
FITMETHOD='MANUAL'; % choose either FAKEDATA or REALDATA or MANUAL

%CUTOFFLENGTHS=[6,21];%6;
CUTOFFLENGTHS=[0,99999];%6;

if strcmp(FITMETHOD,'FAKEDATA')
    lengthsToFit    = allFakeLenghts;
    ratiosToFit     = allFakeRatios;
else
    lengthsToFit    = allLengthSumNewborns;
    ratiosToFit     = allRatios;
end

% figure;histogram(AllLengthSumNewborns)
selectionIndices = CUTOFFLENGTHS(1)<lengthsToFit & lengthsToFit<CUTOFFLENGTHS(2);
selectedRatios = ratiosToFit(selectionIndices);
selectedLengthSumNewborns = lengthsToFit(selectionIndices);


%roundedAllLengthSumNewborns = round(AllLengthSumNewborns);

% Create paddedSimData, which has zero's where a concentration was not
% simulated
%leftPadSize = min(THESIMULATEDLENGHTS)-1;
paddedSimData = [...zeros(leftPadSize, size(output.F.prettyOutputImage,2));...
                 output.F.prettyOutputImage;...
                 zeros(100, size(output.F.prettyOutputImage,2));];

% ratiosInPixels = round((AllRatios.*lengthLongestCell));
% correspondingConcentrations = paddedSimData(ind2sub(roundedAllLengthSumNewborns,ratiosInPixels));
% figure; imshow(paddedSimData);
% mytestfun = @(x) x(1).^2+x(2).^2

% Define error function which retrieves and square-sums the concentrations that
% are "hit" by each datapoint.
myErrorFun = @(x) -sum( paddedSimData(sub2ind(...
                                        ... use sub2ind for accessing the simulated ocncentrations multiple times
                                        size(paddedSimData),...                                       
                                        ... get rescaled rounded length, use it to access corresponding entry of paddedSimData
                                        ... use arrayfun and min/max to give hard bounds to the indices
                                        arrayfun(@(y) max(1, min( y  , size(paddedSimData,1))), round(selectedLengthSumNewborns.*x(2) + x(1))),...
                                        ... use the ratios to access corresponding entries of paddedSimData
                                                 round(selectedRatios.*lengthLongestCell)...
                                        ))  .^2 );
                     
% Use fminsearch to find minimum of that function (note the minus sign above)
linearFitValues = fminsearch(myErrorFun,[0,2])

if strcmp(FITMETHOD,'MANUAL')
    linearFitValuesActual = linearFitValues;
    linearFitValues=[0,2.24];
    warning('You set your fit in the manual way..');
end
%%

if exist('plotMore','var')
    
    % Show rawer error function 
    mynumbers = [.1:.25:6];
    figure; hold on;
    for offset = 0:0
         plot(mynumbers,arrayfun(@(x) myErrorFun([offset,x]), mynumbers ));
    end
    
    % Show rawer fit
    figure; hold on;
    imagesc(paddedSimData)

    %scatter(selectedRatios.*lengthLongestCell,selectedLengthSumNewborns.*linearFitValues(2)+linearFitValues(1),'.r');
    scatter(allRatios.*lengthLongestCell,allLengthSumNewborns.*linearFitValues(2)+linearFitValues(1),'.r');
end

%% Plot fitted ratios
figure(h2); hold on;
%{
for dataSetIndex = 1:numel(datasetsPaths)
    % calculate ratios
    %scatter(myLengthSumNewborns{dataSetIndex},Ratios{dataSetIndex}.*size(output.F.prettyOutputImage,2),'.k');

    % ratios w. rescaled lengths
    scatter(myLengthSumNewborns{dataSetIndex}.*linearFitValues(2)+linearFitValues(1),...-leftPadSize,...
            Ratios{dataSetIndex}.*size(output.F.prettyOutputImage,2),'.r');
        
end
%}
%scatter(allLengthSumNewborns.*linearFitValues(2)+linearFitValues(1),allRatios.*size(output.F.prettyOutputImage,2),'.r');
scatter(allLengthSumNewborns.*linearFitValues(2)+linearFitValues(1),allRatios.*size(output.F.prettyOutputImage,2),3^2,[.5 .5 .5],'filled');

% Now xticks can be set.
inputSettings.rangeIn = [0 THESIMULATEDLENGHTS(end)];
inputSettings.rangeOut = (inputSettings.rangeIn-linearFitValues(1))./linearFitValues(2);
inputSettings.desiredSpacing = 5;
inputSettings.desiredDecimalsTicks = 0;
[tickLocationsOldMetric, correspondingLabels] = labelremapping(inputSettings);

% Update ticks and labels
set(gca, 'XTick',tickLocationsOldMetric,'XTickLabel',correspondingLabels);
xlabel('Length of cell (µm)');

% ratios w. rescaled lengths
%scatter(selectedLengthSumNewborns.*linearFitValues(2)+linearFitValues(1)-leftPadSize,...
%        selectedRatios.*size(output.F.prettyOutputImage,2),'.r');

%%
%{
WINDOWBORDERS = [3:6:40];
if PLOTHELPINGLINES
    N=5;
    for windowIndex=1:(numel(WINDOWBORDERS)-1)
        for j = 1:2:(windowIndex*2-1)
            plot([WINDOWBORDERS(windowIndex),WINDOWBORDERS(windowIndex+1)].*linearFitValues(2)+linearFitValues(1),...
                  [(j)/(2*windowIndex) (j)/(2*windowIndex)].*size(output.D.prettyOutputImage,2),...
                  '-','LineWidth',8,'Color','k');%,'Color',BARCOLORS(windowIndex,:))
        end
    end
end    
%}