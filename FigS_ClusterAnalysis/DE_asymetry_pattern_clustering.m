%% Load asymmetry pattern (S vs Lmother) - the pattern in the Fig. 1

% load(['path\asymmetry_pattern_all.mat'])
% the original pattern had a variable called A;

x = A(:,1);
y = A(:,2);
 



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
        
        figure;
        scatter(x,y,10, c, 'filled')
        title(['dist: ' distances_list{dd} '; metric: ' metrics_list{mm}])
    end
end


%% SHOW SEPARATE CLUSTERS
figure;
hold on
cols = jet(N);
for i = 1:N % go over each cluster
    
    % data subset, belonging to current cluster
    x_i = x(c == i);
    y_i = y(c == i);
    
    plot(x_i, y_i, 'o', 'MarkerFaceColor', cols(i,:),'MarkerEdgeColor', 0.7*cols(i,:))
    plot(mean(x_i), mean(y_i), 's', 'MarkerFaceColor', 0.7*cols(i,:),'MarkerEdgeColor', 0.0*cols(i,:))
    text(mean(x_i), mean(y_i), ['cluster ' num2str(i)])
    
    % mean_y_i = mean(y_i);
    % std_y_i = std(y_i);
end





%% WE HAVE CLUSTERS, SO WHAT?
% In each of the clusters representing shortest daughters ('short_daughter_clusters' below)
% there seem to be a size limit for the daughter; or, rephrasing:
% in each length regime, there is a size limit for shortest daughters. 
% Lets call it "daughter lock size".
% Bewlow we want to show that this lock size seems to be constant for ANY
% mother length; suggesting that it is some sort of intrinsic, fundamental 
% property of the cell size.
% For this we show that the length regimes change so that the "lock size" is kept constant.

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
