require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

player1 = Player.new("Yannou-la-fripouille")
player2 = Player.new("Maeva et pipitou")

puts "Voici l'état de chaque joueur :"
player1.show_state
player2.show_state

puts "Passons à la phase d'attaque :"

while player1.life_points > 0 && player2.life_points > 0
    if player1.life_points > 0
    puts
    player1.attack(player2)
    end
    if player2.life_points > 0
    puts
    player2.attack(player1)
    end
end
