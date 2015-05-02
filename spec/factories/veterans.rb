FactoryGirl.define do
  factory :veteran, aliases: [:person] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    # name_suffix_id { 1 }
    middle_name { Faker::Name.name }
    email { Faker::Internet.email }
    work_email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    cell_phone { Faker::PhoneNumber.phone_number }
    work_phone { Faker::PhoneNumber.phone_number }
    birth_date { Faker::Date.birthday(48, 91) }
    type "Veteran"
  end
end
