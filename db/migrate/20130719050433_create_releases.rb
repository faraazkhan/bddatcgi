class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.string :fixversion
      t.integer :test_cases
      t.integer :covered_test_cases
      t.float :coverage
      t.date :snapshot_date

      t.timestamps
    end
  end
end
