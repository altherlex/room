FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "john#{n}@doe.com" }
    password "password"
    password_confirmation "password"
  end
  factory :reserve do
    sequence(:id){|n| n+1000}
    date "2014-03-04 14:00:00"
    user_id FactoryGirl.create(:user).id
  end  
end
