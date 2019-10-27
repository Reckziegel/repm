% =========================================================================
% maxdrawdown.m
%
% Compute the maximum drawdown for the given portfolio returns
% 
% Input:
%  pfoReturns: matrix where each column is a return series for a single
%    portfolio
% Output:
%  maxDrawdowns: row vector of maximum drawdowns for each portfolio
% =========================================================================
function maxDrawdowns = maxdrawdown(pfoReturns)

    % Total number of periods and number of portfolios in the input data
    [nTime, numPfo] = size(pfoReturns);
    
    % Compute the wealth path of the investment
    % (assume wealth of first day is 1)
    wealth = cumprod([ones(1,numPfo); 1+pfoReturns(2:end,:)]);
    
    % Find the maximum drawdown from the wealth path
    drawdown = zeros(nTime,numPfo);
    for i = 1:nTime
        drawdown(i,:) = 1 - wealth(i,:) ./ max(wealth(1:i,:));
    end
    maxDrawdowns = max(drawdown);
end