require 'spec_helper'

describe "jira_accounts/index" do
  before(:each) do
    assign(:jira_accounts, [
      build_stubbed(:jira_account,
        username: "Username",
        password: "Password"
      ),
      build_stubbed(:jira_account,
        username: "Username",
        password: "Password"
      )
    ])
  end

  it "renders a list of jira_accounts" do
    render

    assert_select "tr>td", text: "Username".to_s, count: 2
    assert_select "tr>td", text: "Password".to_s, count: 2
  end
end
