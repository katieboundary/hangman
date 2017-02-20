class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :word, null: false
      t.string :guesses, default: "", null: false

      t.integer :game_status, default: 1, null: false
      t.integer :wrong_guesses, default: 0, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
