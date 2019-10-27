% =========================================================================
% sharperatio.m
%
% Compute the Sharpe ratio for the given portfolio returns
% 
% Input:
%  pfoReturns: matrix where each column is a return series for a single
%    portfolio
%  riskFreeRate: risk-free rate (either a single value or a vector)
%  numPeriodsYear: number of periods in a year (e.g., 12 for monthly data)
%  totalYears: investment horizon in years for pfoReturns
% Output:
%  sharpeRatio: row vector of Sharpe ratios for each portfolio
%  annualSharpeRatio: row vector of annualized Sharpe ratios for each 
%    portfolio using geometric mean for computing excess return
% =========================================================================
function [sharpeRatio, annualSharpeRatio] = sharperatio(pfoReturns, ...
    riskFreeRate, numPeriodsYear, totalYears)

    % Total number of periods and number of portfolios in the input data
    [nTime,numPfo] = size(pfoReturns);
    
    % Create a vector of risk-free rate if a single value is given
    if(length(riskFreeRate) == 1)
        riskFreeRate = riskFreeRate * ones(nTime,1);
    end

    % Use arithmetic mean for computing excess return
    sharpeRatio = mean(pfoReturns - repmat(riskFreeRate,1,numPfo)) ...
        ./ std(pfoReturns);
    
    % Use geometric mean for computing annual excess return
    excessReturn = prod(1 + pfoReturns - repmat(riskFreeRate,1,numPfo)) ...
        .^ (1/totalYears) - 1;
    vol = std(pfoReturns) .* sqrt(numPeriodsYear);
    annualSharpeRatio = excessReturn ./ vol;
end