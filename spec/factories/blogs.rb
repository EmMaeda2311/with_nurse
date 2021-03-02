FactoryBot.define do
  factory :blog ,class: Blog do
    sequence(:title) {|n| "Test Title#{n}"}
    content { "MyText" }
    association :user, factory: :tester
  end


  factory :blog1 ,class: Blog do
    sequence(:title) {|n| "Test Title#{n}"}
    content { "MyText" }
    association :user, factory: :tester
  end

  factory :blog2 ,class: Blog do
    sequence(:title) {|n| "Test Title#{n}"}
    content { "MyText" }
    association :user, factory: :tester
  end

  factory :blog3 ,class: Blog do
    sequence(:title) {|n| "Test Title#{n}"}
    content { "MyText" }
    association :user, factory: :tester
  end

end
