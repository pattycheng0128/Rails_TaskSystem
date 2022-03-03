FactoryBot.define do

  factory :task do
    name {Faker::Name.unique.name}
    content { Faker::Company.logo }
    end_time { Faker::Date.between(from: Date.today, to: 1.year.from_now) } # 要大於目前的時間
  end

end