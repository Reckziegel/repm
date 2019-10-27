% =========================================================================
% portfoliocvx.m
%
% Find the optimal mean-variance portfolio of the below problem using CVX
%
%     min (w'*sigma*w - lambda*mu'*w)
%     s.t. w'*ones = 1
%
% Input:
%  returns: matrix of stock returns (each column represents a single stock)
%  lambda: value of the risk-seeking coefficient
% Output:
%  optPortfolio: optimal mean-variance portfolio (a column vector)
% =========================================================================
function optPortfolio =  portfoliocvx(returns, lambda)

    % Compute the inputs of the mean-variance model
	mu = mean(returns)';
	sigma = cov(returns);
	
	n = length(mu); % Number of stocks
	
    % Solve the portfolio problem using CVX
	cvx_begin
		variable w(n)
		minimize ( w' * sigma * w - lambda * mu' * w )
		subject to
			ones(1,n) * w == 1
	cvx_end
	
	optPortfolio = w;
end
