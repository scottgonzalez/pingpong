class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :player1, index: true, foreign_key: true
      t.references :player2, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
