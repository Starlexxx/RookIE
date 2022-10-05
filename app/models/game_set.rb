class GameSet < ApplicationRecord
  attr_reader :games, :pgn_games

  has_many :games

  belongs_to :course

  def games
    @games ||= PGN.parse(File.read(pgn_path))
  end

  def build_games
    @pgn_games = []
    games.each do |game|
      @pgn_games << Game.create!(
        game_set: self,
        moves: game.moves,
        tags: game.tags,
        result: game.result,
      )
    end
  end
end
