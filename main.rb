
require 'colorize'
require_relative 'player.rb'
require_relative 'math_problem.rb'
require_relative 'math_game.rb'

puts "Enter number of players:"
# TODO: handle 1 player game, probably add seperate method, or perhaps code it into math_game?
num_players = gets.chomp.to_i

app = MathGame.new(1,20,3,num_players)
app.run