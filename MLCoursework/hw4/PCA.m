%% Principal Components of a Data Set  

%% 
% Load the sample data set. 
load hald 

%%
% The ingredients data has 13 observations for 4 variables.  

%% 
% Find the principal components for the ingredients data. Do PCA on the correlation matrix 
 [coeff,score,latent,~,explained,mu]  = pca(zscore(ingredients),'centered',true); 

%%
% The rows of |coeff| contain the coefficients for the four ingredient variables,
% and its columns correspond to four principal components.   

% Get original centered data back
Xcentered = score*coeff';


% Make a scree plot

% Create axes and figure
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create plot
plot(1:size(ingredients,2),explained','Marker','*')

box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XTick',linspace(1,size(ingredients,2),size(ingredients,2)));
xlabel('Number of Components')
ylabel('Percentage variation explained')

% Make cumulative sum plot of variation explained
figure2 = figure;
axes2 = axes('Parent',figure2);
hold(axes2,'on');

% Create plot
plot(1:size(ingredients,2),cumsum(explained),'Marker','*')

box(axes2,'on');
% Set the remaining axes properties
set(axes2,'XTick',linspace(1,size(ingredients,2),size(ingredients,2)));
xlabel('Number of Components')
ylabel('Cumulative Percentage variation explained')

%
% Visualize the PCA result: Biplot 
%
vbl = {'tricalcium aluminate','tricalcium silicate', 'tetracalcium aluminoferrite', 'beta-dicalcium silicate'};
biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',vbl);


%%%%%%%%%%%%%%%%%%%%%%
% Different data set %
%%%%%%%%%%%%%%%%%%%%%%
load carsmall
%%
% Define the variable matrix and delete the rows with missing values.
x = [Acceleration Displacement Horsepower MPG Weight];
x = x(all(~isnan(x),2),:);
%%
% Perform a principal component analysis of the data.
[coefs,score,latent,~,explained] = pca(zscore(x),'centered',true);
%%
% View the data and the original variables in the space of the first three
% principal components.
vbls = {'Accel','Disp','HP','MPG','Wgt'};
biplot(coefs(:,1:3),'scores',score(:,1:3),'varlabels',vbls);
% Create axes and figure
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create plot
plot(1:size(x,2),explained','Marker','*')

box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XTick',linspace(1,size(ingredients,2),size(ingredients,2)));
xlabel('Number of Components')
ylabel('Percentage variation explained')


%%%%%%%%%%%%%%%%%%%%%%%
% Food Price data set %
%%%%%%%%%%%%%%%%%%%%%%%
load prices
[coeff,score,latent,~,explained,mu]  = pca(zscore(prices{:,2:end}),'centered',true);
% Make a scree plot

% Create axes and figure
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create plot
plot(1:size(prices{:,2:end},2),explained','Marker','*')

box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XTick',linspace(1,size(prices{:,2:end},2),size(prices{:,2:end},2)));
xlabel('Number of Components')
ylabel('Percentage variation explained')

% Make cumulative sum plot of variation explained
figure2 = figure;
axes2 = axes('Parent',figure2);
hold(axes2,'on');

% Create plot
plot(1:size(prices{:,2:end},2),cumsum(explained),'Marker','*')

box(axes2,'on');
% Set the remaining axes properties
set(axes2,'XTick',linspace(1,size(prices{:,2:end},2),size(prices{:,2:end},2)));
xlabel('Number of Components')
ylabel('Cumulative Percentage variation explained')

%%%
% Biplot
%%%
biplot(coeff(:,1:2),'scores',score(:,1:2),'VarLabels',{'Bread','Burger','Milk','Oranges','Tomatoes'},'ObsLabels',prices{:,1});

%
% Loadings: simple correlations between the original and new variables.
% These give an indication of the extent to which the original variables
% areinfluential or important in forming new variables
%
L = corr(prices{:,2:end},score);
% Number of components retained
nPCA = 2;
L(:,1:nPCA)
