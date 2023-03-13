class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.text :tags
      t.text :moves
      t.string :result
      t.integer :game_set_id

      t.timestamps
    end
  end
end
