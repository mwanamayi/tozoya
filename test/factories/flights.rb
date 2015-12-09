# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :flight do
    content "MyText"
    user nil
    picture "MyString"
    public false
    departure "MyString"
    destination "MyString"
    date "2015-12-08 21:49:03"
  end
end
