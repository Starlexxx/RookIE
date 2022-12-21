class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.text :tags
      t.text :moves
      t.string :result
      t.references :game_set

      t.timestamps
    end
  end
end
