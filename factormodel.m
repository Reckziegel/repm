% =========================================================================
% factormodel.m
%
% Find values of alpha (a) and beta (b) from the factor model:
%     r = a + b*f + e
%
% Input:
%  returns: vector of returns for a stock
%  factorReturns: matrix of returns for factors (each column is a single
%  factor)
% Output:
%  alpha: value of alpha from factor model
%  beta: value of beta from factor model
% =========================================================================
function [alpha, beta] = factormodel(returns, factorReturns)
    % Perform linear regression
    coeffs = regress(returns, [ones(size(returns)), factorReturns]);
    alpha = coeffs(1);
    beta = coeffs(2:end);
end
