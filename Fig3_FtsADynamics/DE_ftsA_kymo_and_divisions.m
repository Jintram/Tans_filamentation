function theFigureHandles = DE_ftsA_kymo_and_divisions(choose_case, x_time_btw_frames,opts)

% choose_case               int 1,2,... - number of experiment.(there is a list in the local function 'make_path')
% x_time_btw_frames         in seconds - get from images of the experiment!!!!

% list of best examples (run these directly to see what this function gives):

% linear growth and div:
% DE_ftsA_kymo_and_divisions(18, 845)
% DE_ftsA_kymo_and_divisions(19, 845)
% DE_ftsA_kymo_and_divisions(20, 845)
% 
% exponential growth and division:
% DE_ftsA_kymo_and_divisions(21, 900)
% 900 is roughly - it was about 15 minutes in that exp.

% root folder for the experimental data (all the raw data is organized as
% follows:
% path_root\2014-08-26\pos1\
% path_root\2014-08-26\pos3\remeasured\
% path_root\...
%
% Addition MW
% - opts.hideExtraInfo=1    suppresses text that is not needed for 
%                           manuscript in overall kymograph
% - opts.whiteBackground    creates white background
%
% Note that the kymograph has a few negative-valued pixels that identify
% certain types of pixels, like background (0.0003) and separators
% (0.0001). If the max value of the kymographs is very low this might
% distort the picture.

% Original path from Dmitry:
%path_root                   = 'G:\DE_documents\AMOLF stuff\3_Rutgers_project\Recent Data\FtsA_analysis\';
% New path (MW):
path_root = '\\storage01\data\AMOLF\groups\tans-group\Biophysics\Experiments_Rutger\Dmitry\3_Rutgers_project\Recent Data\FtsA_analysis\';




%% Settings

Font_size                   = 6;
pix_to_micro                = 0.0406*2;

opts.centered_kymograph     = 1;
if ~isfield(opts,'contrast_int_against_black_background')
    opts.contrast_int_against_black_background = 1;
end
opts.plot_longest_kymo      = 1;
opts.int_in_time            = 1;
opts.lengths_in_time        = 1;
opts.show_invaginations     = 0;
opts.smoothing              = 3;
opts.plot_indices_txt       = 0;

% ticks rescaling:
opts.y_ticks_round          = 1;
opts.y_um_btw_pix           = pix_to_micro;
opts.y_manual_range.on      = 1;
opts.y_manual_range.y1      = 5;
opts.y_manual_range.y2      = 85;
opts.y_manual_range.y_step  = 5;

opts.x_ticks_round          = 1;
opts.x_time_btw_frames      = x_time_btw_frames; %in seconds - calculate from images of the experiment!!!!
opts.x_manual_range.on      = 1;
opts.x_manual_range.x1      = 50;
opts.x_manual_range.x2      = 650;
opts.x_manual_range.x_step  = 100;

% Options added by MW
opts.SeparatorLineColor     = [48/255, 197/255, 221/255]; % MW
opts.DY                     = 15; % y-distance over which to scan for previous separator line (decides where to print red lines)

% get paths:
path_i          = make_path(path_root, choose_case);

% Generate a cell B{} that contains all profiles in proper order.
% =============== This B{} is the cental part of this script ========
% =============== having B allows you to make any figure     ========
[B, temp_L]     = make_frame_list_and_form_B(path_i, opts);



% make 2d matrix (image) kymo from B. Clean doesnt contain borders between sister
% cells.
[kymograph, kymograph_clean] = make_kymo_from_B(B, temp_L, opts);

oldkymograph = kymograph;
backgroundIndices = (kymograph==-0.0003);

if isfield(opts,'normalize')
    datapile=kymograph(:);
    
    ignoreIndices = datapile<0;
    maxkymograph   = max(datapile);
    minkymograph   = min(datapile(~ignoreIndices));
    rangekymograph = maxkymograph-minkymograph;
    kymograph=(kymograph-minkymograph)./rangekymograph;
    
    % restore "marker" values
    kymograph(ignoreIndices)=oldkymograph(ignoreIndices);
end



if isfield(opts,'whiteBackground')
    kymograph(backgroundIndices) = max(kymograph(:));
end

% make kymo for the longest cell:
longest_cell_kymo = make_longest_cell_kymo(B, opts);




%% Export vars
theFigureHandles = [];


%% ====================   PLOTTING   ==================================
theFigureHandles = plot_ftsA_profiles_in_time(B, choose_case, theFigureHandles);



% Plotting of kymograph that is used in final figure
theFigureHandles(end+1)=figure; 
% show image:
% figure('position',[     213   433   653   430])

% Actual plotting of the kymograph
imagesc(kymograph);
myColormap = makeColorMap([0,0,0],[1,1,1]);
colormap(myColormap);
%colormap gray
hold on;

% plot the separators between cells

% Find separator pixels (indicated by value of -0.0001)
[row_yy, col_xx] = find(kymograph==-0.0001);

ysize=size(kymograph,1);
xsize=size(kymograph,2);
% plot([col_xx - 0.5, col_xx + 0.5], [row_yy, row_yy], 'r.')

% Add lines that demarcate cellular edges
for i=1:length(col_xx)
    
    plot([col_xx(i) - 0.5, col_xx(i) + 0.5 ], [row_yy(i), row_yy(i)], '-','LineWidth', 2,'Color',opts.SeparatorLineColor)    
       
    % This recognizes division separators based on the kymograph.
    % TODO: This might be more easily done if these pixels where marked
    % specifically.
    if ~any( kymograph(min(max(1,row_yy(i) + [-opts.DY:opts.DY]),ysize) , max(1,col_xx(i)-1) ) < 0)
        plot([col_xx(i) - 0.5, col_xx(i) + 0.5 ], [row_yy(i), row_yy(i)], '-','LineWidth', 2,'Color','r')
    end
    
end


title_short_path = path_i([strfind(path_i, 'FtsA_analysis\')+length('FtsA_analysis\')] : end);
if ~isfield(opts,'hideExtraInfo')
    title(num2str(choose_case))%({'exp name:', title_short_path})
    text(1,25, title_short_path, 'color', 'w', 'FontSize', Font_size)
end
disp(['Overall kymograph based on: ' title_short_path])

ylabel('Cellular axis (\mum)')%, 'FontSize', Font_size)
xlabel('Time (min)')

convert_x_y_ticks(opts);

if opts.plot_indices_txt
    plot_B_indeces(kymograph, B, kymograph_clean)
end


if opts.show_invaginations
    %these are the times of invagination appearnce:
    switch choose_case
        case 2
        case 4
        case 5
        case 6
        case 7
        case 8
        case 9
        case 10
        case 11
        case 12
            
        otherwise
            plot(frames_of_invag, y_coord_of_invag, 'k+', 'LineWidth', 3)
            plot(frames_of_invag, y_coord_of_invag, 'w.')
    end
end










% -----------   separate kymo for the longest cell:  ----------------------
if opts.plot_longest_kymo
    theFigureHandles(end+1)=figure;
    imagesc(longest_cell_kymo)
    colormap gray
    title('kymo for the longest cell')
    xlabel('time, min')
    ylabel('length, um') 
end

convert_x_y_ticks(opts);









% -------------   FtsA intensity profiles in time:   ----------------------
if opts.int_in_time 
    int_in_time_all = [];
    int_in_time_longest = [];
    
    for i = 1:size(longest_cell_kymo,2)
        int_in_time_longest = [int_in_time_longest, sum(longest_cell_kymo(:,i))];
    end
    for i = 1:size(kymograph,2)
        int_in_time_all = [int_in_time_all, sum(kymograph(:,i))];
    end
    
    theFigureHandles(end+1)=figure; hold on;
    plot(int_in_time_all,'r.-')
    plot(int_in_time_longest,'b.-')
    
    xlabel('time')
    ylabel('intensity, a.u.')
    
end












if opts.lengths_in_time    
    % "ADDER"?
    lll =[];
    
    for i = 1 : size(longest_cell_kymo,2)
        int_i = longest_cell_kymo(:,i);
        int_i_nonzero = int_i(int_i>0);
        lll = [lll, length(int_i_nonzero)];
    end
    theFigureHandles(end+1)=figure;
    plot(lll*pix_to_micro)
    hold on
    plot(abs(diff(lll*pix_to_micro)),'r')
end





end



%         ================   FUNCTIONS   ================================
function convert_x_y_ticks(opts)


if opts.y_ticks_round
    %round off the y ticks:
    y_ticks_pix = get(gca,'YTick');
    conversion_factor = opts.y_um_btw_pix;
    y_ticks_um = y_ticks_pix * conversion_factor;
    
    %or manual?
    if opts.y_manual_range.on
        warning('manual range')
        y1 = opts.y_manual_range.y1;
        y2 = opts.y_manual_range.y2;
        y_step = opts.y_manual_range.y_step;
    else
        y1 = floor(min(y_ticks_um));
        y2 = ceil(max(y_ticks_um));   
        y_step = 5;
    end
    
    y_ticks_um_rounded = [y1 : y_step : y2];
    y_ticks_pix_rounded = y_ticks_um_rounded / conversion_factor;
    %reset the ticks:
    set(gca, 'YTick', y_ticks_pix_rounded);
    %give them new names:
    set(gca, 'YTickLAbel', y_ticks_um_rounded);
end
    
    
if opts.x_ticks_round 
    x_ticks_frames = get(gca,'XTick');    
    conversion_factor = opts.x_time_btw_frames/60;
    x_ticks_mins = x_ticks_frames * conversion_factor; %here seconds are converted to minutes by 1/60
    
     %or manual?
    if opts.x_manual_range.on
        warning('manual range')
        x1 = opts.x_manual_range.x1;
        x2 = opts.x_manual_range.x2;
        step_x = opts.x_manual_range.x_step;
    else
        x1 = floor(min(x_ticks_um));
        x2 = ceil(max(x_ticks_um));    
        step_x = 100;
    end
    
    x_ticks_mins_rounded = x1 : step_x : x2;
    x_ticks_frames_rounded = x_ticks_mins_rounded / conversion_factor;    
    
    set(gca, 'XTick', x_ticks_frames_rounded);
    set(gca, 'XTickLAbel', x_ticks_mins_rounded);
end

end







function path_i = make_path(path_root, choose_case)

% full list of analyzed data
paths_set = {...
    [path_root, '2014-08-26\pos1\'],...
    [path_root, '2014-08-26\pos3\remeasured\'],...
    [path_root, '2014-08-26\pos4\cell1_remeasured\'],...
    [path_root, '2014-08-26\pos4\cell2_remeasured\'],...
    [path_root, '2014-08-26\pos6\cell1\'],...
    [path_root, '2014-08-26\pos7\cell1\'],...
    [path_root, '2014-08-26\pos7\cell2\'],...
    [path_root, '2014-08-26\pos10\profiles\'],...
    [path_root, '2014-08-26\pos11\profiles\'],...    
    [path_root, '2015-03-10\pos1\profiles\'],...
    [path_root, '2015-03-10\pos3\profiles\'],...
    [path_root, 'division\2015-03-11\pos1\profiles\'],...
    [path_root, 'division\2015-03-11\pos2crop\txt_profiles\'],...
    [path_root, 'division\2015-03-11\pos3\profiles\'],...
    [path_root, 'division\2015-03-11\pos4crop\txt_profiles\'],...
    [path_root, 'division\2015-03-11\pos6\profiles\'],...
    [path_root, 'division\2015-03-11\pos7crop\txt_profiles\'],...
    [path_root, 'division_2\2_day_2dnight\pos2\profiles\'],...
    [path_root, 'division_2\2_day_2dnight\pos2\profiles2\'],...
    [path_root, 'division_2\2_day_2dnight\pos2\profiles3\'],...
    [path_root, 'division_2\2_day_2dnight\pos4\profiles\'],...
    };

path_i                  = paths_set{choose_case};




frames_of_invag         = [];
y_coord_of_invag        = [];

switch choose_case
    
    case 1        
        path_i = [path_root, 'division\2015-03-11\pos2crop\txt_profiles\'];
      
        %this part is for invaginations:
        aa = 1:34; %this is frames
        bb = 516:7:747; %this is phase contr numbering
        cc = [564 598 637 665 694 713 729]; %this are numbers of phase contr images where invaginations appear.
        frame_from_PC = polyfit(bb,aa,1);
        frames_of_invag = polyval(frame_from_PC, cc);        
        %these numbers are taken from the according kymo:
        y_coord_of_invag = [288 128 148 293 158 57 334];        
        
    case 2
        path_i = [path_root, 'division\2015-03-11\pos4crop\txt_profiles\'];
     
    case 3
        path_i = [path_root, 'division\2015-03-11\pos7crop\txt_profiles\'];
                      
        aa = 1:40; %this is frames
        bb = 504:7:777; %this is phase contr numbering
        cc = [533 596 664 682 692]; %this are numbers of phase contr images where invaginations appear.
        frame_from_PC = polyfit(bb,aa,1);
        frames_of_invag = polyval(frame_from_PC, cc);
        y_coord_of_invag = [134 327 329 318 102];
end



end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% End of main function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function [B, temp_L] = make_frame_list_and_form_B(path_i, opts)

% - find txt files (intensity profiles) in the indicated folder
% - sorts the names in proer order
% - loads profiles
% - smoothes them (optional)
% - organizes the profiles in a cell B {}; first row - frames; rest cells -
%   intensity profile of the same cell (double vector)
%   [           4]    [          10]    [          16]    [          22] 
%   [118x1 double]    [119x1 double]    [125x1 double]    [131x1 double] 
%               []     [31x1 double]    [ 32x1 double]    [ 34x1 double]
%               []                []                []    [ 31x1 double]
                

% each profile is stored as txt file (from imageJ); name is composed of
% a frame index and a cell index: frameN_cellN.txt; 
% With time the cell number increases: _0, _1, _2 since cells divide and their
% numbers increase. 
% The profiles were measured in the conserved direction, so that all cells can
% be stacked one upon another to form a single profile;
% For instance, the last column in B {} means: frame 22 contains three
% cells; the intensity profiels of which were measured in conserved direction;
% then the files were named according this direction: 22_0.txt, 22_1.txt,
% 22_2.txt.
%   [          22] 
%   [131x1 double] 
%   [ 34x1 double]
%   [ 31x1 double]



a           = dir(path_i);
a(1:2)      = [];          % delete . and .. error-prone?

% if choose_case==21%this is debugging.s
%    disp('debug here')
% end

frame_list  = [];
name_list   = {};

for i = 1:size(a,1)
    
    n = a(i).name;
    name_list = [name_list; {n}];
    
    n(findstr(n,'.'):end)=[];
    if ~isempty(findstr(n,'_'))
        n(findstr(n,'_'):end)=[];
    end
    frame_list = [frame_list; str2num(n)];     
end

% unique frame list:
frame_list2 = unique(frame_list);

% However, for some cells I made some crappy profiles in the beginning, so start from a specific frame there.
% check if the indicated path contains these folder names;  if so, select
% the proper frames.
if strcmp(path_i, '2015-03-10\pos3\profiles\')
    frame_list2 = frame_list2(14:end);
elseif strcmp(path_i, '2015-03-10\pos1\profiles\')
    frame_list2 = frame_list2(11:end);
end


% The name list is not ordered well (frame-wise).
% I could find this way of reordering:
% - translate the names of the txt files into numeric equivalent 
% - order numeric equivalents in ascending order (frame increase)
% - take this order and apply for the scrambled (initial) list.

names_as_nums = [];
for jj = 1: length(name_list)
    
    name_i = name_list{jj};
    name_i(strfind(name_i, '.txt') : end) = [];
    
    if ~isempty(strfind(name_i, '_'))    % if it has underscore, reformat the numbers after underscore:

        name_i_left = name_i(1: strfind(name_i, '_')-1);
        name_i_right = name_i(strfind(name_i, '_') + 1 : end);
        % add one more 0, otherwise 98_1 and 98_2  are mixed with 98_11.
        % if one has 98_01, 98_02, ans 98_11 the no problem
        if length(name_i_right) == 1
            name_i_right = ['0' name_i_right];
        end
    else % if not, stays like it was:
        name_i_left = name_i;
        name_i_right = '';
    end    
    
    name_i = [name_i_left '.' name_i_right];    
    name_i = str2num(name_i);
    
    names_as_nums = [names_as_nums; name_i];    
end

% sort by the numeric equivalents
[~, ind]        = sort(names_as_nums);

% sorted correspondance cell: [frame - fileName - number]:
frame_list      = frame_list(ind);
name_list       = name_list(ind);
names_as_nums   = names_as_nums(ind);

frame_name_corr = [num2cell(frame_list), name_list, [num2cell(names_as_nums)]];




% Now shape the profile holder. It is a cell; in each cell there will be a profile.
% dim 2 = frames
% dim 1 = cells

B       = cell(1, length(frame_list2));
B(1,:)  = num2cell(frame_list2)';
B_raw   = B;      % there will be also holder for raw profiles;

% Read all txt profiles and assemble data holder cell B:
for i = 1 : size(B, 2)
    
    n           = B{1, i};  % take a frame number
    counter     = 2;        % the first line in B was frame number; start conting from 2 then.    
    
    [ind_n, ~]  = find(frame_list == n);        % take all cells in this frame
    
    temp_L      = 0;
    for j = ind_n'
        
        [z_processed, z_raw]    = load_profiles_from_txt(opts, path_i, name_list, j);
        B{counter, i}           = z_processed;                  % append to processed profiles holder        
        B_raw{counter, i}       = z_raw;                        % append to raw profiles holder 
        
        counter                 = counter + 1; 
        temp_L                  = temp_L + length(z_processed);
    end   
end

end







function  [z_processed, z_raw] = load_profiles_from_txt(opts, path_i, name_list, j)


        txt_to_load = [path_i name_list{j}];
        file_i = fopen(txt_to_load,'r');
        %float nums:
        formatSpec = '%f';
        z_raw = fscanf(file_i, formatSpec);
        fclose(file_i);

        
        
        %it reads first and 2nd column, so lets take each 2nd value:
        z_raw = z_raw (2:2:end);
        z_processed = z_raw;
        
        if 1        %smooth?
            z_processed = smooth(z_processed, opts.smoothing);  
        end
        
        if 1       %rescale?

            z_processed = smooth(z_processed, opts.smoothing);                
                % first bing max down, otherwise individual frames will be different in mean int.
                z_processed = z_processed - min(z_processed);
                z_processed = z_processed/max(z_processed);                
                z_processed = 0.5*z_processed/mean(z_processed);
        end
        
        % contrast against dark background?
        if opts.contrast_int_against_black_background
            warning('shifting the intensities a bit up to contrast it with the background!')
            z_processed = z_processed + 1;
        end
        
end














function [kymograph_with_division_marks, kymograph_clean] = make_kymo_from_B(B, temp_L, opts)


kymograph_with_division_marks = ones(temp_L, size(B,2))*-0.0003; % -0.3 is easily found value to replace background by white later.. 

%kymograph_with_division_marks = zeros(temp_L, size(B,2));
kymograph_clean = zeros(temp_L, size(B,2));

shift_matrix = [];


for i = 1:size(B,2)
    
    kym_div_makrs_i = [];
    kym_clean_i = [];
    
    for j = 2:size(B,1)
        
       col_j = B{j,i};
       col_j_marks = col_j;
       %mark a separation between the parent and daughter:
       if length(col_j)>0 %& j>2      
           
            % mark both ends of bacteria (-MW comment)
            col_j_marks(end) = -0.0001; % random number that is easy to find
            col_j_marks(1)   = -0.0001; 
            
       end
              
       kym_div_makrs_i = [kym_div_makrs_i; col_j_marks]; 
       kym_clean_i = [kym_clean_i; col_j];
       
    end
    
    shift_value = floor(temp_L/2 -  length(kym_div_makrs_i)/2);
    if shift_value<0 % it can be negative if a cell shrinks. LEts make it 0.
        shift_value = 0;
    end
    shift_matrix = [shift_matrix, shift_value];
    
    
    if opts.centered_kymograph        
        kymograph_with_division_marks(1 + shift_value : shift_value + length(kym_div_makrs_i), i) = kym_div_makrs_i;  
        kymograph_clean(1 + shift_value : shift_value + length(kym_clean_i), i) = kym_clean_i;  
 
    else
        kymograph_with_division_marks(1:length(kym_div_makrs_i),i) = kym_div_makrs_i;
        kymograph_clean(1:length(kym_clean_i),i) = kym_clean_i;

    end

end
end



function longest_cell_kymo = make_longest_cell_kymo(B, opts)

length_mat = [];

for i = 1:size(B,2)
    lengths_list_i = 0;
    cc = B(2:end,i);
    for k = 1:length(cc)
        dd = cc{k};
        lengths_list_i = [lengths_list_i; length(dd)];
    end  
    length_mat = [ length_mat, lengths_list_i];
end

vert_size = max(max(length_mat));
longest_cell_kymo = zeros(vert_size, size(B,2));
%shift_matrix = [];

for i = 1:size(longest_cell_kymo, 2)
    [a, ind] = max(length_mat(:,i)); %position of the longest cell
    int_profile = B{ind, i};
    %longest_kymo(1:length(int_profile), i) =  int_profile;
    
    
    shift_value = floor(vert_size/2 -  length(int_profile)/2);
    if shift_value<0 % it can be negative if a cell shrinks. LEts make it 0.
        shift_value = 0;
    end
    %shift_matrix = [shift_matrix, shift_value];
    
    if opts.contrast_int_against_black_background
        warning('shifting the intensities a bit up to contrast it with the background!')
        int_profile = int_profile + 0.5;
    end
    
    if opts.centered_kymograph
        %invert profile, because it is turned
        longest_cell_kymo(1 + shift_value : shift_value + length(int_profile), i) = int_profile;    
    else
        longest_cell_kymo(1:length(int_profile),i) = int_profile;
    end    
end
end




function figureHandles= plot_ftsA_profiles_in_time(B, choose_case,figureHandles)

% plot ftsA profile in times; lengths normalized to [0 1]
% works best for choose_case  =21 (exp growth)
A = [];

figureHandles(end+1)=figure;
hold on
%remove the time lines:

B(1,:) = [];
for i = 1:numel(B)
    
    x = 1:numel(B{i}); 
    y = B{i};
    x_norm = x/max(x);
    
    if ~isempty(x)        
        plot(x_norm, y, 'o','color', 0.8*[1 1 1])
        for j = 1:numel(y)
            A = [A; [x_norm(j), B{i}(j)]]; 
        end
    end
end

x = A(:,1);
y = A(:,2);

%binA and avg:
x_bins = 0: 0.02 :1;
y_avg = [];
y_std  =[];

for i = 1 : length(x_bins)-1
    bin_left = x_bins(i);
    bin_right = x_bins(i+1);
    %disp([num2str(bin_left) '-' num2str(bin_right)])
    y_avg_i = mean(y(x >= bin_left & x < bin_right));
    y_std_i = std(y(x >= bin_left & x < bin_right));
    y_avg = [y_avg, y_avg_i];
    y_std = [y_std, y_std_i];
end

% plot((x_bins(1:end-1) + x_bins(2:end))/2,...
%     y_avg, 'k')
errorbar((x_bins(1:end-1) + x_bins(2:end))/2, y_avg, y_std,...
    'k', 'LineWidth', 2)


end





function plot_B_indeces(kymograph, B, kymograph_clean)

%go through each time column:
for i = 1:size(B,2)
    
    B_i = B(:,i);
    for j = 2:size(B_i,1)
        %intensities for this profile:
        B_ij = B_i{j};
        
        [~, ind] = ismember(B_ij, kymograph_clean(:,i));
        
        coord_y = mean(ind);
        coord_x = i;
        
        text(coord_x,coord_y, [num2str(j) '-' num2str(i)])
    end    
    
end
end



