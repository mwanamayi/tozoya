# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :request do
    content "MyText"
    picture "MyString"
    public false
    departure "MyString"
    destination "MyString"
    date "2015-12-20 18:48:27"
    latitude 1.5
    longitude 1.5
    references ""
  end
end
