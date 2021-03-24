FactoryBot.define do
  factory :blog ,class: Blog do
    # sequence(:title) {|n| "Test Title#{n}"}
    title {"Test Title 0"}
    content { "MyText" }
    association :user, factory: :tester
  end


  factory :blog1 ,class: Blog do
    sequence(:title) {|n| "Test Title#{n}"}
    content { "MyText" }
    association :user, factory: :tester
    
  end

  factory :blog2 ,class: Blog do
    # sequence(:title) {|n| "Test Title#{n}"}
    title {"Test Title 2"}
    content { "MyText" }
    association :user, factory: :tester2
  end

  factory :blog3 ,class: Blog do
    sequence(:title) {|n| "Test Title#{n}"}
    content { "MyText" }
    association :user, factory: :tester
  end

end
