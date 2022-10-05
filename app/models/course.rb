class Course < ApplicationRecord
  has_one :game_set
  has_many :chapters, dependent: :delete_all

  has_one_attached :video
end
