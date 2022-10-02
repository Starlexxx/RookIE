class CreateChessBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :chess_boards do |t|

      t.timestamps
    end
  end
end
