% =========================================================================
% robustellipsoidfmincon.m
%
% Find the optimal robust portfolio with ellipsoid uncertainty using the
% "fmincon" function
%
% Input:
%  returns: matrix of stock returns (each column represents a single stock)
%  lambda: value of the risk-seeking coefficient
%  alpha: confidence level of the uncertainty set
% Output:
%  optPortfolio: optimal mean-variance portfolio (a column vector)
% =========================================================================
function optPortfolio =  robustellipsoidfmincon(returns, lambda, alpha)

    [nDays,n] = size(returns); % Number of data points and number of stocks
    
    % Compute the inputs of the mean-variance model
	mu = mean(returns)';
	sigma = cov(returns);
    sigmaMu = sigma / nDays; % Estimation for the covariance matrix of
                             % estimation errors
	
    % Compute delta
    delta = sqrt(chi2inv(alpha,n));
    
    % Inputs of the fmincon functions
    Aeq = ones(1, n);
    beq = 1;
	x0 = ones(n,1) / n;	% Start with the equally-weighted portfolio
    options = optimset('Display', 'notify', 'Algorithm', ...
        'interior-point', 'MaxIter', 1E10, 'MaxFunEvals', 1E10);
    
	% Nested function which is used as the objective function
	function objValue = objfunction(x)
		objValue = x' * sigma * x - lambda * mu' * x ...
            + lambda * delta * sqrt(x' * sigmaMu * x);
	end

	optPortfolio = fmincon(@(x) objfunction(x), x0, [], [], Aeq, beq, ...
        [], [], [], options);
end
