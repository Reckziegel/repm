% =========================================================================
% threefrontiers.m
%
% Plot three efficient frontiers:
%  1. Estimated frontier
%  2. Actual frontier
%  3. True frontier
%
% The optimal mean-variance portfolio is found from the below problem with 
% various levels of portfolio return (r_p),
%
%     min  1/2*(w'*sigma*w)
%     s.t. mu'*w >= r_p
%          w'*ones = 1
%
% Unless specified by the function parameters, portfolios with expected
% returns of 0%, 10%, 20%, 30%, 40%, and 50% are plotted
%
% Input:
%  estReturns: matrix of estimated stock returns used for estimation 
%    (each column represents a single stock)
%  trueReturns: matrix of true stock returns used for evaluation
%    (each column represents a single stock)
%  retMin: minimum level of portfolio return (optional)
%  retMax: maximum level of portfolio return (optional)
%  retInt: interval between retmin and retmax (optional)
% =========================================================================
function threefrontiers(estReturns, trueReturns, retMin, retMax, retInt)

    % Set minimum and maximum levels for portfolio return unless they are
    % provided by the user
    if (nargin == 2)
        retMin = 0;
        retMax = 0.5;
        retInt = 0.1;
    end
    retlevels = retMin:retInt:retMax; % List of return levels used
    numPfo = length(retlevels);       % Total number of portfolios to find
    
    n = size(estReturns,2); % Number of assets
    
    % Estimated inputs for the mean-variance model
    estMu = mean(estReturns)';
    estSigma = cov(estReturns);
    
    % True inputs for the mean-variance model
    trueMu = mean(trueReturns)';
    trueSigma = cov(trueReturns);

    % Find the optimal portfolio from estimated data and save the
    % estimated and actual frontiers
    estRet = zeros(numPfo,1);
    estRisk = zeros(numPfo,1);
    actRet = zeros(numPfo,1);
    actRisk = zeros(numPfo,1);
    for i = 1:numPfo
        pfo = quadprog(estSigma, [], -estMu', -retlevels(i), ones(1,n), 1);
        estRet(i) = estMu' * pfo;
        estRisk(i) = sqrt(pfo' * estSigma * pfo);
        actRet(i) = trueMu' * pfo;
        actRisk(i) = sqrt(pfo' * trueSigma * pfo);
    end
    
    % Find the optimal portfolio from true data and save the true frontier
    trueRet = zeros(numPfo,1);
    trueRisk = zeros(numPfo,1);
    for i = 1:numPfo
        pfo = quadprog(trueSigma, [], -trueMu', -retlevels(i), ones(1,n), 1);
        trueRet(i) = trueMu' * pfo;
        trueRisk(i) = sqrt(pfo' * trueSigma * pfo);
    end
    
    % Plot the three frontiers
    plot(estRisk,estRet,'k:', actRisk,actRet,'k--', trueRisk,trueRet,'k-');
end
    
    