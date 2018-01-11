function [J, grad] = costFunction(theta, X, y)
%COSTFUNCTION Compute cost and gradient for logistic regression
%   J = COSTFUNCTION(theta, X, y) computes the cost of using theta as the
%   parameter for logistic regression and the gradient of the cost
%   w.r.t. to the parameters.

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
%
% Note: grad should have the same dimensions as theta
sigma1 = 0;
sigma2 = 0;


% a = log(sigmoid(X*theta))= m x 1; a' = 1 x m; y = m x 1;
% a' * y = R

sigma1 = -log(sigmoid(X*theta))' * y;
sigma2 = -log(1-sigmoid(X*theta))' * (1-y);
J = (sigma1 + sigma2)/m;


% X = m x n; so X' = n x m;
%(sigmoid(X * theta) - y) = m x 1;
%X' * (sigmoid(X * theta) - y) = n x 1;
grad = (X' * (sigmoid(X*theta) - y))/m;

% =============================================================

end
