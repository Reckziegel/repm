% =========================================================================
% trackingerror.m
%
% Compute the tracking error for the given portfolio returns
% 
% Input:
%  pfoReturns: matrix where each column is a return series for a single
%    portfolio
%  indexReturns: return vector of a benchmark index
% Output:
%  trackingErrors: row vector of tracking errors for each portfolio
% =========================================================================
function trackingErrors = trackingerror(pfoReturns, indexReturns)

    % Total number of portfolios in the input data
    numPfo = size(pfoReturns,2);
    
    % Compute tracking error from standard deviation
    trackingErrors = std(pfoReturns - repmat(indexReturns,1,numPfo));
end