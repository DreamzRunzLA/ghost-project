require_relative 'ghost.rb'

class Player
    def initialize(name)
        @name = name
    end

    def name
        @name
    end

    def guess
        p "input some shit"
        return gets.chomp
    end

    def alert_invalid_guess
    end

end