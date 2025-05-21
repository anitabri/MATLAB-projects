function [] = L11_Q04
% Anita Britto
% L11_Q04 performs Monte Carlo integration to approximate the integral of
% cos(x) over the interval [-π/2, π/2]. The user enters the number of trials,
% and random points are tested to estimate the area under the curve.

% --- Main Program Variables ---
% numTrials       - number of random points to simulate
% valid           - input validity flag
% f               - function handle for cos(x)
% fXMin, fXMax    - x-boundaries of the region
% fYMin, fYMax    - y-boundaries of the region
% integral_approx - estimated area under the curve (integral)

    [numTrials, valid] = get_number_of_trials();
    
    if valid == 1
        f = @(x) cos(x);         % function to integrate
        fXMin = -pi/2;           % lower bound of x
        fXMax = pi/2;            % upper bound of x
        fYMin = 0;               % lower bound of y
        fYMax = 1;               % upper bound of y (max of cos(x) on this interval)
        
        integral_approx = approximate_integral(numTrials, f, fXMin, fXMax, fYMin, fYMax);
        fprintf('An approximation of the integral is %.3f\n', integral_approx);
    end
end

function [numTrials, valid] = get_number_of_trials()
% Function Purpose:
% Prompts user for the number of Monte Carlo trials and checks validity
%
% Output:
%   numTrials - number of trials for simulation
%   valid     - 1 if input is valid, 0 otherwise

    numTrials = input('Enter the number of trials: ');
    
    if abs(numTrials - round(numTrials)) < 1e-8 && numTrials > 0
        valid = 1;
    else
        fprintf('Invalid entry %d\n', numTrials);
        numTrials = -1;
        valid = 0;
    end
end

function approx = approximate_integral(n, f, xMin, xMax, yMin, yMax)
% Function Purpose:
% Performs Monte Carlo simulation to estimate the area under f(x)
%
% Input:
%   n     - number of trials
%   f     - function handle
%   xMin, xMax - bounds for x-axis
%   yMin, yMax - bounds for y-axis
%
% Output:
%   approx - estimated integral (area under f(x))

    % --- Local Variables ---
    % hitX, hitY   - coordinates of successful hits (points under f(x))
    % missX, missY - coordinates of misses (points above f(x))
    % hits         - number of successful hits

    hitX = [];
    hitY = [];
    missX = [];
    missY = [];
    hits = 0;
    
    % Run Program
    for i = 1:n
        x = xMin + (xMax - xMin) * rand();  % random x in [xMin, xMax]
        y = yMin + (yMax - yMin) * rand();  % random y in [yMin, yMax]
        
        if y <= f(x)
            hits = hits + 1;
            hitX(end+1) = x;
            hitY(end+1) = y;
        else
            missX(end+1) = x;
            missY(end+1) = y;
        end
    end
    
    % --- Estimate area under curve ---
    area = (xMax - xMin) * (yMax - yMin);
    approx = (hits / n) * area;


    % plot_trials(hitX, hitY, missX, missY, f, xMin, xMax);
end

function [] = plot_trials(hitX, hitY, missX, missY, f, xMin, xMax)
% Function Purpose:
% Plots the results of Monte Carlo integration showing hits and misses
%
% Input:
%   hitX, hitY   - x and y coordinates of points under f(x)
%   missX, missY - x and y coordinates of points above f(x)
%   f            - function being integrated
%   xMin, xMax   - x-axis bounds for plotting
%
% Output: None 

    xVals = linspace(xMin, xMax, 100);  % for plotting f(x)
    yVals = f(xVals);

    plot(hitX, hitY, 'go');             % green dots for hits
    hold on;
    plot(missX, missY, 'bo');           % blue dots for misses
    plot(xVals, yVals, 'k', 'LineWidth', 2);  % plot the curve f(x)
    xlabel('x');
    ylabel('y');
    title('Monte Carlo Integration of cos(x)');
    saveas(gcf, 'L11_Q04_plot.png');   % save figure to file
end
