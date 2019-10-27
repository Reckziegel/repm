% =========================================================================
% portfolioquadprog.m
%
% Find the optimal mean-variance portfolio of the below problem using 
% the "quadprog" function
%
%     min (w'*sigma*w - lambda*mu'*w)
%     s.t. w'*ones = 1
%
% The lower and upper bounds on portfolio weights can also be set by 
% providing two additional parameters
%
% Input:
%  returns: matrix of stock returns (each column represents a single stock)
%  lambda: value of the risk-seeking coefficient
%  lb: lower bound on portfolio weights (optional)
%  ub: upper bound on portfolio weights (optional)
% Output:
%  optPortfolio: optimal mean-variance portfolio (a column vector)
% =========================================================================
function optPortfolio =  portfolioquadprog(returns, lambda, lb, ub)

    % No bounds on portfolio weights unless provided by the user
    if (nargin == 2)
        lb = [];
        ub = [];
    end

    % Compute the inputs of the mean-variance model
	mu = mean(returns)';
	sigma = cov(returns);
	
    % Use the "quadprog" function to solve the portfolio problem
	n = length(mu);
	Aeq = ones(1,n);
	beq = 1;
    options = optimset('Algorithm', 'interior-point-convex');
	optPortfolio = quadprog(2 * sigma, -lambda * mu', [], [], Aeq, beq, ...
        lb, ub, [], options);
end
