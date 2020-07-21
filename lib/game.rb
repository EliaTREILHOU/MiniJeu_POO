class Game
  attr_accessor :human_player, :players_left, :enemies, :round

# human_name  = Nom du joueur humain
# nb_enemies = Nombre total d'ennemis

  def initialize(human_name, nb_ennemies = 10)
    @human_player = HumanPlayer.new(human_name)
    @players_left = nb_ennemies.times.map { |n| Player.new("bot_#{n}") }
    @enemies_in_sight = []
    @round = 1
  end

#Le Bot a été tué

  def kill_player(player)
    @enemies.delete(player)
  end

#Je teste si le jeu continue
#Si joueur humain et au moins un bot sont en vie je continue le jeu !

  def is_still_ongoing?
    @human_player.alive? && (!@enemies.empty? || !@players_left.empty?)
  end


  # Check si un ennemi est en attente sinon continue !
  def new_players_in_sight
    if @players_left.empty?
      puts "Pas d'autre ennemi en attente"
      return
    end
    puts 'ATTENTION !'
    dés = rand(1..6) #choix entre les face du dés entre 1 et 6
    if dés == 1
      puts 'Génial ! Pas de nouvel ennemi en vu!'
    elsif dès <= 4 || @players_left.size == 1
      @enemies << @players_left.pop
      puts 'Attention ! Un nouvel ennemi apparait !'
    else # Le dés tombe sur 5 ou 6
      @enemies << @players_left.pop
      @enemies << @players_left.pop
      puts 'Anttion ! Deux nouveaux ennemis vont apparaitre !'
    end
    puts
  end

  # Afficher l'état du joueur humain et le résumé des bots.
  def show_players
    puts '+-Etat--------------------------------------------------------------------------'
    puts '| ' + @human_player.get_state
    puts "| Il y a #{@enemies.size} ennemis en approche, et #{@players_left.size} en attente"
    puts '+--------------------------------------------------------------------------------------'
  end

  # Le menu en jeu
  def show_menu
    puts '+---------------------------------------------------------------------------------------'
    puts "| Niveau : #{@round}"
    puts '|'
    puts '| Quelle action veux-tu effectuer ?'
    puts '|> a - Chercher une meilleure arme'
    puts '|> b - Chercher à se soigner'
    puts '|'
    puts '| Attaquer :'
    @enemies.each_with_index { |player, index| puts "|> #{index} - #{player.get_state}" }
    puts '+---------------------------------------------------------------------------------------'
  end

#J'ai utiliser 'user_choice' pour le choix de l'user, depuis le menu #show_menu
  def menu_choice(user_choice)
    @round += 1
    if user_choice == 'a'
      @human_player.search_weapon
    elsif user_choice == 'b'
      @human_player.search_health_pack
    else
      enemy = @enemies[user_choice.to_i % @enemies.size]
      @human_player.attacks enemy
      kill_player(enemy) if enemy.dead?
    end
    puts '-'
  end

  #Bot vs Humain
  def enemies_attack
    @enemies.each {|enemy| enemy.attacks(@human_player)}
    puts '-'
  end

  def end
    puts 'Fin de la Partie'
    if @human_player.alive?
      puts 'BRAVO ! Tu as Gagné !!'
    else
      puts 'Dommage ! Tu as perdu la partie !'
    end
  end
end
