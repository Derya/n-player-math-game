
require 'colorize'
require_relative 'player.rb'
require_relative 'math_problem.rb'
require_relative 'math_game.rb'


puts "Enter number of players:"
num_players = gets.chomp.to_i
players = []
for player_num in 1..(num_players) do
  puts "Player #{player_num}, enter your name:"
  name = gets.chomp
  players << Player.new(name, player_num)
end

app = MathGame.new(1,20,3,players)

loop do
  app.run_a_game
  app.print_winner
  app.print_game_stats
  app.print_career_stats

  puts "Play another game?".colorize(:color => :white, :background => :black)
  puts "(any key to continue, q to quit)"
  break if gets.chomp.capitalize == "Q"
end