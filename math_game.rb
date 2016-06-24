
class MathGame

  def initialize(min_number, max_number, player_lives, players)
    @problem_min_number = min_number
    @problem_max_number = max_number
    @player_lives = player_lives
    @players = players
    @num_players = players.length
  end


  def run_a_game
    # create new game state
    init_game
    # loop game until everyone but 1 person loses
    while @playersRemaining > 1 do
      puts "It is Player #{@player_turn}'s turn. #{@current_player.name}:"
      run_question
      iterate_players_turn
    end
  end

  def print_winner
    winnerIndex = find_winner

    puts "Game over, #{@players[winnerIndex-1].name} wins!"
  end

  def print_game_stats
    # print player scores for this game
    @players.each_with_index do |player, index|
      puts "Player #{index+1}, #{player.name}, answered #{player.score} questions correctly."
    end
  end

  def print_career_stats
    puts "PLAYER STATS ---------------------- GAMES WON --- QUESTIONS ANSWERED"
    @players.each do |player|
      puts "Player #{player.playerNum} (#{player.name}):".ljust(40) + "#{player.gamesWon}".ljust(19) + "#{player.careerScore}"
    end
  end

  def print_status
    puts "................................ LIVES REMAINING ....... SCORE"
    @players.each do |player|
      puts "Player #{player.playerNum} (#{player.name}):".ljust(40) + "#{player.lives}".ljust(19) + "#{player.score}"
    end
  end

  private

  def init_game
    @player_turn = [1, @num_players].sample
    @current_player = @players[@player_turn - 1]

    @playersRemaining = @num_players

    @players.each do |player|
      player.reset(@player_lives)
    end
  end

  def random_math_problem
    MathProblem.new([:+, :-, :*, :/].sample, @problem_min_number, @problem_max_number)
  end

  def run_question
    problem = random_math_problem
    puts problem.question
    user_answer = gets.chomp.to_i
    if user_answer == problem.answer
      puts "Correct!".colorize(color: :green, background: :black)
      @current_player.addScore
    else
      puts "Incorrect! The answer was #{problem.answer}!".colorize(color: :yellow, background: :black)
      @current_player.removeLife
      if @current_player.isAlive?
        print_status
      else
        kill_player
      end
    end
  end

  def kill_player
    @playersRemaining -= 1
    message = "#{@current_player.name} loses"
    if @playersRemaining > 1
      message += ", #{@playersRemaining} players remaining!"
      print_status
    else
      message += "!"
    end
    puts message.colorize(color: :red)
  end

  def iterate_players_turn
    if @player_turn == @num_players
      @player_turn = 1
      @current_player = @players[0]
    else
      @player_turn += 1
      @current_player = @players[@player_turn-1]
    end

    iterate_players_turn unless @current_player.isAlive?
  end

  def find_winner
    # i feel that there is some better way to do this
    @players.each do |player|
      if player.isAlive?
        player.addWin
        return player.playerNum
      end
    end
  end

end
