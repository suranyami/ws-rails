# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :status do
    job_id 1
    state "MyString"
    status_time "2014-05-05 22:33:27"
    notes "MyText"
  end
end
