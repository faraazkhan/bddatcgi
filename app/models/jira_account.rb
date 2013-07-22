require 'jira'
class JiraAccount < ActiveRecord::Base
  attr_accessible :password, :username
  belongs_to :user
  validates_uniqueness_of :username, :scope => [:user_id]
  validates_presence_of :password
  validates_presence_of :username
  validates :password, :with => :jira_credentials
  URL= 'https://www.cws-cgicloud-apps.com:8443'

  def jira
    @jira ||= JIRA::Client.new(credentials)
  end

  def credentials
     {
      :username => self.username,
      :password => self.password, 
      :site => URL,
      :context_path => '',
      :auth_type => :basic

    }
  end

  def find_story_by(issuekey)
    if jira_credentials
      begin
        @issue ||= jira.Issue.find(issuekey) 
      rescue
        raise "Issue Not Found. Please enter a valid JIRA ID"
      end
    end

  end

  def test_cases_for(story)
    if story
        @test_cases ||= story.issuelinks.select { |i| i["type"]["name"] == "Test Case" }
        @tests ||= @test_cases.collect {|t| t["inwardIssue"]["key"] }
    else
      raise "User Story Not Found. Please enter a valid JIRA ID"
    end
  end

  def feature_file_for(issuekey)
    string = ''
    issuetitle = issuekey
    if story = find_story_by(issuekey)
      raise 'No test cases were related to the Issue ID provided' unless test_cases_for(story).any?
      string << <<-STORY
      Feature: #{issuetitle} \n
      #{story.description} \n
      #{story.customfield_10116} \n \n \n
      STORY
      test_cases_for(story).each do |test_case_id|
        tc = jira.Issue.find(test_case_id)  rescue nil
        if tc
          string << <<-STRING
          #{tc.summary} \n
          #{tc.description}\n\n
          STRING
        end
      end
    end
    return string,friendly_filename(story.summary)
  end


  def jira_credentials
    jira.Issuetype.all rescue raise "Invalid username and /or password. If you think you have the right credentials, log out and log back into your JIRA web account"
  end

  def friendly_filename(filename)
      filename.gsub(/[^\w\s_-]+/, '')
              .gsub(/(^|\b\s)\s+($|\s?\b)/, '\\1\\2')
              .gsub(/\s+/, '_')
  end
  

end 
