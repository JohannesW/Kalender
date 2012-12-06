# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    dtstart "2012-12-06 13:35:47"
    dtend "2012-12-06 13:35:47"
    summary "MyString"
    description "MyText"
    uid 1
  end
end
