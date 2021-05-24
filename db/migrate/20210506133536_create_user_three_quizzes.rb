class CreateUserThreeQuizzes < ActiveRecord::Migration[6.0]
  def change
    create_table :user_three_quizzes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :word, null: false, foreign_key: true
      t.integer :memory

      t.timestamps
    end
    add_index :user_three_quizzes, %i[user_id word_id],unique: true
  end
end
