FactoryBot.define do
  factory :user_typing do
    hi_score { 1.5 }
    hi_speed { 1.5 }
    plays { 1 }
    user { nil }
  end
end
