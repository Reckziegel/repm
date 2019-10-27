% =========================================================================
% robustellipsoidyalmip.m
%
% Find the optimal robust portfolio with ellipsoid uncertainty using YALMIP
%
% Input:
%  returns: matrix of stock returns (each column represents a single stock)
%  lambda: value of the risk-seeking coefficient
%  alpha: confidence level of the uncertainty set
% Output:
%  optPortfolio: optimal mean-variance portfolio (a column vector)
% =========================================================================
function optPortfolio =  robustellipsoidyalmip(returns, lambda, alpha)

    [nDays,n] = size(returns); % Number of data points and number of stocks
    
    % Compute the inputs of the mean-variance model
	mu = mean(returns)';
	sigma = cov(returns);
    sigmaMu = sigma / nDays; % Estimation for the covariance matrix of
                             % estimation errors
    
    % Compute delta
    delta = sqrt(chi2inv(alpha,n));
    
    
    % Solve the robust portfolio problem using YALMIP
    w = sdpvar(n, 1);
    mu_true = sdpvar(n, 1);
    
    objective = w' * sigma * w - lambda * mu_true' * w;
    constraint = [sum(w) == 1, ...
        (mu_true-mu)'/(sigmaMu)*(mu_true-mu) <= delta, uncertain(mu_true)];
    
    optimize(constraint, objective);
    optPortfolio = value(w);
end
