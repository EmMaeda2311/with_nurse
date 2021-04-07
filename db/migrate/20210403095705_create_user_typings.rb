class CreateUserTypings < ActiveRecord::Migration[6.0]
  def change
    create_table :user_typings do |t|
      t.float :hi_score, default: 0
      t.float :hi_speed, default: 0
      t.integer :plays, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
