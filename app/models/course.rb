class Course < ApplicationRecord
  enum :player_color, %i[white black]

  after_create_commit :link_game_set

  has_one :game_set
  has_many :chapters, dependent: :delete_all

  has_one_attached :video
  has_one_attached :pgn

  private

  def link_game_set
    GameSet.create!(pgn_path: pgn_path, course_id: id)
  end

  def pgn_path
    path = Rails.root.join('uploads', "#{title}.pgn")

    pgn.open do |blob|
      File.open(path, 'w') do |file|
        file.write(blob.read)
      end
    end

    path
  end
end
