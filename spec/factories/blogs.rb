FactoryBot.define do
  factory :blog do
    title { "Test Title"}
    content { "MyText" }
    association :user, factory: :tester
    #ここはuserモデルのidとblogモデルのuser_idを連携させたい。引数がわからん
    user_id{1}
  end
end
