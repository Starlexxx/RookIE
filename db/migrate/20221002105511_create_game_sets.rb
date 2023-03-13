class CreateGameSets < ActiveRecord::Migration[7.0]
  def change
    create_table :game_sets do |t|
      t.string :pgn_path
      t.integer :course_id

      t.timestamps
    end
  end
end
