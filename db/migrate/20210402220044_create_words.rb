class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.string :name, null: false, default: ''
      t.string :read, null: false, default: ''
      t.string :spell, null: false, default: ''
      t.string :spell_confirmation, null: false, default: ''
      t.string :abbreviation

      t.timestamps
    end
  end
end
