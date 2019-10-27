% =========================================================================
% portfolioalphabeta.m
%
% Compute portfolio alpha and beta for the given portfolio returns
% 
% Input:
%  pfoReturns: matrix where each column is a return series for a single
%    portfolio
%  indexReturns: return vector of a benchmark index
%  riskFreeRate: risk-free rate (either a single value or a vector)
% Output:
%  alphas: row vector of portfolio alphas for each portfolio
%  betas: row vector of portfolio betas for each portfolio
% =========================================================================
function [alphas, betas] = portfolioalphabeta(pfoReturns, indexReturns, ...
    riskFreeRate)

    % Total number of periods and number of portfolios in the input data
    [nTime, numPfo] = size(pfoReturns);
    
    % Find alpha and beta from linear regression
    alphas = zeros(1, numPfo);
    betas = zeros(1, numPfo);
    for i = 1:numPfo
        coeffs = regress(pfoReturns(:,i) - riskFreeRate, ...
            [ones(nTime,1), indexReturns - riskFreeRate]);
        alphas(i) = coeffs(1);
        betas(i) = coeffs(2);
    end
end