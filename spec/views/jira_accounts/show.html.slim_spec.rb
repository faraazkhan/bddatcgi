require 'spec_helper'

describe "jira_accounts/show" do
  before(:each) do
    @jira_account = assign(:jira_account, build_stubbed(:jira_account))
  end

  it "renders attributes" do
    render

    expect(rendered).to match(/Username/)
    expect(rendered).to match(/Password/)
  end
end
