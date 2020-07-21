require 'pry'
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

# Define won?, full?, draw?, over?, and winner below
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

def display_board(board = [])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input = user_input.to_i
  converted_input = user_input - 1
  return converted_input
end

 def move(array, converted_input, character)
   array[converted_input] = character
 end
 
def valid_move?(board, move)
  if position_taken?(board,move)
    return false
    
  elsif move >= 0 && move <= 8
    return true
    
  elsif !(move >= 0 && move <= 8)
    return false
 
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end
  

def play(board)
  count = 1
  until over?(board) do
    turn(board)
    count += 1
  end
  draw?(board)
    puts "Cat's Game!"
  won?(board)
    puts "Congratulations #{winner(board)}!"

  
end
  
  
def turn_count(board)
  turn = 0
  board.each do |element|
    if element == "X" || element == "O"
      turn += 1
    end
  
  end
  return turn
end

def current_player(board)
  if turn_count(board).even?
    player = "X"
  elsif turn_count(board).odd?
    player = "O"
  end
  return player
end



