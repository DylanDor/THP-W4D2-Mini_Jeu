require 'pry'

class Game
    attr_accessor :human_player, :players_left, :enemies_in_sight

    def initialize(player_name, number_of_enemies)
            @players_left = []
            @enemies_in_sight = []
            @human_player = HumanPlayer.new(player_name)
            number_of_enemies.times do |i|
                @players_left << Player.new("CONCEPT RUBY#{i}")
            end
            2.times do
                @enemies_in_sight << @players_left.pop
            end
    end

    def kill_player(player)
        @enemies_in_sight.delete(player)
    end

    def is_still_ongoing?
        return false if @players_left.length.zero? && @enemies_in_sight.length.zero?
    
        return false if @human_player.life_points <= 0
    
        true
    end

    def show_players
        puts "\e[41m\e[1m VOICI L'ETAT DE LA PARTIE \e[22m\e[0m"
        puts
        @human_player.show_state
        puts
        puts "\e[30m\e[47m NOMBRE DE CONCEPT EN VUE: #{@enemies_in_sight.length} \e[0m\e[0m" + "  " + "\e[30m\e[47m NOMBRE DE CONCEPT RESTANT DANS THP: #{@players_left.length} \e[0m\e[0m"
        puts
    end

    def menu
            puts "\e[1m Quelle action veux-tu effectuer ? \e[22m"
            puts
            puts "\e[1m Aider ton cerveau ou ton code \e[22m"
            puts
            puts "\e[30m\e[47m 1 \e[0m\e[0m" + " Lis la doc Ruby pour augmenter ta puissance de code"
            puts "\e[30m\e[47m 2 \e[0m\e[0m" + " Demande de l'aide sur le discord pour retrouver ta patience"
            puts 
            puts "\e[1m Attaquer un concept Ruby en vue \e[22m"
            puts
            i = 3
            @enemies_in_sight.each do |bot|
                puts "\e[30m\e[47m #{i} \e[0m\e[0m" + " Attaquer " + "\e[41m #{bot.name} \e[0m" + " qui a #{bot.life_points} lignes de code"
                i += 1
            end
    end

    def menu_choice(choice)
        case choice
        when 1 then @human_player.search_weapon
        when 2 then @human_player.search_health_pack
        else
            print "ATTAQUE EN COURS "
            30.times do
                print  "\e[42m \e[0m"
                sleep 0.05
            end
            puts puts
            puts  "\e[1mTu attaques\e[22m"
            @human_player.attack(@enemies_in_sight[choice - 3])
            kill_player(@enemies_in_sight[choice - 3]) if @enemies_in_sight[choice - 3].life_points <= 0
        end
    end

    def enemies_attack
        puts  "\e[1mIls attaquent\e[22m"
        @enemies_in_sight.each do |enemy|
            if @human_player.life_points > 0
                enemy.attack(@human_player)
            end
        end
    end

    def end
        if @human_player.life_points > 0
            puts puts
            puts "La partie est finie"
            puts "BRAVO ! TU AS GAGNE !"
        else
            puts puts
            puts "La partie est finie"
            puts "Loser ! Tu as perdu !"
        end
    end

    def new_players_in_sight
        dice = rand(1..6)
        puts  "\e[1mTu observes autour de toi\e[22m"
        case dice
        when 1
            puts "\e[42m OUF ! \e[0m" + " Aucun concept Ruby en vue"
        when 2..4
            puts "\e[30m\e[43m AIE ! \e[0m\e[0m" + " Un nouveau concept Ruby en approche"
            @enemies_in_sight << @players_left.pop
        when 5..6
            puts "\e[41m ATTENTTION ! \e[0m" + " Deux nouveaux concepts Ruby arrivent"
            @enemies_in_sight << @players_left.pop
            @enemies_in_sight << @players_left.pop unless @players_left.length.zero?
        end
    end
end