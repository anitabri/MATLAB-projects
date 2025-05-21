function[]=L13_Q04()
%Anita Britto
[n] = get_positive_integer('Enter a positive integer for the max: ');
play_game(n);
end
function[n] = get_positive_integer(prompt)
    while true
        input_value = input(prompt);
        
        if input_value > 0 && abs(round(input_value) - input_value) < 1e-8
            n = round(input_value);  % Ensure it's exactly an integer
            break;
        else
            fprintf('Invalid entry %g\n', input_value);
        end
    end
end

function [] = play_game(n)
    available = ones(1, n);  % 1 = available, 0 = unavailable
    player_score = 0;
    computer_score = 0;

    while check_if_number_still_available(n, available)
        print_available_numbers(n, available);
        selected = get_player_selection(n, available);

        player_score = player_score + selected;
        available(selected) = 0;  % mark player's pick as unavailable

        [computer_score, available] = update_computer_score(computer_score, selected, available);
    end

    fprintf('Your score is %d and mine is %d -- ', player_score, computer_score);
    if player_score > computer_score
        fprintf('you win!\n');
    else
        fprintf('you lose!\n');  % Computer wins in case of a tie
    end
end

function [selected] = get_player_selection(n, available)
    while true
        selected = get_positive_integer('Enter a positive integer for your selection: ');
        if selected <= n && available(selected)
            return;
        elseif selected > n
            fprintf('Number must be less than or equal to %d\n', n);
        else
            fprintf('That number is no longer available\n');
        end
    end
end

function[] = print_available_numbers(n, available)
    fprintf('Available numbers: ');
    for i = 1:n
        if available(i)
            fprintf('%d ', i);
        end
    end
    fprintf('\n');
end

function[computer_score, available] = update_computer_score(computer_score, selected_num, available)
    for i = 1:selected_num-1  % Only check factors up to selected_num-1
        if mod(selected_num, i) == 0 && available(i)
            computer_score = computer_score + i;
            available(i) = 0;
        end
    end
end
 
function[result] = check_if_number_still_available(n, available)
    result = 0;
    for i = 1:n
        if available(i)
            result = 1;
            return;  % Return immediately when an available number is found
        end
    end
end