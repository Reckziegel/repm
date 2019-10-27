% =========================================================================
% robustellipsoidcvx.m
%
% Find the optimal robust portfolio with ellipsoid uncertainty using CVX
%
% Input:
%  returns: matrix of stock returns (each column represents a single stock)
%  lambda: value of the risk-seeking coefficient
%  alpha: confidence level of the uncertainty set
% Output:
%  optPortfolio: optimal mean-variance portfolio (a column vector)
% =========================================================================
function optPortfolio =  robustellipsoidcvx(returns, lambda, alpha)

    [nDays,n] = size(returns); % Number of data points and number of stocks
    
    % Compute the inputs of the mean-variance model
	mu = mean(returns)';
	sigma = cov(returns);
    sigmaMu = sigma / nDays; % Estimation for the covariance matrix of
                             % estimation errors
	sqrtSigmaMu = sqrtm(sigmaMu);
    
    % Compute delta
    delta = sqrt(chi2inv(alpha,n));
    
    % Solve the portfolio problem using CVX
    cvx_begin
        variables x(n)
        minimize ( x' * sigma * x - lambda * mu' * x ...
            + lambda * delta * norm(sqrtSigmaMu * x, 2) )
        subject to
            ones(1,n) * x == 1
    cvx_end
    
    optPortfolio = x;
end