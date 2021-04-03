class AddIndexWord < ActiveRecord::Migration[6.0]
  def change
    add_index :words,  :name, unique: true
  end
end
