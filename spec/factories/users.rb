FactoryBot.define do
  factory :tester, class: User do
    sequence(:id) { |n| n }
    username { 'tester' }
    sequence(:email, 'tester1@example.com')
    password { 'foobar' }
    accepted { true }
    admin { true }
    confirmed_at { Date.today }

    after(:build) do |tester|
      tester.avatar.attach(io: File.open('spec/fixtures/images/test_image.png'), filename: 'test_image.png',
                           content_type: 'image/png')
    end

    after(:create) do |tester|
      create_list(:blog, 40, user: tester)
    end
  end

  factory :tester2, class: User do
    username { 'tester2' }
    sequence(:email, 'tester2@example.com')
    password { 'foobar' }
    accepted { true }
    admin { false }
    confirmed_at { Date.today }

    after(:create) do |tester|
      tester.avatar.attach(io: File.open('spec/fixtures/images/test_image.png'), filename: 'test_image.png',
                           content_type: 'image/png')
    end

    after(:create) do |tester2|
      create_list(:blog2, 2, user: tester2)
    end
  end
end
