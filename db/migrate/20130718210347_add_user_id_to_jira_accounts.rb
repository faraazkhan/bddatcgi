class AddUserIdToJiraAccounts < ActiveRecord::Migration
  def change
    add_column :jira_accounts, :user_id, :integer
  end
end
