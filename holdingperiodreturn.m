% =========================================================================
% holdingperiodreturn.m
%
% Compute the holding period return given portfolio returns
% 
% Input:
%  pfoReturns: matrix where each column is a return series for a single 
%    portfolio
% Output:
%  periodReturns: row vector of holding period returns
% =========================================================================
function periodReturns = holdingperiodreturn(pfoReturns)
    periodReturns = prod(1 + pfoReturns) - 1;
end