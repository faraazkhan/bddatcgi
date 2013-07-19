# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :release do
    fixversion "MyString"
    test_cases 1
    covered_test_cases 1
    coverage 1.5
    snapshot_date "2013-07-19"
  end
end
