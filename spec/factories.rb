FactoryBot.define do

  factory :task do
    name {Faker::Name.unique.name}
    content { Faker::Company.logo }
  end

end