require 'csv'

CSV.foreach('db/csv/words.csv', headers: true) do |row|
  Word.create(
    name: row['name'],
    read: row['read'],
    spell: row['spell'],
    spell_confirmation: row['spell_confirmation']
  )
end
