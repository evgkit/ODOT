require 'spec_helper'

RSpec.describe UserSessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "POST #create" do
    context "with correct credentials" do
      let!(:user) { User.create(
          first_name: "Tim",
          last_name: "Cook",
          email: "stevejobs@apple.com",
          password: "hello1234",
          password_confirmation: "hello1234"
      ) }

      it "redirects to the todo lists path" do
        post :create, email: "stevejobs@apple.com", password: "hello1234"
        expect(response).to be_redirect
        expect(response).to redirect_to(todo_lists_path)
      end

      it "finds the user" do
        expect(User).to receive(:find_by).with({email: "stevejobs@apple.com"}).and_return(user)
        post :create, email: "stevejobs@apple.com", password: "hello1234"
      end

      it "authenticates the user" do
        User.stub(:find_by).and_return(user) # WOW! It's OK
        expect(user).to receive(:authenticate)
        post :create, email: "stevejobs@apple.com", password: "hello1234"
      end
    end

  end

end
