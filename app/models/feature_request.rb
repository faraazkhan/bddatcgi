class FeatureRequest
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::Naming
  validates_presence_of :issuekey
  validates_format_of :issuekey, :with => /^(.*)-[0-9]*$/i, :message => 'enter a valid JIRA Issue Key ex: PHC-645'

  attr_accessor :issuekey

  def initialize(attributes ={})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def options
    {
      :site => JiraAccount::URL,
      :context_path => '/',
      :auth_type => :basic
    }
  end
end
