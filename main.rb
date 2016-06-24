
require 'colorize'

MIN_NUMBER = 1
MAX_NUMBER = 20
INITIAL_LIVES = 3

@num_players
@lives
@score
@totalScore = []
@games_won = []
@playerTurn
@playersRemaining

def init
  puts "AW YEAH N PLAYER MATH GAME ARE YOU READY TO RUMBLE"
  puts "Enter number of players:"
  @num_players = gets.chomp.to_i
  for i in 0..(@num_players-1) do
    @totalScore << 0
    @games_won << 0
  end
end

def initGame
  @lives = []
  @score = []
  for i in 0..(@num_players-1) do
    @lives << INITIAL_LIVES
    @score << 0
  end
  @playerTurn = [0,@num_players-1].sample
  @playersRemaining = @num_players
end

# these methods return in format ["What is the Meaning of Life?", 42]
def randomQuestion
  case [:add, :sub, :mult, :div].sample
  when :add
    addQuestion
  when :sub
    subQuestion
  when :mult
    multQuestion
  when :div
    divQuestion
  end
end

def addQuestion
  x = rand(MAX_NUMBER-MIN_NUMBER) + MIN_NUMBER
  y = rand(MAX_NUMBER-MIN_NUMBER) + MIN_NUMBER
  question = "What is #{x.to_i} + #{y.to_i}?"
  answer = x + y
  [question, answer]
end

def subQuestion
  x = rand(MAX_NUMBER-MIN_NUMBER) + MIN_NUMBER
  y = rand(MAX_NUMBER-MIN_NUMBER) + MIN_NUMBER
  if (y > x)
    x,y = y,x
  end
  question = "What is #{x.to_i} - #{y.to_i}?"
  answer = x - y
  [question, answer]
end

def multQuestion
  x = rand(MAX_NUMBER-MIN_NUMBER) + MIN_NUMBER
  y = rand(MAX_NUMBER-MIN_NUMBER) + MIN_NUMBER
  question = "What is #{x.to_i} * #{y.to_i}?"
  answer = x * y
  [question, answer]
end

# i sure hope MIN_NUMBER is above 0 
def divQuestion
  x = rand(MAX_NUMBER-MIN_NUMBER) + MIN_NUMBER
  y = rand(MAX_NUMBER-MIN_NUMBER) + MIN_NUMBER
  if (y > x)
    x,y = y,x
  end
  question = "What is #{x.to_i} / #{y.to_i} rounded down?"
  answer = x / y
  [question, answer]
end

def printStatus
  puts "........... LIVES REMAINING ..... SCORE"
  for i in 0..(@num_players-1) do
    puts "Player #{i+1}:          #{@lives[i]}                 #{@score[i]}"
  end
end

def runQuestion
  question = randomQuestion()
  puts question[0]
  answer = gets
  if answer.chomp.to_i == question[1]
    puts "Correct!".colorize(:color => :green, :background => :black)
    @score[@playerTurn] += 1
  else
    puts "Incorrect! The answer was #{question[1].to_s}!".colorize(:color => :yellow, :background => :black)
    @lives[@playerTurn] -= 1
    if @lives[@playerTurn] == 0
      @playersRemaining -= 1
      message = "Player #{@playerTurn+1} loses"
      if @playersRemaining > 1
        message += ", #{@playersRemaining} players remaining!"
        printStatus
      else
        message += "!"
      end
      puts message.colorize(:color=>:red)
    else
      printStatus
    end
  end
end

def iteratePlayersTurn
  if @playerTurn == @num_players-1
    @playerTurn = 0
  else
    @playerTurn += 1
  end

  iteratePlayersTurn if @lives[@playerTurn] == 0
end

def printCareerStats
  puts "PLAYER STATS --- GAMES WON --- QUESTIONS ANSWERED"
  for i in 0..(@num_players-1) do
    puts "Player #{i+1}:            #{@games_won[i]}              #{@totalScore[i]}"
  end
end

def runGame
  # create new game state
  initGame
  # loop game until everyone but 1 person loses
  while (@playersRemaining > 1) do
    puts "It is Player #{@playerTurn+1}'s turn. Player #{@playerTurn+1}:"
    runQuestion
    iteratePlayersTurn
  end

  # get winner
  winner = -1
  @lives.each_with_index do |lives, player|
    winner = player if (lives > 0)
  end

  puts "Game over, Player #{winner+1} wins!"

  # print and add players' scores to their career scores
  for i in 0..(@num_players-1) do
    @totalScore[i] += @score[i]
    puts "Player #{i+1} answered #{@score[i]} questions correctly."
  end

  # add game winners' score
  @games_won[winner] += 1
end

def gameREPL
  init
  loop do
    runGame
    printCareerStats
    puts "Play another game?"
    puts "(any key to continue, q to quit)"
    break if gets.chomp.capitalize == "Q"
  end
end

gameREPL