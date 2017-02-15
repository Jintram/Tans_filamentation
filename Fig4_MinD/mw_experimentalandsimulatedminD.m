

%% Print experimental profiles by Dmitry and print profiles from simulations

% Load the profiles first!
% DE_plot_rescaled_profiles_MinD

%LINECOLOR = [230 30 37]./255; % red
LINECOLOR = [65 148 68]./255 % green

%% Process and normalize the profiles
%myExpMinFigs=[];
SELECTEDPLOTS=[1,3,5];
SELECTEDSIMLOCATIONS=[3.5, 31, 60];
hExpMinFigs=figure(3); clf;
axes = []; leg = [];
for ii=1:numel(SELECTEDPLOTS)
    theDataIndex=SELECTEDPLOTS(ii);
    
    % Note that the corresponding profile can be calculated from the fit. So
    simulationIndex = round(A(theDataIndex).length_range.*linearFitValues(2)+linearFitValues(1)-leftPadSize);
    simulationIndex = round(SELECTEDSIMLOCATIONS(ii));
    % calculate simulated profile
    currentSimProfile      = theMeanProfilesD{simulationIndex};
    currentSimProfileStd   = theStdProfilesD{simulationIndex};
    normcurrentSimProfile = (currentSimProfile-min(currentSimProfile))./(max(currentSimProfile)-min(currentSimProfile));
    %normcurrentSimProfile = .5+.5.*(currentSimProfile-min(currentSimProfile))./(max(currentSimProfile)-min(currentSimProfile))
    %    warning('NOTE MW: I have just added some number to the profile to get a prettier image; this is only OK when plotting A.U.');
    %normcurrentProfile = (currentProfile)./(max(currentProfile))
    normcurrentProfileStd  = (currentSimProfileStd-min(currentSimProfile))./(max(currentSimProfile)-min(currentSimProfile))
    currentSimProfileX = (1/numel(currentSimProfile):1/numel(currentSimProfile):1) - .5*1/numel(currentSimProfile);

    % Get experimental data
    currentXData = A(theDataIndex).x;
    currentYData = A(theDataIndex).y;
    normcurrentXData = A(theDataIndex).x./max(A(theDataIndex).x);
    normcurrentYData = (currentYData-min(currentYData))./(max(currentYData)-min(currentYData));
    %normcurrentYData = (currentYData)./(max(currentYData));

    % Add location to previous figure
    if ~exist('NOSIMPLOTTING','var')
        figure(h2); plot(simulationIndex,1,'vk','LineWidth',3,'MarkerFaceColor','k');
    end

    % create new fig
    figure(hExpMinFigs); axes(ii)=subplot(numel(SELECTEDPLOTS),1,ii); hold on;
    %myExpMinFigs(theDataIndex)=figure; clf; hold on;    
    
    if ~exist('NOSIMPLOTTING','var')
        % plot simulated data profile
        plot(currentSimProfileX,normcurrentSimProfile,':','LineWidth',3,'Color',[.5 .5 .5]); 
        plot(currentSimProfileX,normcurrentSimProfile,'LineWidth',3,'Color',LINECOLOR);   
        %errorbar(currentSimProfileX,normcurrentProfile,normcurrentProfileStd,'Color',[.5 .5 .5]);
        
        % plot experimental data (normalized x)
        plot(normcurrentXData,normcurrentYData,'LineWidth',3,'Color','k');   
    else
        % plot experimental data with x-axis
        plot(currentXData,normcurrentYData,'LineWidth',3,'Color',LINECOLOR);
        xlim([0 max(currentXData)])
    end

    % cosmetics    
    ylim([0.25 1])
    %ylim([0 1])
    %title(theDataIndex);
    
    if ii==3
        xlabel('Cellular axis [\mum]')
    end
    if ii==2
        ylabel('Normalized MinD-YFP signal')
    end
        
    %leg(ii)=legend(theText,'Location','EastOutside');
    %theText=[num2str(round(A(theDataIndex).length_range)) '\mum'];
    %text(A(theDataIndex).length_range*.1,0.45,theText,'Color','k');%,'BackgroundColor',[1 1 1])
    
    inputSettings.rangeIn = [0,max(A(theDataIndex).x)];
    inputSettings.rangeOut = round([0,A(theDataIndex).length_range]*10)/10;
    inputSettings.desiredSpacing = round(A(theDataIndex).length_range*10)/10;
    [tickLocationsOldMetric, correspondingLabels] = labelremapping(inputSettings) 
    set(gca, 'XTickLabel',correspondingLabels, 'XTick',tickLocationsOldMetric);
    
    MW_makeplotlookbetter(20);
    
end
   
%%

% Align plots
%{
pos=get(axes,'position')
%pmat=cat(1,pos{:});
posmat=cell2mat(pos);
left  = posmat(:,1);
sizes = posmat(:,3)*.9;
posmat(:,1) = ones(3,1)*min(left);
%posmat(:,1) = 1-max(sizes);
posmat(:,3) = ones(3,1)*max(sizes);
% set
set(axes,{'position'},num2cell(posmat,2));
%}

% Align legends
%{
pos=get(leg,'position')
%pmat=cat(1,pos{:});
posmat=cell2mat(pos)
left  = posmat(:,1);
sizes = posmat(:,3);
posmat(:,1) = ones(3,1)*min(left);
%posmat(:,1) = 1-max(sizes);
posmat(:,3) = ones(3,1)*max(sizes);
% set
set(leg,{'position'},num2cell(posmat,2))
%}


