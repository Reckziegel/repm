% =========================================================================
% portfolioclosedform.m
%
% Find the optimal mean-variance portfolio of the below problem using 
% its closed-form solution
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
function optPortfolio =  portfolioclosedform(returns, lambda)

    % Compute the inputs of the mean-variance model
	mu = mean(returns)';
	sigma = cov(returns);
    
    n = length(mu); % Number of stocks
    oneVector = ones(n,1);
	
    optPortfolio = ((lambda/2) * (sigma \ mu)) ...
        + ((1 - (lambda/2) * (oneVector'/sigma) * mu) ...
        / ((oneVector'/sigma) * oneVector)) ...
        * (sigma \ oneVector);
end
