require 'spec_helper'

describe "jira_accounts/new" do
  before(:each) do
    assign(:jira_account, build_stubbed(:jira_account))
  end

  it "renders new jira_account form" do
    render

    assert_select "form", action: jira_accounts_path, method: "post" do
      assert_select "input#jira_account_username", name: "jira_account[username]"
      assert_select "input#jira_account_password", name: "jira_account[password]"
    end
  end
end
