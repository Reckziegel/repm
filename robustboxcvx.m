% =========================================================================
% robustboxcvx.m
%
% Find the optimal robust portfolio with box uncertainty using CVX
%
% Input:
%  returns: matrix of stock returns (each column represents a single stock)
%  lambda: value of the risk-seeking coefficient
%  alpha: confidence level of the uncertainty set
% Output:
%  optPortfolio: optimal mean-variance portfolio (a column vector)
% =========================================================================
function optPortfolio =  robustboxcvx(returns, lambda, alpha)

    [nDays,n] = size(returns); % Number of data points and number of stocks
    
    % Compute the inputs of the mean-variance model
	mu = mean(returns)';
	sigma = cov(returns);
	
    % Compute delta
    z = norminv(1 - (1 - alpha) / 2, 0, 1);
    delta = z * sqrt(var(returns))' / sqrt(nDays);
    
    % Solve the portfolio problem using CVX
    cvx_begin
        variables x(n)
        minimize ( x'*sigma*x - lambda*(mu'*x - delta'*abs(x)) )
        subject to
            ones(1,n) * x == 1
    cvx_end

    optPortfolio = x;
end
