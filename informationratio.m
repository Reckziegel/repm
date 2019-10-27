% =========================================================================
% informationratio.m
%
% Compute the information ratio for the given portfolio returns
% 
% Input:
%  pfoReturns: matrix where each column is a return series for a single
%    portfolio
%  indexReturns: return vector of a benchmark index
% Output:
%  infoRatios: row vector of information ratios for each portfolio
% =========================================================================
function infoRatios = informationratio(pfoReturns, indexReturns)

    % Total number of portfolios in the input data
    numPfo = size(pfoReturns,2);
    
    % Compute tracking error and then information ratio
    trackingErrors = std(pfoReturns - repmat(indexReturns,1,numPfo));
    infoRatios = mean(pfoReturns - repmat(indexReturns,1,numPfo)) ...
        ./ trackingErrors;
end