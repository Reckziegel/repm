% =========================================================================
% valueatrisk.m
%
% Compute the value-at-risk (VaR) for the given portfolio returns
% 
% Input:
%  pfoReturns: matrix where each column is a return series for a single
%    portfolio
%  alpha: level of confidence (widely used values are 0.9, 0.95, and 0.99)
% Output:
%  valueAtRisks: row vector of value-at-risks for each portfolio
% =========================================================================
function valueAtRisks = valueatrisk(pfoReturns, alpha)
    
    % Find the value for VaR from the proper quantile
    valueAtRisks = quantile(pfoReturns, 1 - alpha);
end