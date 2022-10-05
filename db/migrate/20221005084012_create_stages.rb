class CreateStages < ActiveRecord::Migration[7.0]
  def change
    create_table :stages do |t|
      t.string :title
      t.references :chapter, index: true, foreign_key: true

      t.timestamps
    end
  end
end
