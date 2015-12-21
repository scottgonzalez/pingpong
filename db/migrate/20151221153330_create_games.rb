class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :player1, index: true, foreign_key: true
      t.references :player2, index: true, foreign_key: true
      t.references :match, index: true, foreign_key: true
      t.integer :player1_score
      t.integer :player2_score

      t.timestamps null: false
    end
  end
end
