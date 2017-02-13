

%% Print experimental profiles by Dmitry and print profiles from simulations

% Load the profiles
M_plot_rescaled_profiles_MinD

% Print the profiles

% Note that the corresponding profile can be calculated from the fit. So
simulationIndex = round(A(1).length_range.*linearFitValues(2)+linearFitValues(1)-leftPadSize);

currentProfile      = theMeanProfilesF{simulationIndex};
currentProfileStd   = theStdProfilesF{simulationIndex};

figure; clf;
plot(currentProfile);


% A(1):     6.027 um
% A(3):     19.296 um
% A(5):     26.814 um