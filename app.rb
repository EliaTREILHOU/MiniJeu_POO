require 'pry'
require 'respec'
require 'bundler'
Bundler.require

require_relative 'lib/player'

def perform
  #2 joueurs (José et Josianne)
  player_1 = Player.new('José')
  player_2 = Player.new('Josianne')

  while player_1.alive? && player_2.alive?
    puts "Voici l'état de nos joueurs :"
    #stats des 2 joueurs
    player_1.show_state
    player_2.show_state

    player_2.attacks(player_1) #player 2 vs player 1

    break if player_1.dead? #analyse si mort

    player_1.attacks(player_2) #player 1 vs player 2
  end
end

binding.pry