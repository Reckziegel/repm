% =========================================================================
% meanvariance.m
%
% Find the optimal mean-variance portfolio for the below problem with 
% various levels of portfolio return (r_p) and plot the efficient frontier
%
%     min  1/2*(w'*sigma*w)
%     s.t. mu'*w >= r_p
%          w'*ones = 1
%
% Unless specified by the function parameters, portfolios with expected
% returns of 0%, 10%, 20%, 30%, 40%, and 50% are plotted
%
% Input:
%  returns: matrix of stock returns (each column represents a single stock)
%  retMin: minimum level of portfolio return (optional)
%  retMax: maximum level of portfolio return (optional)
%  retInterval: interval between retmin and retmax (optional)
% Output:
%  ret: vector of portfolio returns
%  risk: vector of portfolio risk (standard deviation)
% =========================================================================
function [ret, risk] = meanvariance(returns, retMin, retMax, retInterval)

    % Set minimum and maximum levels for portfolio return unless they are
    % provided by the user
    if (nargin == 1)
        retMin = 0;
        retMax = 0.5;
        retInterval = 0.1;
    end

    % Retrieve the inputs of the mean-variance model
    mu = mean(returns)';
    sigma = cov(returns);
    n = size(returns,2);
    
    % Create vectors that will contain portfolio return and risk for each 
    % return level
    retlevels = retMin:retInterval:retMax;
    numPfo = length(retlevels);
    ret = zeros(numPfo, 1);
    risk = zeros(numPfo, 1);
    
    % Find the optimal portfolio for each return level
    for i = 1:numPfo
        pfo = quadprog(sigma, [], -mu', -retlevels(i), ones(1,n), 1);
        ret(i) = mu' * pfo;
        risk(i) = sqrt(pfo' * sigma * pfo);
    end
    
    % Plot the portfolios on the mean-standard deviation plane
    plot(risk, ret);
end
    
    