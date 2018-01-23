%% Load asymmetry pattern (S vs Lmother) - the pattern in the Fig. 1

% load(['path\asymmetry_pattern_all.mat'])
% the original pattern had a variable called A;

% To load data from Martijn's analysis
%{
x=[myLengthSumNewborns{:}]';
y=[Ratios{:}]';
%}

if ~exist('MARTIJNSTYLE','var')
    disp('Set MARTIJNSTYLE=1 to avoid loading A');
    x = A(:,1);
    y = A(:,2);
end
 



%% DETECT THE CLUSTERS

% target amount of clusters
N = 15;

% There are different ways of calculating the clusters, lets list all main parameters:
metrics_list     = {'euclidean','seuclidean','cityblock' ,'minkowski' ,...
                    'chebychev' ,'mahalanobis' ,'cosine' ,'correlation',...
                    'spearman','hamming','jaccard'};
distances_list   = {'average','centroid' ,'complete' ,'median' , 'single' ,'ward', 'weighted'};


% One can go through each way of calculating and pick the best one.
% Here I choose the metric #2
% Here I choose the distance #1
for mm = 2 % 1:length(metrics_list)
    
    for dd  = 1 % 1:length(distances_list)
        
        % typical usage of clustering routines:
        z = linkage([x,y], distances_list{dd}, metrics_list(mm));
        c = cluster(z,'maxclust', N);
        %t = clusterdata(z, 'maxclust',N);
        
        %colors=linspecer(max(c));
        % use colors(c) below instead of c to make more clear; but note
        % there is also more clear plot in next section.
        
        figure;
        scatter(x,y,10, c, 'filled')
        title(['dist: ' distances_list{dd} '; metric: ' metrics_list{mm}])
    end
end


%% SHOW SEPARATE CLUSTERS
figure(2); clf; hold on;
myColors = jet(N);
myColors = linspecer(max(c));

for i = 1:N % go over each cluster
    
    % data subset, belonging to current cluster
    x_i = x(c == i);
    y_i = y(c == i);
    
    plot(x_i, y_i, 'o', 'MarkerFaceColor', myColors(i,:),'MarkerEdgeColor', 0.7*cols(i,:))
    plot(mean(x_i), mean(y_i), 's', 'MarkerFaceColor', 'k','MarkerEdgeColor', 0.0*cols(i,:))
    %plot(mean(x_i), mean(y_i), 's', 'MarkerFaceColor', 0.7*cols(i,:),'MarkerEdgeColor', 0.0*cols(i,:))    
    text(mean(x_i), mean(y_i), ['cluster ' num2str(i)])
    
    % mean_y_i = mean(y_i);
    % std_y_i = std(y_i);
end

ylim([0,1]);

xlabel('Length before division');
ylabel('Division ratio');

MW_makeplotlookbetter(12);



%% WE HAVE CLUSTERS, SO WHAT?
% In each of the clusters representing shortest daughters ('short_daughter_clusters' below)
% there seem to be a size limit for the daughter; or, rephrasing:
% in each length regime, there is a size limit for shortest daughters. 
% Lets call it "daughter lock size".
% Bewlow we want to show that this lock size seems to be constant for ANY
% mother length; suggesting that it is some sort of intrinsic, fundamental 
% property of the cell size.
% For this we show that the length regimes change so that the "lock size" is kept constant.

if ~exist('MARTIJNSTYLE','var');

    short_daughter_clusters     = [13 9 4 3 14]; 
    x_last_points_in_clusters   = [];
    y_last_points_in_clusters   = [];

    for  i = short_daughter_clusters

        x_i = x(c == i);
        y_i = y(c == i);

        % find the rightmost point in this cluster
        max_x = max(x_i);
        max_y = y_i(x_i == max_x);

        % for the cluster 13 I applied more complex routin for detecting the
        % rigth most point, because its shape is concave    
         if i == 13
             % set of ys, which are close to 0.5:
             y_sub = y_i(abs(y_i-0.5) <= 0.02);
             x_sub = x_i(ismember(y_i,y_sub));

             max_x = max(x_sub);
             max_y = y_sub(x_sub == max_x);
             if length(max_y)>1
                 max_y = mean(max_y); max_x = mean(max_x);
             end
             % plot(x_sub, y_sub,'k.')
         end

        x_last_points_in_clusters = [x_last_points_in_clusters, max_x];
        y_last_points_in_clusters = [y_last_points_in_clusters, max_y];

        plot(max_x, max_y, 'kx', 'LineWidth', 3, 'MarkerSize', 15)
    end

    % show that we can describe daughter/mother  relationship
    % with constant lockDaughterSize.
    daughter_lock_size      = 4.4; 
    motherLengths           = [daughter_lock_size*2 : 40];
    S_ratio                 = daughter_lock_size./motherLengths;
    plot(motherLengths, S_ratio, 'k--', 'LineWidth',2)
end

%% Let's confirm earlier claimed ratios

figure(3); clf; hold on;

% confirming the ratios
theMeanXValues = []; theMeanYValues = [];
for clusterIdx = 1:max(c)
    xThisCluster = x(find(c==clusterIdx));
    yThisCluster = y(find(c==clusterIdx));
    
    plot(xThisCluster,yThisCluster,'o','Color',myColors(clusterIdx,:));
    
    meanxThisCluster=mean(xThisCluster);
    meanyThisCluster=mean(yThisCluster);
    
    infotext = sprintf('x= %.2f, y= %.2f', meanxThisCluster, meanyThisCluster);
    text(meanxThisCluster,meanyThisCluster,infotext);%,'FontWeight','bold','BackgroundColor',[.7 .7 .7])    
    
    theMeanXValues(end+1) = meanxThisCluster;
    theMeanYValues(end+1) = meanyThisCluster;
end

ratiosWeClaim = [1/2, [1,3]/4, [1,3,5]/6, [1,3,5,7]/8]
%title(num2str(ratiosWeClaim));

ylim([0,1]);

xlabel('Length before division');
ylabel('Division ratio');

MW_makeplotlookbetter(12);


% (Some statistical testing would be nice, but it  is an extremely tight
% match.)

%% getting the length of the regimes
% ===

figure(4); clf; hold on;

% First plot the distributions

widthsOfRegimes=[]; allRegimes ={};
for clusterIdx = 1:max(c)

    xThisCluster = x(find(c==clusterIdx));
    yThisCluster = y(find(c==clusterIdx));
   
    [counts,edges]=histcounts(xThisCluster);
    dx=edges(2)-edges(1);
    centers = (edges(2:end)+edges(1:end-1))/2;
    
    plot(centers, counts/(sum(counts)*dx),'-','Color',myColors(clusterIdx,:));    
    
    % do some quick and dirty stats
    xThisClusterSorted=sort(xThisCluster);
    %yThisClusterSorted=sort(yThisCluster);
    
    bound90leftidx  = ceil(numel(xThisCluster)*5/100);
    bound90rightidx = floor(numel(xThisCluster)*95/100);
    
    plot([xThisClusterSorted(bound90leftidx), xThisClusterSorted(bound90rightidx)],[1,1],'o-','Color',myColors(clusterIdx,:),'LineWidth',2);        
    
    currentWidth = xThisClusterSorted(bound90rightidx)-xThisClusterSorted(bound90leftidx);
    widthsOfRegimes(end+1)= currentWidth;
    
    text(xThisClusterSorted(bound90leftidx),mean(yThisCluster),num2str(currentWidth));
    
    allRegimes{end+1} = [xThisClusterSorted(bound90leftidx), xThisClusterSorted(bound90rightidx)];
    
end

% cosmetics

xlabel('Length before division');
ylabel('Normalized probability');

MW_makeplotlookbetter(12);

widthsOfRegimes

% Show bounds in unit size in earlier figure
figure(3);

% identify most left cluster
smallestLengthsClusterIndex = find(theMeanXValues==min(theMeanXValues(theMeanXValues>0)));
% get stats
xThisCluster = x(find(c==smallestLengthsClusterIndex));
%yThisCluster = y(find(c==smallestLengthsCluster));
lengths = [0:.1:40];

line1=.5./(lengths./theMeanXValues(smallestLengthsClusterIndex));
toShowIdxs=line1<=0.5;
plot(lengths(toShowIdxs),line1(toShowIdxs),'-k');

line2=.5./(lengths./allRegimes{smallestLengthsClusterIndex}(1));
toShowIdxs=line2<=0.5;
plot(lengths(toShowIdxs),line2(toShowIdxs),'--k');

line3=.5./(lengths./allRegimes{smallestLengthsClusterIndex}(2));
toShowIdxs=line3<=0.5;
plot(lengths(toShowIdxs),line3(toShowIdxs),'--k');

%% do the same for other cluster

fitClusterIndex = 2;

% get stats
xThisCluster = x(find(c==fitClusterIndex));
%yThisCluster = y(find(c==smallestLengthsCluster));
lengths = [0:.1:40];

line1=theMeanYValues(fitClusterIndex)./(lengths./theMeanXValues(fitClusterIndex));
toShowIdxs=line1<=0.5;
plot(lengths(toShowIdxs),line1(toShowIdxs),'-','Color','b');

line2=theMeanYValues(fitClusterIndex)./(lengths./allRegimes{fitClusterIndex}(1));
toShowIdxs=line2<=0.5;
plot(lengths(toShowIdxs),line2(toShowIdxs),'--','Color','b');

line3=theMeanYValues(fitClusterIndex)./(lengths./allRegimes{fitClusterIndex}(2));
toShowIdxs=line3<=0.5;
plot(lengths(toShowIdxs),line3(toShowIdxs),'--','Color','b');



theMeanXValues(end+1) = meanxThisCluster;