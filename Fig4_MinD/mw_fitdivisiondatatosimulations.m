% Run the following code first:
%{
mw_getstatisticsandmakefigure;
%}

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

%% Fit the data

% figure;histogram(AllLengthSumNewborns)
selectionIndices = allLengthSumNewborns>6;
selectedRatios = allRatios(selectionIndices);
selectedLengthSumNewborns = allLengthSumNewborns(selectionIndices);


%roundedAllLengthSumNewborns = round(AllLengthSumNewborns);
theSimulatedLengths = [15:100];

% Create paddedSimData, which has zero's where a concentration was not
% simulated
leftPadSize = min(theSimulatedLengths)-1;
paddedSimData = [zeros(leftPadSize, size(output.F.prettyOutputImage,2));...
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
                                        )) .^2 );
                     
% Use fminsearch to find minimum of that function (note the minus sign above)
linearFitValuesforPadded = fminsearch(myErrorFun,[0,2])


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
figure(h1); hold on;
for dataSetIndex = 1:numel(datasetsPaths)
    % calculate ratios
    %scatter(myLengthSumNewborns{dataSetIndex},Ratios{dataSetIndex}.*size(output.F.prettyOutputImage,2),'.k');

    % ratios w. rescaled lengths
    scatter(myLengthSumNewborns{dataSetIndex}.*linearFitValues(2)+linearFitValues(1)-leftPadSize,...
            Ratios{dataSetIndex}.*size(output.F.prettyOutputImage,2),'.k');
        
end

% ratios w. rescaled lengths
%scatter(selectedLengthSumNewborns.*linearFitValues(2)+linearFitValues(1)-leftPadSize,...
%        selectedRatios.*size(output.F.prettyOutputImage,2),'.r');