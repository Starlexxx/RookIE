# frozen_string_literal: true

class Stage < ApplicationRecord
  TYPES = %w[Video Study Drill].freeze

  enum :stage_type, %i[video study drill]

  belongs_to :chapter
end
