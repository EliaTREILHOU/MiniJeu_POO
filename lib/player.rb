class Player
  attr_accessor :name, :life_points

# name  = Nom du Joueur
# life_points = Point de vie de début (vie = 10)

  def initialize(name, life_points = 10)
    @name = name
    @life_points = life_points
  end

#Si le joueur est en vie (points de vie > 0)
  def alive?
    @life_points > 0
  end

#Si le Joueur est mort (Point de vie < 0)
  def dead?
    !alive?
  end

#Etat du joueur
  def get_state
    "#{@name} a #{@life_points} points de vie"
  end

# Resultat sur le terminal des statistiques du joueur avec #get_state
  def show_state
    puts get_state
  end

  def gets_damage(points)
    if points >= @life_points
      @life_points = 0
      puts "Le joueur #{@name} a été tué !"
    else
      @life_points -= points #-1 PV
    end
    @life_points #point de vie restant
  end

  def attacks(other_player)
    print "Le joueur #{@name} attaque #{other_player.name}... "
    points = compute_damage
    puts "et lui inflige #{points} points de dommage"
    other_player.gets_damage(points)
  end


  def compute_damage
    rand(1..6) #choisi entre 1 et 6 
  end

  def to_s
    "Player #{@name} [#{@life_points}]"
  end
end

# Le joueur humain a + de PV par défaut et peut avoir une arme spéciale.
class HumanPlayer < Player
  attr_accessor :weapon_level

# name  = Nom du Joueur
# life_points = Point de vie de début (vie = 100)
  def initialize(name, life_points = 100, weapon_level = 1)
    @weapon_level = weapon_level
    super(name, life_points)
  end

#choisi entre 1 et 6
  def compute_damage
    rand(1..6) * @weapon_level
  end

#Etat du joueur
  def get_state
    "#{@name} a #{@life_points} PV et une arme de niveau #{@weapon_level}"
  end

#Recherche la meilleure arme et garde la meilleure de l'actuelle
  def search_weapon
    level = rand(1..6)
    print "Tu as trouvé une arme de niveau #{level} !"
    if level > @weapon_level
      @weapon_level = level
      puts 'Génial cette armes est meilleure que ton arme actuelle : tu la prends.'
    else
      puts "Elle n'est pas mieux que ton arme actuelle... repose là !"
    end
  end

  # recherche de pack de soin pour rétablir les PV manquant
  def search_health_pack
    dés = rand(1..6) #prend entre 1 et 6
    if dés == 1
      puts "Tu n'as rien trouvé ici"
    elsif dés <= 5 
      puts 'Tu as trouvé un pack de +50 de PV'
      @life_points = [100, @life_points + 50].min
    else 
      puts 'Super, tu as trouvé un pack de +80 PV !'
      @life_points = [100, @life_points + 80].min
    end
  end
end
