require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'


puts "------------------------------------------------
|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
|Le but du jeu est d'être le dernier survivant !|
-------------------------------------------------"

puts "Ton prénom ?"
print ">"
name = gets.chomp
player1 = HumanPlayer.new("#{name} le nul")

player2 = Player.new("Yannou-la-fripouille")
player3 = Player.new("Maeva et pipitou")
enemies = [player2, player3]


puts "Voici l'état de chaque joueur :"
puts
print "> "
player1.show_state
print "> "
player2.show_state
print "> "
player3.show_state

puts "Passons à la phase d'attaque :"

while player1.life_points > 0 && (player2.life_points > 0 || player3.life_points > 0) 
    puts
    player1.show_state
    
    puts "Quelle action veux-tu effectuer ?

    1 - chercher une meilleure arme
    2 - chercher à se soigner 
    
    attaquer un joueur en vue :
    3 - #{player2.name} avec #{player2.life_points}
    4 - #{player3.name} avec #{player3.life_points}"
    input = gets.chomp

    if input == "1"
        player1.search_weapon
    elsif input == "2"
        player1.search_health_pack
    elsif input == "3"
        player1.attack(player2)
    elsif input == "4"
        player1.attack(player3)
    end

    sleep 1
    puts "Les autres joueurs t'attaquent !"

    enemies.each do |bot|
        if bot.life_points > 0
            bot.attack(player1)
            sleep 0.5
        end
    end
end

puts "La partie est finie"

if player1.life_points > 0
    puts "BRAVO ! TU AS GAGNE !"
else
    puts "Loser ! Tu as perdu !"
end