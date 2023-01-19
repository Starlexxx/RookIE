# frozen_string_literal: true

class Stage < ApplicationRecord
  enum :stage_type, %i[video study drill]

  belongs_to :chapter

  has_one_attached :video

  def pgn
    path = Rails.root.join('uploads', "#{chapter.course.title}.pgn")

    File.read(path)
  end

  def course
    chapter.course
  end
end
