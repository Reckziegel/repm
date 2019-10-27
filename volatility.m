% =========================================================================
% volatility.m
%
% Compute the annualized volatility for the given portfolio returns
% 
% Input:
%  pfoReturns: matrix where each column is a return series for a single
%    portfolio
%  numPeriodsYear: number of periods in a year (e.g., 12 for monthly data)
% Output:
%  vol: row vector of volatilities for each portfolio
% =========================================================================
function vol = volatility(pfoReturns, numPeriodsYear)
    vol = std(pfoReturns) .* sqrt(numPeriodsYear);
end