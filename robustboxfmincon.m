% =========================================================================
% robustboxfmincon.m
%
% Find the optimal robust portfolio with box uncertainty using the 
% "fmincon" function
%
% Input:
%  returns: matrix of stock returns (each column represents a single stock)
%  lambda: value of the risk-seeking coefficient
%  alpha: confidence level of the uncertainty set
% Output:
%  optPortfolio: optimal mean-variance portfolio (a column vector)
% =========================================================================
function optPortfolio =  robustboxfmincon(returns, lambda, alpha)

    [nDays,n] = size(returns); % Number of data points and number of stocks
    
    % Compute the inputs of the mean-variance model
	mu = mean(returns)';
	sigma = cov(returns);
	
    % Compute delta
    z = norminv(1 - (1 - alpha) / 2, 0, 1);
    delta = z * sqrt(var(returns))' / sqrt(nDays);
    
    % Compute the inputs for the nested function and the fmincon function
	identity = eye(n);
    transform = [identity, -identity];
    transformAbs = [identity, identity];
    muTransformed = (mu' * transform - (delta' * transformAbs));
    Aeq = [ones(1, n), - ones(1, n)];
    beq = 1;
    lb = zeros(2 * n, 1);
    x0 = [ones(n,1) / n; zeros(n,1)]; % Start with the equally-weighted 
                                      % portfolio
    options = optimset('Display', 'notify', 'Algorithm', ...
        'interior-point', 'MaxIter', 1E10, 'MaxFunEvals', 1E10);
    
	% Nested function which is used as the objective function
	function objValue = objfunction(x)
		objValue = x' * transform' * sigma * transform * x ...
            - lambda * muTransformed * x;
	end

	x = fmincon(@objfunction, x0, [], [], Aeq, beq, lb, [], [], options);
    optPortfolio = transform * x;
end
