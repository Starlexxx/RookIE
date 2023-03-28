class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.integer :user_id
      t.string :title
      t.integer :player_color
      t.text :description

      t.timestamps
    end
  end
end
