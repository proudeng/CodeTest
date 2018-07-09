%% Machine Learning Online Class
%  Exercise 1: Linear regression with multiple variables
%
%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the
%  linear regression exercise. 
%
%  You will need to complete the following functions in this 
%  exericse:
%
%     warmUpExercise.m
%     plotData.m
%     gradientDescent.m
%     computeCost.m
%     gradientDescentMulti.m
%     computeCostMulti.m
%     featureNormalize.m
%     normalEqn.m
%
%  For this part of the exercise, you will need to change some
%  parts of the code below for various experiments (e.g., changing
%  learning rates).
%

%% Initialization

%% ================ Part 1: Feature Normalization ================

%% Clear and Close Figures
clear ; close all; clc

fprintf('Loading data ...\n');

%% Load Data
data = load('delay_array.txt');
m = length(data);
train_num = m / 5 * 3;
test_num = m - train_num;

for i=1:m
	if data(i) > 20
		data(i) = 20;
	end
end


%train_data = data(1:train_num, 1);
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

m = length(y);

% Print out some data points
%fprintf('First 10 examples from the dataset: \n');
%fprintf(' x = [%.0f %.0f], y = %.0f \n', [X(1:10,:) y(1:10,:)]');

fprintf('Program paused. Press enter to continue.\n');
pause;

% Scale features and set them to zero mean
fprintf('Normalizing Features ...\n');

[X mu sigma] = featureNormalize(X);

% Add intercept term to X
X = [ones(m, 1) X];


%% ================ Part 2: Gradient Descent ================

% ====================== YOUR CODE HERE ======================
% Instructions: We have provided you with the following starter
%               code that runs gradient descent with a particular
%               learning rate (alpha). 
%
%               Your task is to first make sure that your functions - 
%               computeCost and gradientDescent already work with 
%               this starter code and support multiple variables.
%
%               After that, try running gradient descent with 
%               different values of alpha and see which one gives
%               you the best result.
%
%               Finally, you should complete the code at the end
%               to predict the price of a 1650 sq-ft, 3 br house.
%
% Hint: By using the 'hold on' command, you can plot multiple
%       graphs on the same figure.
%
% Hint: At prediction, make sure you do the same feature normalization.
%

fprintf('Running gradient descent ...\n');

% Choose some alpha value
%alpha = 0.01;
alpha2 = 0.03;
%alpha3 = 0.1;
%alpha4 = 1;
num_iters = 400;

% Init Theta and Run Gradient Descent 
%theta = zeros(6, 1);
%[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);
theta = zeros(6, 1);
[theta2, J_history2] = gradientDescentMulti(X(1:train_num,:), y(1:train_num, :), theta, alpha2, num_iters);
%theta = zeros(6, 1);
%[theta3, J_history3] = gradientDescentMulti(X, y, theta, alpha3, num_iters);
%theta = zeros(6, 1);
%[theta4, J_history4] = gradientDescentMulti(X, y, theta, alpha4, num_iters);

% Plot the convergence graph
figure;
%plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');
hold on;
plot(1:numel(J_history2), J_history2, '-r', 'LineWidth', 2);
%plot(1:numel(J_history3), J_history3, '-y', 'LineWidth', 2);
%plot(1:numel(J_history4), J_history4, '-k', 'LineWidth', 2);

% Display gradient descent's result
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta2);
fprintf('\n');


%estimate and calculate the accuracy
%test_data = data(train_num+1:end, 1);
%y_test = test_data(6:end, 1);
%x1_test = test_data(1:end-5, 1);
%x2_test = test_data(2:end-4, 1);
%x3_test = test_data(3:end-3, 1);
%x4_test = test_data(4:end-2, 1);
%x5_test = test_data(5:end-1, 1);
%X_test = [x1_test x2_test x3_test x4_test x5_test];
%X_test = [ones(test_num-5,1) X_test];

y_estimate = round( X(train_num+1:end, :) * theta2 );
%y_estimate = X(train_num+1:end, :) * theta2;
accurate_estimate = sum( y_estimate == y(train_num+1:end, 1) );
%accurate_estimate = sum( abs(y_estimate - y(train_num+1:end, 1)) <1 );

fprintf('Test accuracy is %f: \n', accurate_estimate/test_num);





% Estimate the price of a 1650 sq-ft, 3 br house
% ====================== YOUR CODE HERE ======================
% Recall that the first column of X is all-ones. Thus, it does
% not need to be normalized.
%price = 0; % You should change this
%sample = [1650 3];
%sample = (sample - mu)./sigma;
%sample = [1 sample];
%price = sample * theta2;

% ============================================================

%fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
%         '(using gradient descent):\n $%f\n'], price);

%fprintf('Program paused. Press enter to continue.\n');
%pause;

%% ================ Part 3: Normal Equations ================

%fprintf('Solving with normal equations...\n');

% ====================== YOUR CODE HERE ======================
% Instructions: The following code computes the closed form 
%               solution for linear regression using the normal
%               equations. You should complete the code in 
%               normalEqn.m
%
%               After doing so, you should complete this code 
%               to predict the price of a 1650 sq-ft, 3 br house.
%

%% Load Data
%data = csvread('ex1data2.txt');
%X = data(:, 1:2);
%y = data(:, 3);
%m = length(y);

% Add intercept term to X
%X = [ones(m, 1) X];

% Calculate the parameters from the normal equation
%theta = normalEqn(X, y);

% Display normal equation's result
%fprintf('Theta computed from the normal equations: \n');
%fprintf(' %f \n', theta);
%fprintf('\n');


% Estimate the price of a 1650 sq-ft, 3 br house
% ====================== YOUR CODE HERE ======================
%price = [1 1650 3] * theta; % You should change this


% ============================================================

%fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
%         '(using normal equations):\n $%f\n'], price);

