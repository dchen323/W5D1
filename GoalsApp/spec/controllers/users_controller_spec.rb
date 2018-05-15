require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "renders template new" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "creates an user on valid params" do
      post :create, params: {user: {username: 'username', password: 'password'}}
      user = User.find_by_username('username')
      expect(session[:session_token]).to eq(user.session_token)
    end
    
    it "creates an user on valid params" do
      post :create, params: {user: {username: 'username', password: 'password'}}
      user = User.find_by_username('username')
      expect(response).to redirect_to(user_url(user))
    end
    
    it "does not create an user on invalid params" do
      post :create, params: {user: {username: 'username'}}
      expect(flash[:errors]).to be_present
    end
  end

end
