require 'pry'

class Player
    
    attr_accessor :life_points, :name

    def initialize(name_to_save)
        @name = name_to_save
        @life_points = 10
    end

    def show_state
        if @life_points > 0
            puts "#{@name} a #{@life_points} PDV !"
        else
            puts "#{@name} EST MORT !"
        end
    end

    def gets_damages(damages)
        @life_points -= damages
    end

    def attack(player)
        dice = compute_damage
        player.gets_damages(dice)
        puts "#{self.name} inflige #{dice} points de dommages"
    end

    def compute_damage
        rand(0..6)
      end
end

class HumanPlayer < Player
    attr_accessor :weapon_level, :life_points, :name

    def initialize(name_to_save)
        @weapon_level = 1

        super(name_to_save)
        @life_points = 100
    end

    def show_state
        if @life_points > 0
            puts "\e[42m\e[1m #{@name} \e[22m\e[0m" + "  " + "\e[30m\e[42m PATIENCE: #{@life_points} \e[0m\e[0m" + "  " + "\e[30m\e[42m WEAPON LV: #{weapon_level} \e[0m\e[0m"
        else
            puts "\e[41m\e[1m #{@name} EST MORT ! \e[22m\e[0m"
        end
    end

    def compute_damage
        (rand(1..6) * @weapon_level)
    end

    def search_weapon
        level = rand(1..6)
        print "LECTURE DE LA DOC "
        30.times do
            print  "\e[42m \e[0m"
            sleep 0.1
        end
        puts puts
        puts "C'est de la doc LV: #{level}"
        if level > @weapon_level
            @weapon_level = level
            puts "Youhou ! Ton niveau en code augmente"
        else
            puts "M@*#$... C'EST DE LA MERDE CETTE DOC"
        end
    end

    def search_health_pack
        search = rand(1..6)
        print "ECRITURE DU MESSAGE DISCORD "
        30.times do
            print  "\e[42m \e[0m"
            sleep 0.1
        end
        puts puts
        if search == 1
            puts "\e[41m C'EST LE FLOP ! \e[0m" + "Personne ne veut t'aider !"
        elsif search == 2 || 3 || 4 || 5
            puts "\e[30m\e[43m SUPER ! \e[0m\e[0m" + "Entre deux sceances de step Maëva t'aide ! PATIENCE: +50 !"
            if @life_points + 50 > 100
                @life_points = 100
            else
                @life_points += 50
            end
        elsif search == 6
            puts "\e[42m INCOYABLE ! \e[0m" + " Boris arrive et regle le problème en 2 secondes ! PATIENCE: +80 !"
            if @life_points + 80 > 100
                @life_points = 100
            else
                @life_points += 80
            end
        end

    end
end