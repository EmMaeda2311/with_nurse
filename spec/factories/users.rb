FactoryBot.define do
  factory :tester , class: User do
        # sequence(:id, 1)
        username { "tester" }
        sequence(:email,"tester1@example.com") 
        # { |n| "#{n}tester@example.com" }
        password { "foobar" }
        accepted {true}
        confirmed_at { Date.today }
  end
  
  
  factory :another_tester , class: User do
        username{ "teser2" }
        sequence(:email,"tester1@example.com") 
        # { |n| "#{n}tester@example.com" }
        password { "foobar" }
        accepted {true}
        confirmed_at { Date.today }
  end
  
end