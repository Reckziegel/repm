% =========================================================================
% sortinoratio.m
%
% Compute the Sortino ratio for the given portfolio returns
% 
% Input:
%  pfoReturns: matrix where each column is a return series for a single
%    portfolio
%  mar: level of minimum acceptable return (MAR)
% Output:
%  sortinoRatios: row vector of Sortino ratios for each portfolio
% =========================================================================
function sortinoRatios = sortinoratio(pfoReturns, mar)
    
    % Sortino ratio with MAR = mar
    pfoReturnsMAR = pfoReturns;
    pfoReturnsMAR(pfoReturns > mar) = 0;
    sortinoRatios = (mean(pfoReturns) - mar) ./ std(pfoReturnsMAR);
end