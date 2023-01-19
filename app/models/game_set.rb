class GameSet < ApplicationRecord
  attr_reader :pgn_games

  has_many :games

  belongs_to :course

  after_create :build_games

  def parsed_games
    @parsed_games ||= PGN.parse(File.read(pgn_path))
  end

  def build_games
    @pgn_games = []
    parsed_games.each do |game|
      @pgn_games << Game.create!(
        game_set_id: id,
        moves: game.moves,
        tags: game.tags,
        result: game.result
      )
    end
  end
end
