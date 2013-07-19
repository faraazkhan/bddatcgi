class Release < ActiveRecord::Base
  attr_accessible :coverage, :covered_test_cases, :fixversion, :snapshot_date, :test_cases
end
