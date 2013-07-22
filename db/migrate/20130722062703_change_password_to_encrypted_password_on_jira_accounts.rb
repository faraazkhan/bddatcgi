class ChangePasswordToEncryptedPasswordOnJiraAccounts < ActiveRecord::Migration
  def change
    rename_column :jira_accounts, :password, :encrypted_password
  end

end
