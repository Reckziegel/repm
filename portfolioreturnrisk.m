% =========================================================================
% portfolioreturnrisk.m
%
% Computes the return and risk of a portfolio given return data
%
% Input:
%  returns: T-by-N matrix with T period returns for N assets
%  portfolio: weights of a portfolio
% Output:
%  ret: return of the portfolio measured by mean
%  risk: risk of the portfolio measured by standard deviation
% =========================================================================
function [ret, risk] =  portfolioreturnrisk(returns, portfolio)
    % Compute the mean vector and covariance matrix
    mu = mean(returns)';
    sigma = cov(returns);

    % Compute return and risk based on expected return and covariance
    ret = mu' * portfolio;
    risk = sqrt(portfolio' * sigma * portfolio);
end
