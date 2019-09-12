require_relative 'player.rb'
require 'pry'

class Game
    def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
        @fragment = ''
        @dictionary = {}
        File.readlines('dictionary.txt').each_with_index do |word, i|
            @dictionary.merge!({i => word.delete!("\n")})
        end
    end

    def self.play_round
        self.take_turn(self.current_player)
        self.next_player!
    end

    def self.current_player
        @player1
    end

    def self.previous_player
        @player2
    end

    def self.next_player!
        temp = self.current_player
        self.current_player = self.previous_player
        self.previous_player = temp
    end

    def self.take_turn(player)
        input = gets.chomp
        if valid_play?(input) == false
            p "invalid play"
            self.take_turn(player)
        else
            @fragment += input
            return @fragment
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

end