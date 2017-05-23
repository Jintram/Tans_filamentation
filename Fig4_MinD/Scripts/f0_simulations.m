function [F_profiles_all, D_profiles_all] = f0_simulations(options)
 
% Dmitry Ershov 2016
% adopted from Hans Meinhardt, 2001,
% "Pattern formation in Escherichia coli: A model for the pole-to-pole
% oscillations of Min proteins and the localization of the division site"

% NOTES.
% 1.    Total number of iterations will be N_iter_per_frame*N_frames.
% 2.    More iterations within one frame (N_iter_per_frame) -> faster equilibrium is
%       reached in this frame is reached.
% 3.    Normally, FtsZ patterns get stable after N_frames*N_iter_per_frame = 500*1000.
%       It is thus recommended to set N_frames > 500.
%       One can test and see the effect of N_frames = 500 and N_frames = 1000;
% 4.    Surprizingly, FtsZ patterns are quite different: can be very
%       stable in time (parallel lines in kymo) and dynamic (changing
%       positions). Turing knows better.
% 5.    Perhaps one can tune DD (diffusion of minD; below) or other parameters 
%       to get a most stable FtsZ pattern.
% 6.    Instability in FtsZ patterns seem to be random (see 'kymo/noisy' examples).
%       This might be due to a random component in calculations (see below).
%       There are several ways of making the patterns more beautiful (cleaner)
%       (see (see 'kymo/clean' examples) - they actually were used in Fig.):
%       1 (not very simple, but rigorous?): 
%        - create some scoring function that checks if calculation result has
%          peaks of FtsZ that are have a good contrast against the
%          background; it so - collec tthis good profile.
%       2 (simple):
%        - run N simulations with THE SAME parameters;
%        - this gives N kymos (mean(FtsZ) vs Length - equivalent of our S-pattern).
%        - these N kymos have some parts that are fuzzy (due to randomness?)
%        - since these parts are random, one can simply recombine good
%        parts and create a more beautiful pattern.
%       3 (simple):
%        - "more honest" way is to generate many kymos (say, during one night)
%       and simply pick the cleanest one.
% 7.    The kymo contrast can be tuned in two lines (at the bottom of the script;
%       Find the lines marked with '% TUNE CONTRAST HERE'



% close all;  
write_video         = 0;                % save video file

% show frames 
if ~isfield(options,'showResultFigure')
    options.showFrames          = 0;                
end

if ~exist('options','var')
    options = {};
end

if ~isfield(options,'showResultFigure')
    options.showResultFigure = 1;
end

%% SIMULATION PARAMETERS

% lengths regimes of cells; each length entry = one cell.
% One can choose the length span of interest from provided kymos.
% lengthSet           = 70 : 1 : 80;      % close to the length regime with 4 division sites
if isfield(options,'lengthSet')
    lengthSet=options.lengthSet;
else
    lengthSet         = 15 : 1 : 100;     % all lengths regimes (from 1 division site to 5 division sites)
end

fluctAmplitude      = 0.005;            % Noise amplitude in autocatalytic parameters.
                                        % If set to 0 patternd doesnt form; noise is crucial for 
                                        % the reaction.
                                        % 0.005 is the original value. 
                                        % I didn find any effect of this
                                        % parameter on the noisiness of the
                                        % kymo.
% iteration number
N_frames            = 1000;             % Number of displays (number of frames in the video)
N_iter_per_frame    = 1000;             % Number of iterations between the displays.
                                        % Increasing N_iter_per_frame doesnt result in less noisy kymos (tested up to 5000).
                                        % Total iterations for one cell is thus (N_frames*N_iter_per_frame)
                                        
                                        
                                        
%% OUTPUT                                        
F_profiles_all      = {};               % Collection of the mean profiles (raw FtsZ kymo)
D_profiles_all      = {};               % Collection of the mean profiles (raw MinD kymo)




%% Reaction/Diffusion PARAMETERS:
% All thge parameters can be found either in the original article Meinhardt 2001
% parameters can also be taken from Elowitz old article

% First letters: D = diffusion, mu = removal, kappa = couplings 
% Constants used:

% 'MinD, bound 
DD          = 0.02;     % DD = 0.02; DD = 0.013;
muD         = 0.002;
sigmaD      = 0.05;
muDE        = 0.0004;

% 'MinD, diffusible 
DDdif       = 0.2; 
muDdif      = 0; 
sigmaDdif   = .004;

%'MinE, bound 
DE          = 0.0004;
muE         = 0.0005;
sigmaE      = 0.1;
kappaDE     = 0.5; 

%'MinE, diffusible 
DEdif       = 0.2; 
muEdif      = 0.0002; 
sigmaEdif   = 0.002; 

%'FtsZ, non-diffusible 
DF          = 0.002;
muF         = 0.004;
sigmaF      = 0.1;
muFD        = 0.002; 

 %'FtsZ, diffusible 
DFdif       = 0.2;
muFdif      = 0.002;
sigmaFdif   = 0.006;

kappaE      = 0.02;


% The values are taken according to ???
% original values:
% % For Eqs. 1 and 2: 
% mu_F = 0.004;
% rho_F = 0.004;
% k_F = 0;
% %k_F = 0.2 % in Fig5
% 
% sigma_F = 0.1;
% mu_DF = 0.002;
% D_F = 0.002;
% 
% sigma_f = 0.006;
% mu_f = 0.002;
% D_f = 0.2;
% 
% % For Eqs. 3 and 4: D D  0.002; D
% rho_D = 0.002;
% mu_D = 0.002;
% 
% sigma_D = 0.05;
% mu_DE = 0.0004;
% D_D = 0.02;
% 
% sigma_d = 0.0035;
% mu_d = 0;
% D_d = 0.2;
% 
% % For Eqs. 5 and 6: 
% rho_E = 0.0005;
% mu_E = 0.0005;
% sigma_E = 0.1;
% 
% k_DE = 0.5;
% k_E = 0.02;
% D_E = 0.0004;
% 
% sigma_e = 0.002;
% mu_e = 0.0002;
% D_e = 0.2;


% figure
if options.showFrames 
    if ~isfield(options,'video_MW') % default
        fig_kymos   = figure('position', [ 293         224        1200         600]); 
        subplot(1,3,1); title('profiles'); hold on
        subplot(1,3,2); title('minD'); hold on
        subplot(1,3,3); title('ftsZ'); hold on
    else % special Martijn W. settings
        fig_kymos   = figure('position', [ 100         100        600         1200]); 
    end
end
if write_video
    writeObj = VideoWriter([options.outputDir 'simulationResult.avi']);
    writeObj.FrameRate = 5;
    open(writeObj);
end



cellCounter     = 0;        % cell counter

for currentLength = lengthSet(:)'             % currentLength = lengthSet(i); length is the number of spatial elements
    
    cellCounter = cellCounter +1;

    F_all = [];
    D_all = [];    
    
    % membrane bound F, D, E 
    F = zeros(1,currentLength);
    D = zeros(1,currentLength);
    E = zeros(1,currentLength);
    
    % Diffusible f, d, e 
    Fdif = zeros(1,currentLength);
    Ddif = zeros(1,currentLength);
    Edif = zeros(1,currentLength);
    
    % for production rates with fluctuations
    rhoF = zeros(1, currentLength);
    rhoD = zeros(1, currentLength);
    rhoE = zeros(1, currentLength);
    
    % initialize (populate) each length segment
    for i = 1 : currentLength      
        
        F(i) = 1;
        D(i) = 1;
        E(i) = 1;  %'all zero 
        
        Fdif(i) = 1;
        Ddif(i) = 1;
        Edif(i) = 1;
        
        % Original comment: Fluctuation of the autocatalysis 
        % random factor has a uniform distribution of a given amplitude (fluctAmplitude) around 1:
        % 1 +- fluctAmplitude (e.g: 1.000 +- 0.003).
        % One can check an example of such distribution: 
        % figure; fluctAmplitude = 0.003; hist(((1 - fluctAmplitude) + 2*fluctAmplitude * rand(1000, 1)));
        
        if fluctAmplitude > 0
            rhoF(i) = muF * ((1 - fluctAmplitude) + 2 * fluctAmplitude * rand);  
            rhoD(i) = muD * ((1 - fluctAmplitude) + 2 * fluctAmplitude * rand);  
            rhoE(i) = muE * ((1 - fluctAmplitude) + 2 * fluctAmplitude * rand);  
        else  % no fluctuations?          
            rhoF(i) = muF;
            rhoD(i) = muD;
            rhoE(i) = muE;
        end
    end
    
    
    
    % iterate over each frame to be displayed or recorded    
    iterTotCounter     = 0;            % reset iterator
    
    for frameIterator  = 0 : N_frames
        
        % each frame is a result of several iteration, during which the
        % concentrations are calculated.
        
        for localIterator = 1 : N_iter_per_frame
            
            iterTotCounter = iterTotCounter + 1;        % total iteratoins
            
            % Original comments: 
            % Boundary impermeable:
            % virtual left (Fleft etc.) 
            % virtual right [F(currentLength + 1) etc.]
            % cell with the same concentration--no diffusion 
            
            Fleft = F(1);
            Dleft = D(1);
            Eleft = E(1);
            
            Fdifleft = Fdif(1);
            Ddifleft = Ddif(1);
            Edifleft = Edif(1);
            
            F(currentLength + 1) = F(currentLength);
            D(currentLength + 1) = D(currentLength);
            E(currentLength + 1) = E(currentLength);
            
            Fdif(currentLength + 1) = Fdif(currentLength);
            Ddif(currentLength + 1) = Ddif(currentLength);
            Edif(currentLength + 1) = Edif(currentLength);
            
            % each calculation iteration goes over all length segments and
            % redistribute the proteins.
            for i = 1 : currentLength 
                
                Flocal      = F(i);
                Dlocal      = D(i);
                Elocal      = E(i);
                
                Fdiflocal   = Fdif(i);
                Ddiflocal   = Ddif(i);
                Ediflocal   = Edif(i); 
                
                %' ' 1. Calculating FtsZ (=F) and diffus. FtsZ (=Fdif) 
                prodF       = rhoF(i) * Fdiflocal * (Flocal * Flocal + sigmaF);
                F(i)        = prodF + Flocal * (1 - muF - muFD * Dlocal) + DF * (Fleft + F(i + 1) - 2 * Flocal);
                Fdif(i)     = Fdiflocal * (1 - muFdif) + sigmaFdif - prodF + DFdif * (Fdifleft + Fdif(i + 1) - 2 * Fdiflocal);
                Fleft       = Flocal;
                Fdifleft    = Fdiflocal;
                %'present concentration 
                % LOCATE 1, 1: PRINT F(i); Fdif(i) 'left-cell concentraton when calculating next cell 
                
                %' 2. Calculating MinD (=D) and diffus. MinD (=Ddif) 
                prodD       = rhoD(i) * Ddiflocal * (Dlocal * Dlocal + sigmaD);
                D(i)        = prodD + Dlocal * (1 - muD - muDE * Elocal) + DD * (Dleft + D(i + 1) - 2 * Dlocal);
                Ddif(i)     = Ddiflocal * (1 - muDdif) + sigmaDdif - prodD + DDdif * (Ddifleft + Ddif(i + 1) - 2 * Ddiflocal);
                Dleft       = Dlocal;
                Ddifleft    = Ddiflocal;
                %' present concentration-left-cell concentration 
                
                
                %' 3. Calculating MinE (=E) and diffus. MinE (=Edif) 
                prodE       = rhoE(i) * Ediflocal * Dlocal / (1 + kappaDE * Dlocal * Dlocal) * (Elocal * Elocal + sigmaE) / (1 + kappaE * Elocal * Elocal);
                E(i)        = prodE + E(i) * (1 - muE) + DE * (Eleft + E(i + 1) - 2 * Elocal);
                Edif(i)     = Ediflocal * (1 - muEdif) + sigmaEdif - prodE + DEdif * (Edifleft + Edif(i + 1) - 2 * Ediflocal);
                Eleft       = Elocal;
                Edifleft    = Ediflocal;
                %' present concentration-left-cell concentration 
            end            
        end       
          
        % collect the resulting concentrations for each frame:
        F_all   = [F_all; F];
        D_all   = [D_all; D];
        
        
        if options.showFrames 
            if ~isfield(options,'video_MW') % default style
            
                % plot the Number profiles for three species:
                figure(fig_kymos);
                subplot(1,3,1); cla;
                plot(1:currentLength+1, F(1:currentLength+1), 'b.-')    % ftsz
                plot(1:currentLength+1, D(1:currentLength+1), 'g.-')    % minD
                plot(1:currentLength+1, E(1:currentLength+1), 'r.-')    % minE            

                xlim([0 currentLength+2])
                ylim([0 15])            % yMax is subject to change
                pause(0.0)              % pause?
                drawnow
                title({['Length: ' num2str(currentLength)],...
                        ['Frame iteration: ' num2str(frameIterator)],...
                        ['Total iteration: ' num2str(iterTotCounter)]})  

                % one can imagesc(F_all) - to see kymograph of F for all frames.
                subplot(1,3,2); cla; imagesc(D_all);
                subplot(1,3,3); cla; imagesc(F_all);            

                if write_video
                    frame = getframe(gcf);
                    writeVideo(writeObj, frame);
                end
                
            else % Do it Martijn W. style                                
                
                MinDColor = [65 148 68]/255; MinEColor = [.7 .7 .7];
                speciesColors = [MinDColor; MinEColor]; % [0.3467    0.5360    0.6907; 0.9153    0.2816    0.2878];
                greenColorMap = makeColorMap([1 1 1],[65 148 68]./255);%,[105 189 69]./255)
                
                % plot the Number profiles for three species:
                figure(fig_kymos);
                subplot(2,1,1); cla; hold on; 
                %plot(1:currentLength+1, F(1:currentLength+1), 'b.-')    % ftsz
                sumD = sum(D); sumE = sum(E); 
                plot(1:currentLength+1, D(1:currentLength+1)./sumD, '.-','LineWidth',3,'Color',speciesColors(1,:))    % minD
                plot(1:currentLength+1, E(1:currentLength+1)./sumE, '.-','LineWidth',3,'Color',speciesColors(2,:))    % minE            
                
                plot(1:currentLength+1,mean(D_all)./sumD,'.-','LineWidth',3,'Color','k')
                
                set(gca,'XTick',[]);
                set(gca,'YTick',[]);
                xlabel('Cell Axis (a.u.)','FontSize',20);
                ylabel('Concentration Protein (a.u.)','FontSize',20);
               
                
                legH=legend('MinD','MinE','Mean MinD'); set(legH,'FontSize',20);
                
                xlim([0 currentLength+2])
                ylim([0,1/(currentLength)*3]); % ylim([0 15])            % yMax is subject to change
                pause(0.0)              % pause?
                drawnow
                %title({['Length: ' num2str(currentLength)],...
                %        ['Frame iteration: ' num2str(frameIterator)],...
                %        ['Total iteration: ' num2str(iterTotCounter)]})  

                % one can imagesc(F_all) - to see kymograph of F for all frames.
                subplot(2,1,2); cla; MW_makeplotlookbetter(20);
                imagesc(D_all); colormap(greenColorMap);
                set(gca,'XTick',[]); set(gca,'YTick',[]);
                xlabel('Cell Axis (a.u)','FontSize',20);
                ylabel('Time (a.u.)','FontSize',20);
                %subplot(1,3,3); cla; imagesc(F_all);            

                if write_video
                    frame = getframe(gcf);
                    writeVideo(writeObj, frame);
                end
                
                
                
            end
        end
    end
    % all iterations are over for the cell of current length.
    
% find the mean of concentrations in time. Time we had as the first
% dimension:
mean_F      = mean(F_all, 1);
mean_D      = mean(D_all, 1);

% the length of cells changes ('currentLength' changes), so we have to use matlab Cell.
F_profiles_all = [F_profiles_all; {mean_F}];
D_profiles_all = [D_profiles_all; {mean_D}];

disp(['Length: ' num2str(currentLength) ' (Maximum length ' num2str(max(lengthSet)) ' elements; ' num2str(cellCounter) ' out of ' num2str(numel(lengthSet)) ')'])
end


if write_video
    close(writeObj);
end






%% PLOTTING of our PATTERN plot.
C = F_profiles_all;

% max lenght is actually known, but lets find it anyway
max_length = 0;
for i = 1 : length(C)
    if max_length <length(C{i}); max_length = length(C{i}); end
end

% create blank images, columns == cells of different lengths
image_all_0 = zeros(max_length, length(C));     % cells are aligned at the upper end of the image
image_all_1 = zeros(max_length, length(C));     % cells are centered

% populate the blank images
for i = 1 : length(C)
   y = C{i};
   y = y*100; % TUNE CONTRAST HERE   
   image_all_0(1:length(y), i) = y;
   image_all_1(:,i) = imresize(y, [1, max_length]);
end

% % TUNE CONTRAST HERE
image_all_0(image_all_0 ~= 0) = image_all_0(image_all_0 ~= 0) + 200; 


if options.showResultFigure
    figure;
    imagesc(image_all_1);
    colormap gray
    title('aligned by cell center')

    figure;
    imagesc(image_all_0); 
    colormap gray
    title('aligned by cell ends')
end

% one can do try to rescale pix -> um.
% settings should be entered manually...
% 
% if 0
%    imagesc(image_all_1);
%    colormap gray
%    hold on;
% 
% 
%    %find rescaling from pix to um:
%    pix_vals     = [11 40 57];       % node lengths in pixels (lengthSet)
%    um_vals      = [7.7 23 33];      % node lengths in um   
% 
%    % find their relationship
%    pix_from_um  = polyfit(um_vals,  pix_vals,   1);      
%    um_from_pix  = polyfit(pix_vals, um_vals,    1);
% 
%    pix_complete_numbering   = [1:size(image_all_1,2)];           
%    um_complete_numbering    = polyval(um_from_pix, pix_complete_numbering);
% 
%    % check by putting all pixel values and label them with all um values:
%    set(gca,'Xtick', pix_numbering)
%    set(gca,'XTickLabel', round(um_complete_numbering));      
% 
%    % round now um values
%    um_rounded = [floor(min(um_complete_numbering)):2:ceil(max(um_complete_numbering))];
% 
%    %correlate them to pixels via polyfit:
%    pix_from_rounded = polyval(pix_from_um,um_rounded);
% 
%    %now set the found pixel values:
%    set(gca,'XTick',pix_from_rounded);
%    %and label them with um vlaues:
%    set(gca,'XtickLabel', um_rounded)
% 
% 
%    xlabel('Length, \mum')
% 
%    %plot rutgers data (y-rescaled to the size of image)
%    plot(polyval(pix_from_um,overview_all(:,3)),a(:,2)*size(image_all_1,1),...
%       'ro','MarkerFaceColor','r')
% end
   
