function MI = mutual_information(X,Y,num_bins)
    % This function computes the mutual information between X and Y
    
    % Inputs:
    % X,Y: vectors of the same length
    % num_bins: the number of bins for the histogram
    
    % Outputs:
    % MI: mutual information between X and Y

    % First, compute the joint histogram:
    [jointCounts, ~, ~] = histcounts2(X,Y,num_bins);
    jointProb = jointCounts / numel(X);
    
    % Next, compute the marginal histograms:
    xCounts = histcounts(X,num_bins);
    yCounts = histcounts(Y,num_bins);
    xProb = xCounts / numel(X);
    yProb = yCounts / numel(Y);
    
    % Compute the mutual information:
    MI = 0;
    for i = 1:num_bins
        for j = 1:num_bins
            if jointProb(i,j) > 0 && xProb(i) > 0 && yProb(j) > 0
                MI = MI + jointProb(i,j) * log2(jointProb(i,j) / (xProb(i) * yProb(j)));
            end
        end
    end
end
