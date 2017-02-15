
% Gather some statistics from simulations
%{
options.showResultFigure=0;

F_profiles_all_multipleRuns={}; D_profiles_all_multipleRuns={};
for simIdx = 1:100
    %%
    tic;
    [F_profiles_all_multipleRuns{end+1}, D_profiles_all_multipleRuns{end+1}] = f0_simulations(options);
    t2=toc;
    disp(['Simulation finished, took ' num2str(t2) ' seconds.']);
end
%}

load('D:\Local_Data\Dropbox\Dropbox\Filamentation recovery\MW\figures_new\Data\file20170210_simulationData.mat','F_profiles_all_multipleRuns','D_profiles_all_multipleRuns');
%% save

%...

%%

% Average over the profiles (or take median?)
theMeanProfilesF = {}; theMeanProfilesD = {};
for lengthIdx = 1:numel(F_profiles_all_multipleRuns{1})
    
    %%
    bacteriumProfilesThisLengthF=[];    
    bacteriumProfilesThisLengthD=[];
    for runIdx = 1:numel(F_profiles_all_multipleRuns)
        bacteriumProfilesThisLengthF = ...
            [bacteriumProfilesThisLengthF; F_profiles_all_multipleRuns{runIdx}{lengthIdx}];
        bacteriumProfilesThisLengthD = ...
            [bacteriumProfilesThisLengthD; D_profiles_all_multipleRuns{runIdx}{lengthIdx}];

    end
    theMeanProfilesF{lengthIdx} = mean(bacteriumProfilesThisLengthF);
    theStdProfilesF{lengthIdx} = std(bacteriumProfilesThisLengthF);
    theMedianProfilesF{lengthIdx} = median(bacteriumProfilesThisLengthF);
    
    theMeanProfilesD{lengthIdx} = mean(bacteriumProfilesThisLengthD);
    theStdProfilesD{lengthIdx} = std(bacteriumProfilesThisLengthD);
    theMedianProfilesD{lengthIdx} = median(bacteriumProfilesThisLengthD);
        
end

%%

dataNames={'F','D'};
allData.F = theMeanProfilesF;
allData.D = theMeanProfilesD;

for dataSetIdx = 1:numel(dataNames)

    % Create image with this profile
    currentData = allData.(dataNames{dataSetIdx});

    lengthLongestCell = max(arrayfun(@(x) numel(currentData{x}), [1:numel(currentData)]));
    %lengthLongestCell = max(arrayfun(@(x) numel(myData{x,1}), [1:numel(myData)]));
    numberOflengths = numel(currentData);

    % Create simple image array
    simpleOutputImage = zeros(numberOflengths,lengthLongestCell);
    % simpel output
    for i = 1:numberOflengths
        % normalize this data series
        cellProfile = currentData{i};
        %cellProfile = myData{i,:};
        cellProfile = cellProfile-min(cellProfile);

        % create output image
        simpleOutputImage(i,:) = [cellProfile zeros(1,lengthLongestCell-numel(currentData{i}))];
        %outputImage(i,:) = [cellProfile zeros(1,lengthLongestCell-numel(myData{i,:}))];
    end


    % Create prettier image array
    prettyOutputImage = zeros(numberOflengths,lengthLongestCell);
    % simpel output
    for i = 1:numberOflengths
        % normalize this data series
        cellProfile = currentData{i};
        cellProfile = cellProfile-min(cellProfile);
        % resize data to longest cell
        cellProfileResized = imresize(cellProfile,[1,lengthLongestCell],'Method','bilinear');

        % create output image
        prettyOutputImage(i,:) = cellProfileResized;
        %prettyOutputImage(i,:) = [cellProfile zeros(1,lengthLongestCell-numel(myData{i}))];
        %outputImage(i,:) = [cellProfile zeros(1,lengthLongestCell-numel(myData{i,:}))];
    end
   
    output.(dataNames{dataSetIdx}).simpleOutputImage=simpleOutputImage;
    output.(dataNames{dataSetIdx}).prettyOutputImage=prettyOutputImage;
    
end

%%

h1=figure(1); clf;
imagesc(imrotate(output.F.prettyOutputImage,90)); 

greenColorMap = makeColorMap([1 1 1],[65 148 68]./255);%,[105 189 69]./255)
colormap(greenColorMap);
%colorbar;

% recalculate y-axis
inputSettings.rangeIn = [size(output.F.prettyOutputImage,2),1];
inputSettings.desiredSpacing = .25;
inputSettings.rangeOut = [0,1];
[tickLocationsOldNewMetric, correspdongingLabels] = labelremapping(inputSettings);

set(gca,'XTick',[]);
set(gca,'YTick',tickLocationsOldNewMetric,'YTickLabel',correspdongingLabels);

xlabel('Length of cell [a.u.]');
ylabel(['Relative location along cell']);

%%
h2=figure(2); clf;
imagesc(imrotate(output.D.prettyOutputImage,90)); 

redColorMap = makeColorMap([1 1 1],[230 30 37]./255);%,[230 30 37]./255)
colormap(greenColorMap);
%colorbar;

inputSettings.rangeIn = [size(output.D.prettyOutputImage,2),1];
inputSettings.desiredSpacing = .25;
inputSettings.rangeOut = [0,1];
[tickLocationsOldNewMetric, correspdongingLabels] = labelremapping(inputSettings);

set(gca,'XTick',[]);
set(gca,'YTick',tickLocationsOldNewMetric,'YTickLabel',correspdongingLabels);

xlabel('Length of cell [a.u.]');
ylabel(['Relative location along cell']);

%%

figure;
imshow(imrotate(simpleOutputImage,90),[]);









