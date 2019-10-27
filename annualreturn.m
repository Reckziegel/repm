% =========================================================================
% annualreturn.m
%
% Compute the annual return given portfolio returns
% 
% Input:
%  pfoReturns: matrix where each column is a return series for a single
%    portfolio
%  totalYears: investment horizon in years for pfoReturns
% Output:
%  annualReturns: row vector of annual returns
% =========================================================================
function annualReturns = annualreturn(pfoReturns, totalYears)
    annualReturns = prod(1 + pfoReturns) .^ (1 / totalYears) - 1;
end