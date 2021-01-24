FactoryBot.define do
  factory :tester , class: User do
        username { "tester" }
        email { "tester@example.com" }
        password { "foobar" }
  end
end