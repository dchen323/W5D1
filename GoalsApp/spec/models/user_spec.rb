require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
  end
  
  describe 'session token check' do
    it 'assings a session token if one is not given' do
      user = User.create(username: 'username', password: 'password')
      expect(user.session_token).not_to be_nil
    end
  end
  
  describe 'password encryption' do 
    it 'does not save the password to the db' do
      User.create!(username: 'username2', password: 'password')
      user = User.find_by(username: 'username2')
      expect(user.password).to be_nil  
    end
    it 'uses BCrypt to encrypt a password' do
      expect(BCrypt::Password).to receive(:create).with('password')
      User.new({username: 'username3', password: 'password'})
    end    
  end
  
  describe '::find_by_credentials works' do
    before :each do
      User.create!({username: 'username3', password: 'password'})
    end
    it 'finds by credentials' do 
      usr = User.find_by_credentials('username3','password')
      expect(usr).to eq(User.last) 
    end
    it 'finds by credentials returns nil on bad input' do 
      usr = User.find_by_credentials('username3','passsword')
      expect(usr).to eq(nil) 
    end
  end
end
