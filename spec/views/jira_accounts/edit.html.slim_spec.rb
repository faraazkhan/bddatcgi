require 'spec_helper'

describe "jira_accounts/edit" do
  before(:each) do
    @jira_account = assign(:jira_account, build_stubbed(:jira_account))
  end

  it "renders the edit jira_account form" do
    render

    assert_select "form", action: jira_accounts_path(@jira_account), method: "post" do
      assert_select "input#jira_account_username", name: "jira_account[username]"
      assert_select "input#jira_account_password", name: "jira_account[password]"
    end
  end
end
