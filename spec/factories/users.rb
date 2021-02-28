FactoryBot.define do
  factory :tester , class: User do
        id {1}
      #   sequence(:id){ |n| n }
        username { "tester" }
        sequence(:email,"tester1@example.com") 
        # { |n| "#{n}tester@example.com" }
        password { "foobar" }
        accepted {true}
        confirmed_at { Date.today }
  end
  
  
  factory :another_tester , class: User do
      #   sequence(:id){ |n| n }
        id{2}
        username{ "teser2" }
        sequence(:email,"tester2@example.com") 
        # { |n| "#{n}tester@example.com" }
        password { "foobar" }
        accepted {true}
        confirmed_at { Date.today }
  end
  
end