class Game < ApplicationRecord
  serialize :tags, Hash
  serialize :moves, Array

  attr_reader :pgn_game

  belongs_to :game_set

  def pgn_game
    @pgn_game ||= PGN::Game.new(moves, tags, result)
  end

  def positions
    pgn_game.positions
  end
end
