require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

system 'clear'

puts 
puts "\e[41m\e[1m Bienvenue sur 'THP The Game' !                       
 Le but du jeu est de survivre à ruby et ses bots !   \e[22m\e[0m"
puts
puts "\e[32m\e[1m ENTRE TON PSEUDO DE CODEUR FOU !\e[22m\e[0m"
print "> "
name = gets.chomp
puts "\e[32m\e[1m SUR COMBIEN DE CONCEPTS RUBY VEUX TU TAPER ? (entre 4 et 100) \e[22m\e[0m"
print "> "
number = gets.chomp.to_i
puts

puts "\e[32mCREATION DE LA GAME !\e[0m"
20.times do
    print "\e[42m \e[0m"
    sleep 0.15
end
30.times do
    print "\e[42m \e[0m"
    sleep 0.05
end
puts
puts "\e[32mCREATION TERMINÉ !\e[0m"
puts puts
print "\e[31m\e[1m\e[47m PRESS ENTER \e[0m\e[22m\e[0m"
            gets.chomp
system 'clear'

puts 
game1 = Game.new(name, number)
puts

game1.show_players
puts

puts "\e[41m\e[1m VOICI TON TERMINAL ! TU PEUX COMBATTRE \e[22m\e[0m"

while game1.is_still_ongoing?
        puts
        game1.menu
        puts
        print "> "
        choice = gets.chomp.to_i
        puts
        game1.menu_choice(choice)
        puts
        if game1.is_still_ongoing?
            print "ATTAQUE EN COURS "
            30.times do
                print  "\e[42m \e[0m"
                sleep 0.05
            end
            puts puts
            game1.enemies_attack
            puts
            if game1.players_left.length > 0
                game1.new_players_in_sight
            end
            puts
            print "\e[31m\e[1m\e[47m PRESS ENTER \e[0m\e[22m\e[0m"
            gets.chomp
            system 'clear'
            game1.show_players
        end
end

game1.end