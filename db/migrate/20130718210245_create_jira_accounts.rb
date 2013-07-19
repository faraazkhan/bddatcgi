class CreateJiraAccounts < ActiveRecord::Migration
  def change
    create_table :jira_accounts do |t|
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
