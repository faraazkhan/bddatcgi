class FeatureRequestsController < ApplicationController
  before_filter :load_user
  before_filter :load_jira_account
  load_and_authorize_resource

  def create
    @feature_request = FeatureRequest.new(params[:feature_request])
    if @feature_request.valid?
      file = @jira_account.feature_file_for(@feature_request.issuekey)
      send_data file, :filename => "#{@feature_request.issuekey}.txt", :type=>"text/plain", :x_sendfile=>true
      flash[:notice] = "Status Message"
    else
      render action: 'new'
    end
  end

  def new
    @feature_request = FeatureRequest.new
  end

  private
  def load_jira_account 
    @jira_account= JiraAccount.find_by_id params[:jira_account_id]
  end
end
