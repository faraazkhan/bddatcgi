require 'spec_helper'

describe JiraAccountsController do

  # This should return the minimal set of attributes required to create a valid
  # JiraAccount. As you add validations to JiraAccount, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    attributes_for :jira_account
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # JiraAccountsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  before do
    # TODO Set to :user and specify authorization rules in Ability.rb.
    login_user build :admin
  end

  describe "#index" do
    it "assigns all jira_accounts as @jira_accounts" do
      jira_account = JiraAccount.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:jira_accounts)).to eq([jira_account])
    end
  end

  describe "#show" do
    it "assigns the requested jira_account as @jira_account" do
      jira_account = JiraAccount.create! valid_attributes
      get :show, { :id => jira_account.to_param }, valid_session
      expect(assigns(:jira_account)).to eq(jira_account)
    end
  end

  describe "#new" do
    it "assigns a new jira_account as @jira_account" do
      get :new, {}, valid_session
      expect(assigns(:jira_account)).to be_a_new(JiraAccount)
    end
  end

  describe "#edit" do
    it "assigns the requested jira_account as @jira_account" do
      jira_account = JiraAccount.create! valid_attributes
      get :edit, { :id => jira_account.to_param }, valid_session
      expect(assigns(:jira_account)).to eq(jira_account)
    end
  end

  describe "#create" do
    describe "with valid params" do
      it "creates a new JiraAccount" do
        expect {
          post :create, { :jira_account => valid_attributes }, valid_session
        }.to change(JiraAccount, :count).by(1)
      end

      it "assigns a newly created jira_account as @jira_account" do
        post :create, {:jira_account => valid_attributes }, valid_session
        expect(assigns(:jira_account)).to be_a(JiraAccount)
        expect(assigns(:jira_account)).to be_persisted
      end

      it "redirects to the created jira_account" do
        post :create, { :jira_account => valid_attributes }, valid_session
        expect(response).to redirect_to(JiraAccount.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved jira_account as @jira_account" do
        # Trigger the behavior that occurs when invalid params are submitted
        JiraAccount.any_instance.stub(:save).and_return(false)
        post :create, { :jira_account => { "username" => "invalid value" } }, valid_session
        expect(assigns(:jira_account)).to be_a_new(JiraAccount)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        JiraAccount.any_instance.stub(:save).and_return(false)
        post :create, { :jira_account => { "username" => "invalid value" } }, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "#update" do
    describe "with valid params" do
      it "updates the requested jira_account" do
        jira_account = JiraAccount.create! valid_attributes
        # Assuming there are no other jira_accounts in the database, this
        # specifies that the JiraAccount created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        JiraAccount.any_instance.should_receive(:update_attributes).with({ "username" => "MyString" })
        put :update, { :id => jira_account.to_param, :jira_account => { "username" => "MyString" } }, valid_session
      end

      it "assigns the requested jira_account as @jira_account" do
        jira_account = JiraAccount.create! valid_attributes
        put :update, { :id => jira_account.to_param, :jira_account => valid_attributes }, valid_session
        expect(assigns(:jira_account)).to eq(jira_account)
      end

      it "redirects to the jira_account" do
        jira_account = JiraAccount.create! valid_attributes
        put :update, { :id => jira_account.to_param, :jira_account => valid_attributes }, valid_session
        expect(response).to redirect_to(jira_account)
      end
    end

    describe "with invalid params" do
      it "assigns the jira_account as @jira_account" do
        jira_account = JiraAccount.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        JiraAccount.any_instance.stub(:save).and_return(false)
        put :update, { :id => jira_account.to_param, :jira_account => { "username" => "invalid value" } }, valid_session
        expect(assigns(:jira_account)).to eq(jira_account)
      end

      it "re-renders the 'edit' template" do
        jira_account = JiraAccount.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        JiraAccount.any_instance.stub(:save).and_return(false)
        put :update, { :id => jira_account.to_param, :jira_account => { "username" => "invalid value" } }, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "#destroy" do
    it "destroys the requested jira_account" do
      jira_account = JiraAccount.create! valid_attributes
      expect {
        delete :destroy, { :id => jira_account.to_param }, valid_session
      }.to change(JiraAccount, :count).by(-1)
    end

    it "redirects to the jira_accounts list" do
      jira_account = JiraAccount.create! valid_attributes
      delete :destroy, { :id => jira_account.to_param }, valid_session
      expect(response).to redirect_to(jira_accounts_url)
    end
  end

end
