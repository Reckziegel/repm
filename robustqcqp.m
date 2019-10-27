% =========================================================================
% robustqcqp.m
%
% Solve the below QCQP portfolio problem using CVX
%
%     min  z
%     s.t. z <= mu_i'*w - beta*w'*sigma_i*w     for i = 1,..,I
%          w'*ones = 1
%
% Input:
%  muAgg: n-by-I matrix where each column is a sample mean
%  sigmaAgg: a three dimensional (n-by-n-by-I) matrix where each page 
%             (n-by-n matrix) is a sample covariance matrix
% Output:
%  w: portfolio weights
% =========================================================================
function w = robustqcqp (muAgg, sigmaAgg)

    % Identify the number of assets and the number of sets of samples
    [n,I] = size(muAgg);

    % Set beta to 1 (can change value as needed)
    beta = 1;

    % Invoke CVX
    cvx_begin
        % Define two variables: z and w
        variables z w(n);
        % Objective for QCQP
        maximize(z);
        % Constraints
        subject to
            ones(1,n) * w == 1; % Sum of weights = 1
            % I quadratic constraints
            for i = 1:I
                z <= muAgg(:,i)'*w - beta*quad_form(w,sigmaAgg(:,:,i));
            end
    cvx_end
end
