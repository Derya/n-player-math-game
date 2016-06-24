

class MathGame
  def initialize(min_number, max_number, player_lives, num_players)
    @problem_min_number = min_number
    @problem_max_number = max_number
    @player_lives = player_lives
    @players = []
    @num_players = num_players

    puts "AW YEAH #{@num_players} PLAYER MATH GAME ARE YOU READY TO RUMBLE"
    for playerNumber in 1..(@num_players) do
      puts "Player #{playerNumber}, enter your name:"
      name = gets.chomp
      @players << Player.new(name, playerNumber)
    end

  end

  def run
    loop do
      runGame
      printWinner
      printGameStats
      printCareerStats

      puts "Play another game?".colorize(:color => :white, :background => :black)
      puts "(any key to continue, q to quit)"
      break if gets.chomp.capitalize == "Q"

    end
  end

  private

  def runGame
    # create new game state
    initGame
    # loop game until everyone but 1 person loses
    while (@playersRemaining > 1) do
      puts "It is Player #{@playerTurn}'s turn. #{@currentPlayer.name}:"
      runQuestion
      iteratePlayersTurn
    end
  end

  def initGame
    @playerTurn = [1,@num_players].sample
    @currentPlayer = @players[@playerTurn-1]
    @playersRemaining = @num_players

    @players.each do |player|
      player.reset(@player_lives)
    end
  end

  def randomMathProblem
    MathProblem.new([:add, :sub, :mult, :div].sample, @problem_min_number, @problem_max_number)
  end

  def runQuestion
    problem = randomMathProblem()
    puts problem.question
    userAnswer = gets.chomp.to_i
    if userAnswer == problem.answer
      puts "Correct!".colorize(:color => :green, :background => :black)
      @currentPlayer.addScore
    else
      puts "Incorrect! The answer was #{problem.answer}!".colorize(:color => :yellow, :background => :black)
      @currentPlayer.removeLife
      if @currentPlayer.isAlive?
        printStatus
      else
        killPlayer
      end
    end
  end

  def killPlayer
    @playersRemaining -= 1
    message = "#{@currentPlayer.name} loses"
    if @playersRemaining > 1
      message += ", #{@playersRemaining} players remaining!"
      printStatus
    else
      message += "!"
    end
    puts message.colorize(:color=>:red)
  end

  def iteratePlayersTurn
    if @playerTurn == @num_players
      @playerTurn = 1
      @currentPlayer = @players[0]
    else
      @playerTurn += 1
      @currentPlayer = @players[@playerTurn-1]
    end

    iteratePlayersTurn unless @currentPlayer.isAlive?
  end

  def printWinner
    winnerIndex = findWinner

    puts "Game over, #{@players[winnerIndex-1].name} wins!"
  end

  def printGameStats
    # print player scores for this game
    @players.each_with_index do |player, index|
      puts "Player #{index+1}, #{player.name}, answered #{player.score} questions correctly."
    end
  end

  def printCareerStats
    puts "PLAYER STATS ---------------------- GAMES WON --- QUESTIONS ANSWERED"
    @players.each do |player|
      puts "Player #{player.playerNum} (#{player.name}):".ljust(40) + "#{player.gamesWon}".ljust(19) + "#{player.careerScore}"
    end
  end

  def printStatus
    puts "................................ LIVES REMAINING ....... SCORE"
    @players.each do |player|
      puts "Player #{player.playerNum} (#{player.name}):".ljust(40) + "#{player.lives}".ljust(19) + "#{player.score}"
    end
  end

  def findWinner
    # i feel that there is some better way to do this
    @players.each do |player|
      if player.isAlive?
        player.addWin
        return player.playerNum
      end
    end
  end

end