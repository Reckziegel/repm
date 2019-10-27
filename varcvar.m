% =========================================================================
% varcvar.m
%
% Find the value-at-risk and conditional value-at-risk from the provided
% returns (e.g., historical returns). Both values are expressed as losses
% (i.e., value-at-risk would be a loss of -x% rather than an x% return).
%
% Input:
%  returns: a column vector of returns
%  prob: probability level between 0 and 1 for VaR and CVaR
%    (prob = 0.05 : finds VaR and CVaR for the worst 5% of the cases)
% Output:
%  var: value-at-risk
%  cvar: conditional value-at-risk
% =========================================================================
function [var, cvar] = varcvar(returns, prob)

    % Sort the returns in ascending order
    returnsSorted = sort(returns);

    % Find the index of the sorted return that represents the desired VaR
    num = size(returns,1); % Total number of returns
    returnIndexVaR = floor(prob * num);
    
    % Compute the VaR and CVaR
    var = -returnsSorted(returnIndexVaR);
    cvar = -mean(returnsSorted(1:returnIndexVaR));
end