% =========================================================================
% robustboxyalmip.m
%
% Find the optimal robust portfolio with box uncertainty using YALMIP
%
% Input:
%  returns: matrix of stock returns (each column represents a single stock)
%  lambda: value of the risk-seeking coefficient
%  alpha: confidence level of the uncertainty set
% Output:
%  optPortfolio: optimal mean-variance portfolio (a column vector)
% =========================================================================
function optPortfolio =  robustboxyalmip(returns, lambda, alpha)

    [nDays,n] = size(returns); % Number of data points and number of stocks
    
    % Compute the inputs of the mean-variance model
	mu = mean(returns)';
	sigma = cov(returns);
	
    % Compute delta
    z = norminv(1 - (1 - alpha) / 2, 0, 1);
    delta = z * sqrt(var(returns))' / sqrt(nDays);
    
    
    % Solve the robust portfolio problem using YALMIP
    w = sdpvar(n, 1);
    mu_true = sdpvar(n, 1);
    
    objective = w' * sigma * w - lambda * mu_true' * w;
    constraint = [sum(w) == 1, ...
        mu - delta <= mu_true <= mu + delta, uncertain(mu_true)];
    
    optimize(constraint, objective);
    optPortfolio = value(w);
end
