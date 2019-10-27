% =========================================================================
% condvalueatrisk.m
%
% Compute the conditional value-at-risk (CVaR) given portfolio returns
% 
% Input:
%  pfoReturns: matrix where each column is a return series for a single
%    portfolio
%  alpha: level of confidence (widely used values are 0.9, 0.95, and 0.99)
% Output:
%  condVaRs: row vector of conditional value-at-risks for each portfolio
% =========================================================================
function condVaRs = condvalueatrisk(pfoReturns, alpha)
    
    % Total number of portfolios in the input data
    numPfo = size(pfoReturns,2);
    
    % Find VaR from the proper quantile and then CVaR
    valueAtRisks = quantile(pfoReturns, 1 - alpha);
    condVaRs = zeros(1,numPfo);
    for i = 1:numPfo
        condVaRs(i) = mean(pfoReturns(pfoReturns(:,i) <= valueAtRisks(i), i));
    end
end