require_relative 'player.rb'
require 'pry'

class Game
    def initialize(*args)
        @players = args
        @index = 0
        @fragment = ''
        @dictionary = {}
        @losses = Hash[@players.collect { |item| [item.name, 0] } ]
        File.readlines('dictionary.txt').each_with_index do |word, i|
            @dictionary.merge!({i => word.delete!("\n")})
        end
    end

    def run
        while @losses.has_value?(5) == false
            self.play_round
        end
    end

    def play_round
        self.take_turn(self.current_player)
        if @dictionary.has_value?(@fragment) == true
            @losses[self.previous_player.name] += 1
            @fragment = ''
        end
        self.next_player!
    end

    def current_player
        @players[@index]
    end

    def previous_player(player = @player2)
        @players[@index - 1]
    end

    def next_player!
        @index += 1
        if @index == @players.length
            @index = @index - @players.length
        end
    end

    def take_turn(player)
        input = player.guess
        if valid_play?(input) == false
            p "invalid play"
            self.take_turn(player)
        else
            @fragment += input
        end
    end

    def valid_play?(string)
        alphabet = ('a'..'z').to_a
        if alphabet.include?(string) == false
            p "Sorry, not a valid entry"
            return false
        end
        if @dictionary.values.none? {|v| v.include?(@fragment + string)}
            p "Sorry, combination will not result in real word"
            return false
        end
        return true
    end

    def getFragment
        @fragment
    end

    def getPlayers
        @players
    end

    def getLosses
        @losses
    end

end

# if $PROGRAM_NAME == __FILE__
#     p1 = Player.new('niggar')
#     p2 = Player.new('wiggar')
#     myGame = Game.new(p1, p2)
# end