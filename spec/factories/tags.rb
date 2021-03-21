FactoryBot.define do
  factory :tag1 ,class:Tag do
    name { "tag1" }
  end
  
  factory :tag2 ,class:Tag do
    name { "tag2" }
  end

  factory :tag3 ,class:Tag do
    name{ "　" }
  end

  factory :tag4 ,class:Tag do
    name{ " " }
  end




end
