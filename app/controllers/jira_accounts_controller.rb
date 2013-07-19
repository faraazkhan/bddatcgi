class JiraAccountsController < ApplicationController

  load_and_authorize_resource
  before_filter :load_user

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @jira_account = @user.jira_accounts.build(params[:jira_account])
    if @jira_account.save
      redirect_to user_jira_account_path(@user, @jira_account), notice: 'Jira account was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @jira_account.update_attributes(params[:jira_account])
      redirect_to user_jira_account_path(@user, @jira_account), notice: 'Jira account was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @jira_account.destroy
    redirect_to user_jira_accounts_url
  end


 
end
