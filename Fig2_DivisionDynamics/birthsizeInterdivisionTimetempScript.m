%{

figure(20); clf; hold on;

%regimeBounds = [0,7.35,13.59,20];
regimeBounds = [0,7.35,13.97,20];
ringCounts = [1,2,3];

myColorsClusters = linspecer(numel(ringCounts));

%normalizedByRingsYData = NaN(size(selectedYdata));
normalizedByRingsYData={}; normalizedByRingsXData={};
for regimeIdx=1:(numel(regimeBounds)-1)
    
    
    
    currentBounds = regimeBounds(regimeIdx:regimeIdx+1);
    idxToTransfom = selectedXdata>currentBounds(1) & selectedXdata<currentBounds(2);    
    normalizedByRingsYData{regimeIdx} = selectedYdata(idxToTransfom).*ringCounts(regimeIdx);
    normalizedByRingsXData{regimeIdx} = selectedXdata(idxToTransfom);
   
    scatter(normalizedByRingsXData{regimeIdx},normalizedByRingsYData{regimeIdx},'filled',...
            'MarkerFaceColor',myColorsClusters(regimeIdx,:),'MarkerEdgeColor','none','MarkerFaceAlpha',1);
    
end



%%


for regimeIdx=1:(numel(regimeBounds)-1)
    [meanValuesForBinsDynData, binCentersDynData,stdValuesForBinsDynData,stdErrValuesForBins]=binnedaveraging({normalizedByRingsXData{regimeIdx}},{normalizedByRingsYData{regimeIdx}},myBins);
    errorbar(binCentersDynData,meanValuesForBinsDynData,stdValuesForBinsDynData,'ok-','LineWidth',3,'MarkerFaceColor','k');
end
    
    
%% cosmetics

xlabel('Birth size (um)');
ylabel(['Interdivision time (mins)' 10 'multiplied by ring count']);

MW_makeplotlookbetter(20);
    
%% Alternatively, divide by times unit size

figure(21); clf; hold on;

lenNormDataY = selectedYdata.*sqrt(selectedXdata);
lenNormDataY = selectedYdata.*selectedXdata;
scatter(selectedXdata,lenNormDataY,'filled',...
        'MarkerFaceColor',[.5 .5 .5],'MarkerEdgeColor','none','MarkerFaceAlpha',1);
[meanValuesForBinsDynData, binCentersDynData,stdValuesForBinsDynData,stdErrValuesForBins]=binnedaveraging({selectedXdata},{lenNormDataY},myBins);
    errorbar(binCentersDynData,meanValuesForBinsDynData,stdValuesForBinsDynData,'ok-','LineWidth',3,'MarkerFaceColor','k');    
    
ylim([0,150]);
xlim([0,20]);    

xlabel('Birth size (um)');
%ylabel(['Interdivision time (mins)' 10 'multiplied by sqrt size']);
ylabel(['Interdivision time (mins)' 10 'multiplied by size']);

MW_makeplotlookbetter(20);
    
    
%}    