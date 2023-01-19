# frozen_string_literal: true

class CreateStages < ActiveRecord::Migration[7.0]
  def change
    create_table :stages do |t|
      t.string :title
      t.integer :stage_type
      t.integer :game_number
      t.integer :chapter_id

      t.timestamps
    end
  end
end
