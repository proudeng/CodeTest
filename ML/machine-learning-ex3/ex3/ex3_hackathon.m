%% Machine Learning Online Class - Exercise 3 | Part 1: One-vs-all

%  Instructions
%  ------------
%
%  This file contains code that helps you get started on the
%  linear exercise. You will need to complete the following functions
%  in this exericse:
%
%     lrCostFunction.m (logistic regression cost function)
%     oneVsAll.m
%     predictOneVsAll.m
%     predict.m
%
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%

%% Initialization
clear ; close all; clc

%% Setup the parameters you will use for this part of the exercise
%input_layer_size  = 400;  % 20x20 Input Images of Digits
num_labels = 22;          % 10 labels, from 1 to 10
                          % (note that we have mapped "0" to label 10)

%% =========== Part 1: Loading and Visualizing Data =============
%  We start the exercise by first loading and visualizing the dataset.
%  You will be working with a dataset that contains handwritten digits.
%

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

%load('ex3data1.mat'); % training data stored in arrays X, y
data_orin = load('delay_array.txt'); 
%m = size(X, 1);

data = data_orin(1:1000,:);
%m = length(data);
for t=1:length(data)
    data(t) = data(t) + 1;
    if data(t) > 21
       data(t) = 22;
    end
end

y = data(11:end, 1);
x1 = data(1:end-10, 1);
x2 = data(2:end-9, 1);
x3 = data(3:end-8, 1);
x4 = data(4:end-7, 1);
x5 = data(5:end-6, 1);
x6 = data(6:end-5, 1);
x7 = data(7:end-4, 1);
x8 = data(8:end-3, 1);
x9 = data(9:end-2, 1);
x10 = data(10:end-1, 1);
X = [x1 x2 x3 x4 x5];

%m = length(y);

    

% Randomly select 100 data points to display
%rand_indices = randperm(m);
%sel = X(rand_indices(1:100), :);

%displayData(sel);

%fprintf('Program paused. Press enter to continue.\n');
%pause;

%% ============ Part 2a: Vectorize Logistic Regression ============
%  In this part of the exercise, you will reuse your logistic regression
%  code from the last exercise. You task here is to make sure that your
%  regularized logistic regression implementation is vectorized. After
%  that, you will implement one-vs-all classification for the handwritten
%  digit dataset.
%

% Test case for lrCostFunction
%fprintf('\nTesting lrCostFunction() with regularization');

%theta_t = [-2; -1; 1; 2];
%X_t = [ones(5,1) reshape(1:15,5,3)/10];
%y_t = ([1;0;1;0;1] >= 0.5);
%lambda_t = 3;
%[J grad] = lrCostFunction(theta_t, X_t, y_t, lambda_t);

%fprintf('\nCost: %f\n', J);
%fprintf('Expected cost: 2.534819\n');
%fprintf('Gradients:\n');
%fprintf(' %f \n', grad);
%fprintf('Expected gradients:\n');
%fprintf(' 0.146561\n -0.548558\n 0.724722\n 1.398003\n');

%fprintf('Program paused. Press enter to continue.\n');
%pause;
%% ============ Part 2b: One-vs-All Training ============
fprintf('\nTraining One-vs-All Logistic Regression...\n')

lambda = 0.1;
[all_theta] = oneVsAll(X, y, num_labels, lambda);

fprintf('Program paused. Press enter to continue.\n');
pause;
save("all_theta.txt", "all_theta");

%% ================ Part 3: Predict for One-Vs-All ================

pred = predictOneVsAll(all_theta, X);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);
