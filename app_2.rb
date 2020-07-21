require 'bundler'
Bundler.require

require_relative 'lib/player'

def perform
  puts '+-------------------------------------------------+'
  puts "| Bienvenue sur 'ILS VEULENT TOUS MA POO' !       |"
  puts "| Le but du jeu est d'être le dernier survivant ! |"
  puts '+-------------------------------------------------+'

  print 'Saisie ton nom ici > '
  user_name = gets.chomp
  user = HumanPlayer.new(user_name)
  player1 = [Player.new('José')
  player2 = Player.new('Josianne')


  round = 0 #les tours commence de 0

  while user.alive? && players.any? { |d| d.alive? }
    round += 1 #rajoute 1 tours a chaque boucle faite

  #Menu du jeu
    puts '============================================================================='
    puts "| Niveau : #{round}"
    puts '| ' + user.get_state
    puts '-----------------------------------------------------------------------------'
    puts '|'
    puts '| Quelle action veux-tu effectuer ?'
    puts '|> a - chercher une meilleure arme'
    puts '|> b - chercher à se soigner'
    puts '|'
    puts '| Attaquer :'
    players.each_with_index {|player, index| puts "|> #{index} - #{player.get_state}"}
    puts '============================================================================'


    #Choix réponse menu
    print 'Quel est ton choix > '
    choice = gets.chomp
    if choice == 'a'
      user.search_weapon
    elsif choice == 'b'
      user.search_health_pack
    else
      user.attacks players[choice.to_i % players.size]
    end
    puts "Les autres joueurs attaquent !"
    players.select { |d| d.alive? }.each { |d| d.attacks(user) }
    puts 'Appuie sur entrée pour continuer'
    gets
  end
perform

#Fin du Jeu
  puts 'La partie est finie'
  if user.alive?
    puts 'BRAVO ! Tu as gagné la partie !'
  else
    puts 'Dommage ! Tu as perdu !'
  end
end
