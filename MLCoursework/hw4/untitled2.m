%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LS-SVM script for classification %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load the data 
data = xlsread('ozon2.xlsx');
x = data(:,1:72);
y = data(:,73);
length = size(x,1);

y_pred_rbf = [];
y_label_rbf = [];

N_round = 20; %100;
acc_rbf = zeros(N_round,1);
acc_lin = zeros(N_round,1);
acc_poly = zeros(N_round,1);
for index = 1:N_round
    random_order = randperm(length);
    x = x(random_order,:);
    y = y(random_order);
    training_ind = 1:1293;
    testing_ind = 554:length;
    
    % Initialize the rbf kernel model
    model = initlssvm(x(training_ind,:),y(training_ind),'c',[],[],'RBF_kernel','p');
    % Tune the hyperparameters with 10-fold CV and minimize the
    % misclassification rate
    model = tunelssvm(model,'simplex','crossvalidatelssvm',{10,'misclass'});
    % Train the model (i.e. solve the linear system)
    model = trainlssvm(model);
    %get prediction labels
    label = latentlssvm(model, x(testing_ind,:));
    %append to pred and label arrays for use in ROC curve
    if index==1
        y_pred_rbf = label;
        y_label_rbf = y(testing_ind);
    else
        y_pred_rbf = vertcat(y_pred_rbf,label);
        y_label_rbf = vertcat(y_label_rbf, y(testing_ind));
    end
     
end


% plot ROC Curve rbf
[area,se,thresholds,oneMinusSpec,Sens]=roc(y_pred_rbf,y_label_rbf);