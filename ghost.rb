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

    end


end