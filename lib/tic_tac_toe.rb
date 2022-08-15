require 'pry'
class TicTacToe

    WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], 
                        [0,3,6], [1,4,7], [2,5,8], 
                        [0,4,8], [2,4,6]]

    def initialize
        @board = Array.new(9, " ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(number)
        (number.to_i) -1
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] == " " ? false : true
    end

    def valid_move?(index)
        if index >= 0 && index <= 9
            position_taken?(index) == false ? true : false
        else
            false
        end
    end

    def turn_count
        turn_c = []
        @board.each do |space|
            if space == "X" || space == "O"
                turn_c << space
            end
        end
        turn_c.size
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        prompt = gets
        board_index = input_to_index(prompt)
        if position_taken?(board_index) == false && valid_move?(board_index) == true
            move(board_index, current_player)
            display_board
        else
            turn
        end
    end

    def won?
        winning_array = []
        winning_combo = []
        WIN_COMBINATIONS.each do |combo|
            winning_array = [@board[combo[0]], @board[combo[1]], @board[combo[2]]]
            if winning_array.join == "XXX" || winning_array.join == "OOO"
                winning_combo = combo
                break
            else
                winning_array.clear
            end
        end
        winning_array == [] ? false : winning_combo 
    end

    def full?
        @board.include?(" ") == false ? true : false
    end

    def draw?
        full? == true && won? == false ? true : false
    end

    def over?
        won? != false || draw? == true ? true : false
    end

    def winner
        won? != false ? @board[won?[0]] : nil
    end

    def play
        display_message = "Please enter a number between 1-9 to make your move"

        until over? == true
            turn
        end
        
        if won?
            puts "Congratulations #{winner}!"
        else
            puts "Cat's Game!"
        end
    end

end

