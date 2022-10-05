class Chapter < ApplicationRecord
  has_many :stages
  # has_many_attached :videos
  # has_many :videos
  # has_many :lessons
  # has_many :drills

  belongs_to :course
end
