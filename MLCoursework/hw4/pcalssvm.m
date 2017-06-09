%
% PCA: Dimensionality reduction technique and its use in classification
%

% Load data set
D = xlsread('ozon.xlsx');
X = D(:,1:end-1);
Y = D(:,end);

r = randperm(size(X,1));

ntr = ceil(0.75*size(X,1));
ntest = size(X,1)-ntr;
% Make the training and test set
Xtr = X(r(1:ntr),:);
Xtest = X(r(ntr+1:end),:);
Ytr = Y(r(1:ntr));
Ytest = Y(r(ntr+1:end));

% Perform PCA
[coefs,score,latent,~,explained,mu] = pca([Xtr;Xtest],'centered',true);

% Make cumulative sum plot of variation explained
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create plot
plot(1:size(Xtr,2),cumsum(explained),'Marker','*')

box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XTick',linspace(1,size(Xtr,2),size(Xtr,2)));
xlabel('Number of Components')
ylabel('Cumulative Percentage variation explained')

%
% Choose No. of PC
%
nPC = 5;

% This is centered data
Xnewtr = score(1:ntr,1:nPC);

% Add LSSVM software to your path
% Train model
model = initlssvm(Xnewtr, Ytr, 'c', [],[],'RBF_kernel');
model = tunelssvm(model,'simplex','crossvalidatelssvm',{10,'misclass'});
model = trainlssvm(model);

% Make Test set
Xnewtest = score(ntr+1:end,1:nPC);

% Calculate misclassifcation rate
Yhat = simlssvm(model,Xnewtest);

% Percentage CORRECTLY classified
1-sum(Yhat ~= Ytest)/size(Xnewtest,1)



%
% Full data
%
model = initlssvm(Xtr, Ytr, 'c', [],[],'RBF_kernel');
model = tunelssvm(model,'simplex','crossvalidatelssvm',{10,'misclass'});
model = trainlssvm(model);

% Calculate misclassifcation rate
Yhat = simlssvm(model,Xtest);

% Percentage CORRECTLY classified
1-sum(Yhat ~= Ytest)/size(Xtest,1)


