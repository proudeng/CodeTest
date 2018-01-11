function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta

sigma1 = 0;
sigma2 = 0;
sigma3 = 0;

sigma1 = -log(sigmoid(X * theta))' * y;
sigma2 = -log(1 - sigmoid(X * theta))' * (1 - y);
sigma3 = (theta' * theta) * lambda * 0.5;
J = (sigma1 + sigma2 + sigma3)/m;

grad = (X' * (sigmoid(X * theta) - y))/m;
%update theta[1] to 0
theta(1) = 0;
grad = grad + (lambda * theta)/m;


% =============================================================

end
