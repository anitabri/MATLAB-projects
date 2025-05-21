function[] = L15_Q02()
%Anita Britto
rows = 20;
cols = 20;


curr_row = 10;
curr_col = 10;
curr_dir = 'n' ;
board = zeros(rows, cols) ;
board(curr_row, curr_col) = 1;
done = 0;
while done == 0
    [command] = get_command();
    [curr_row, curr_col, curr_dir, board, done]= do_command(curr_row, curr_col, curr_dir, board, command, rows, cols);
end

end

function[command] = get_command()

command = input('Enter a command (1 = turn right, 2 = turn left, 3 = move, 4 = print, 5 = quit): ');

    while command < 1 || command > 5 || abs(round(command)-command) >= 1e-8

        fprintf('Invalid entry %g\n', command);

        command = input('Enter a command (1 = turn right, 2 = turn left, 3 = move, 4 = print, 5 = quit): ');
        
    end

end

function[curr_row, curr_col, curr_dir, board, done] = do_command(curr_row, curr_col, curr_dir, board, command, rows, cols)

if command == 1
done = 0;
[curr_dir]  = do_turn_right(curr_dir);
elseif command == 2
done = 0;
[curr_dir] = do_turn_left(curr_dir);
elseif command == 3
done = 0;
[curr_row, curr_col, board] = do_move(curr_row, curr_col, curr_dir, board);
elseif command == 4
done = 0;
print_board(board, rows, cols);

elseif command == 5
done = 1;

end
end

function[curr_dir]  = do_turn_right(curr_dir)

if curr_dir == 'n'
curr_dir = 'e';
elseif curr_dir == 's'
curr_dir = 'w';
elseif curr_dir == 'e'
curr_dir = 's';
elseif curr_dir == 'w'
curr_dir = 'n';
end

fprintf('Turned right to give facing direction %s\n', curr_dir);

end

function[curr_dir] = do_turn_left(curr_dir)


if curr_dir == 'n'
curr_dir = 'w';
elseif curr_dir == 's'
curr_dir = 'e';
elseif curr_dir == 'e'
curr_dir = 'n';
elseif curr_dir == 'w'
curr_dir = 's';
end

fprintf('Turned left to give facing direction %s\n', curr_dir);

end

function[curr_row, curr_col, board] = do_move(curr_row, curr_col, curr_dir, board)

steps = input('Enter how many steps to move forward: ');

while steps <= 0 || abs(round(steps)- steps) >= 1e-8
    fprintf('Invalid entry %g\n', steps);
    steps = input('Enter how many steps to move forward: ');
end
for i = 1:steps
 if curr_dir == 'n'
     curr_row = curr_row - 1;
 elseif curr_dir == 's'
     curr_row = curr_row + 1;
 elseif curr_dir == 'e'
     curr_col = curr_col + 1;
 elseif curr_dir == 'w'
     curr_col = curr_col - 1;
 end

 board(curr_row, curr_col) = 1; 
end

fprintf('Moved forward %d steps to give position (row, col) = (%d, %d)\n',...
    steps, curr_row, curr_col);
end

function[] = print_board(board, rows, cols)

for i = 1:rows
    for j = 1: cols
        if board(i,j) == 1
            fprintf('* ');
        else
            fprintf('- ');
        end
    end
     fprintf('\n');
end

end