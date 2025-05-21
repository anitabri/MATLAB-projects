function [] = L11_Q05
% Anita Britto
% L11_Q05 generates 10,000 samples from a Gaussian distribution using the Box-Muller
% method and counts how many samples fall into bins defined between user-specified
% xmin and xmax. The bin width is 0.5, and results can be visualized optionally.

% --- Main Program Variables ---
% mu, sigma        - mean and standard deviation of the normal distribution
% xmin, xmax       - range for histogram binning
% samples          - array of generated Gaussian samples
% counts           - array holding counts for each bin

[mu, sigma, validSigma] = get_mean_and_std_dev();
if validSigma == 1
    [xmin, xmax, validRange] = get_min_and_max();
    if validRange == 1
        samples = generate_gaussian_samples(mu, sigma);
        counts = count_samples(samples, xmin, xmax);
        
        fprintf('The bin counts are:\n');
        for i = 1:length(counts)
            fprintf('%d ', counts(i));
        end
        fprintf('\n');

    end
end
end

function [mu, sigma, valid] = get_mean_and_std_dev()
% Function Purpose:
% Prompts user for mean and standard deviation, checks if sigma is valid

    mu = input('Enter a value for the mean: ');
    sigma = input('Enter a value for the standard deviation: ');
    if sigma > 0
        valid = 1;
    else
        fprintf('Invalid entry %.2f\n', sigma);
        valid = 0;
    end
end

function [xmin, xmax, valid] = get_min_and_max()
% Function Purpose:
% Prompts user for histogram range (xmin to xmax), checks if valid

    xmin = input('Enter the min for the histogram: ');
    xmax = input('Enter the max for the histogram: ');
    if xmax > xmin
        valid = 1;
    else
        fprintf('Invalid entry %.2f\n', xmax);
        valid = 0;
    end
end

function samples = generate_gaussian_samples(mu, sigma)
% Function Purpose:
% Uses Box-Muller transform to generate 10,000 Gaussian samples

    samples = zeros(10000, 1);
    for i = 1:5000
        u1 = rand();
        u2 = rand();
        [x1, x2] = uniform_to_gaussian(u1, u2, mu, sigma);
        samples(2*i-1) = x1;
        samples(2*i) = x2;
    end
end

function [x1, x2] = uniform_to_gaussian(u1, u2, mu, sigma)
% Function Purpose:
% Converts two uniform random variables into two Gaussian samples

    r = sqrt(-2 * log(u1));
    theta = 2 * pi * u2;
    x1 = sigma * r * cos(theta) + mu;
    x2 = sigma * r * sin(theta) + mu;
end

function bin_number = number_to_bin(x, xmin, xmax)
% Function Purpose:
% Determines which bin a sample belongs to based on its value

    if x < xmin
        bin_number = 1;
    elseif x >= xmax
        bin_number = 2 * (xmax - xmin);
    else
        bin_number = floor(2 * (x - xmin)) + 1;
    end
end

function counts = count_samples(samples, xmin, xmax)
% Function Purpose:
% Bins all samples and returns a count of how many fall into each bin

    numBins = 2 * (xmax - xmin);
    counts = zeros(1, numBins);
    for i = 1:length(samples)
        b = number_to_bin(samples(i), xmin, xmax);
        counts(b) = counts(b) + 1;
    end
end

function [] = plot_samples(counts, xmin, xmax)
% Function Purpose:
% Plots a histogram line plot using the bin counts

    figure;
    binEdges = xmin:0.5:xmax - 0.5;
    plot(binEdges, counts, 'k');  % black line for bin counts
    xlabel('x');
    ylabel('Count');
    title('Histogram of Gaussian Samples');
    saveas(gcf, 'L11_Q05_plot.png');
end
