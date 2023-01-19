class CreateChapters < ActiveRecord::Migration[7.0]
  def change
    create_table :chapters do |t|
      t.string :title
      t.integer :course_id

      t.timestamps
    end
  end
end
