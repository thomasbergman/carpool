FactoryGirl.define do
  factory :user do
    email					"jan@banan.se"
    first_name    "Jan"
    last_name			"Banan"
    password 			"123456"
    password_confirmation "123456"
  end
end