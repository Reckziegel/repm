% =========================================================================
% maxsharperatio.m
%
% Plot the efficient frontier using annualized values and find the 
% portfolio with maximum Sharpe ratio (no shorting constraints are imposed)
%
% Input:
%  returns: matrix of stock returns (each column represents a single stock)
%  riskFreeRates: risk-free rate represented as a vector (same number of
%     rows as the matrix 'returns')
%  numPfos: number of efficient portfolios to plot between the minimum-
%     variance portfolio and the max-return portfolio
% Output:
%  optPortfolio: optimal mean-variance portfolio (a column vector)
% =========================================================================
function optPortfolio = maxsharperatio(returns, riskFreeRates, numPfos)
    
    DAYS_IN_YEAR = 252; % Number of days in one year
    
    n = size(returns,2); % Number of stocks
	mu = mean(returns - riskFreeRates*ones(1,n))'; % Expected excess return
	sigma = cov(returns);
	
	Aeq = ones(1,n);
	beq = 1;
    lb = zeros(n,1); % Set the lower-bound to zero (no short)
	
    % Find the GMV portfolio and its expected return
    gmv = quadprog(sigma, [], [], [], Aeq, beq, lb, []);
    gmvReturn = mu' * gmv;

    portfolios = zeros(n, numPfos); % Portfolio results will be saved here

    % Compute the optimal portfolio for various levels of return
    returnLevels = linspace(gmvReturn, max(mu), numPfos);
    for iPortfolio = 1:numPfos
        Aeq = [ones(1,n); mu'];
        beq = [1; returnLevels(iPortfolio)];
        optPortfolio = quadprog(sigma, [], [], [], Aeq, beq, lb, []);
        
        % Save the optimal portfolio for this iteration
        portfolios(:,iPortfolio) = optPortfolio;
    end
    
    % Compute portfolio expected return and standard deviation
    portfolioReturns = mu' * portfolios;
    portfolioVols = diag(sqrt(portfolios' * sigma * portfolios))';
    
    % Plot the annualized values
    plot(sqrt(DAYS_IN_YEAR) * portfolioVols, ...
        DAYS_IN_YEAR * portfolioReturns, '*-');
    
    % Find the portfolio with maximum Sharpe ratio
    [~,maxIndex] = max(portfolioReturns ./ portfolioVols);
    optPortfolio = portfolios(:,maxIndex);
end
