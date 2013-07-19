require 'jira'
class JiraAccount < ActiveRecord::Base
  attr_accessible :password, :username
  belongs_to :user
  validates_uniqueness_of :username, :scope => [:user_id]
  validates_presence_of :password
  validates_presence_of :username
  validates :password, :with => :jira_credentials

  def jira
    @jira ||= JIRA::Client.new(credentials)
  end

  def credentials
     {
      :username => self.username,
      :password => self.password, 
      :site => "https://www.cws-cgicloud-apps.com:8443",
      :context_path => '',
      :auth_type => :basic

    }
  end

  def find_story_by(issuekey)
    @issue ||= jira.Issue.find(issuekey) rescue nil

  end

  def test_cases_for(issuekey)
    issue =  find_story_by(issuekey)
    if issue
      test_cases = issue.issuelinks.select { |i| i["type"]["name"] == "Test Case" }
      test_cases.collect {|t| t["inwardIssue"]["key"] }
    else
      raise "No Test Cases Found"
    end
  end

  def feature_file_for(issuekey)
    string = ''
    test_cases_for(issuekey).each do |test_case_id|
      tc = jira.Issue.find(test_case_id)  rescue nil
      if tc
        string << <<-STRING
        #{tc.summary} \n
        #{tc.description}\n\n
        STRING
      end
    end
    string
  end

  def jira_credentials
    jira.Issuetype.all rescue errors[:username] << "Invalid username and /or password"
  end
end
