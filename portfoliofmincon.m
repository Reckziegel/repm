% =========================================================================
% portfoliofmincon.m
%
% Find the optimal mean-variance portfolio of the below problem using 
% the "fmincon" function
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
function optPortfolio =  portfoliofmincon(returns, lambda)

    % Compute the inputs of the mean-variance model
	mu = mean(returns)';
	sigma = cov(returns);
	
    % Inputs for the fmincon function
	n = length(mu);
	Aeq = ones(1,n);
	beq = 1;
    x0 = ones(n,1) / n; % Start with the equally-weighted portfolio
    options = optimset('Algorithm', 'interior-point', ...
        'MaxIter', 1E10, 'MaxFunEvals', 1E10);
	
	% Nested function which is used as the objective function
	function objValue = objfunction(w)
		objValue = w' * sigma * w - lambda * mu' * w;
	end
	
	optPortfolio = fmincon(@objfunction, x0, [], [], Aeq, beq, [], [], ...
        [], options);
end
