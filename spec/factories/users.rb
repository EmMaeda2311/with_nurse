FactoryBot.define do
  factory :tester , class: User do
        username { username }
        email { email }
  end
  
  
  # factory :duplicate_user, class: User do
  #       username { :tester.username }
  #       email{ :tester.username }
  # end
#   factory :invalid_user do
#     name ""
#   end
end

#これをひな形に複数のフィクスチャーをcreateできるかな