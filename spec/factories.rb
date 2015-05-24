FactoryGirl.define do
  factory :user do
    first_name "First"
    last_name "Last"
    sequence(:email) { |n| "user#{n}@apple.com" }
    password "rocket"
    password_confirmation "rocket"
  end
end