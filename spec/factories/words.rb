FactoryBot.define do
  factory :word do
    name { 'テスト' }
    read { 'てすと' }
    spell { 'tesuto' }
    spell_confirmation { 'tesuto' }
  end
end
