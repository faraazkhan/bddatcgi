class FeatureRequestsController < ApplicationController
  before_filter :load_user
  before_filter :load_jira_account
  load_and_authorize_resource

  def create
    @feature_request = FeatureRequest.new(params[:feature_request])
    if @feature_request.valid?
      begin
        file = @jira_account.feature_file_for(@feature_request.issuekey)
        send_data file, :filename => "#{@feature_request.issuekey}.txt", :type=>"text/plain", :x_sendfile=>true
        flash[:notice] = "Your file has been succesfully downloaded"
      rescue
        redirect_to new_user_jira_account_feature_request_path(@user, @jira_account)
        flash[:error] = "No Test Cases were found. Please make sure you are entering the Issue Key for a User Story that has linked Test Cases in JIRA"
      end
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
