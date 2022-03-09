FactoryBot.define do

  factory :user do
    email {Faker::Internet.email}
    password {Faker::Config.random}
    password_confirmation {password}
  end

  factory :task do
    name {Faker::Name.unique.name}
    content { Faker::Company.logo }
    end_time { "2022-08-08" } # 要大於目前的時間
    user
  end

end