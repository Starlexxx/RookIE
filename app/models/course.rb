# frozen_string_literal: true

class Course < ApplicationRecord
  enum :player_color, %i[white black]

  after_create_commit :save_pgn
  after_create_commit :link_game_set

  belongs_to :user

  has_one :game_set
  has_many :chapters, dependent: :delete_all

  has_one_attached :video
  has_one_attached :thumbnail
  has_one_attached :pgn

  validates_associated :game_set

  validates :title, presence: true, uniqueness: true
  validates :video, attached: true, content_type: 'video/mp4'
  validates :thumbnail, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
  validates :pgn, attached: true, content_type: 'application/x-chess-pgn'

  private

  def link_game_set
    GameSet.create!(pgn_path: pgn_path, course_id: id)
  end

  def pgn_path
    @pgn_path = Rails.root.join('uploads', "#{title}.pgn")
  end

  def save_pgn
    pgn.open do |blob|
      File.open(pgn_path, 'w') do |file|
        file.write(blob.read)
      end
    end
  end
end
