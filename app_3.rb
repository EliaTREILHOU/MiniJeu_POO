require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

def perform
  puts '+-------------------------------------------------+'
  puts "| Bienvenue sur 'ILS VEULENT TOUS MA POO' !       |"
  puts "| Le but du jeu est d'être le dernier survivant ! |"
  puts '+-------------------------------------------------+'

  print 'Entre ton nom > '
  user_name = gets.chomp

  game = Game.new(user_name)
end
