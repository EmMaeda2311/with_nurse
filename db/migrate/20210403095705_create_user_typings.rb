class CreateUserTypings < ActiveRecord::Migration[6.0]
  def change
    create_table :user_typings do |t|
      t.float :hi_score
      t.float :hi_speed
      t.integer :plays
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
