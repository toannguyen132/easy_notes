require 'rails_helper'

RSpec.describe "Users API", :type => :request do

  # pending "add some examples to (or delete) #{__FILE__}"
  #

  # TEST register endpoint
  describe 'POST register' do
    let(:params) do
      {
        user: {
            name: Faker::Name.name,
            username: Faker::Internet.username,
            email: 'sample@gmail.com',
            password: '123456',
            password_confirmation: '123456',
        }
      }
    end
    let(:login_params) { { login: { email: params[:user][:email], password: params[:user][:password]} } }

    it "Should return 400 status and message when register with wrong password confirmation" do
      wrong_params = params
      wrong_params[:user][:password_confirmation] = '1234567'
      post '/register', :params => wrong_params

      expect(response.body).to match(/Password confirmation doesn't match Password/)
      expect(response.status).to eq(400)
    end

    it "Should return 400 status and message when register with existed email" do
      post '/register', :params => params

      post '/register', :params => params

      expect(response.body).to match(/Email has already been taken/)
      expect(response.status).to eq(400)
    end

    it "Should return 200 status after create user" do
      post '/register', :params => params

      expect(response.status).to eq(200)
    end

    it "Should able to login after register" do
      post '/register', :params => params

      post '/login', :params => login_params
    end
  end


  # TEST login endpoint
  describe 'POST login' do
    let(:params) { { login: { email: 'toan@nguyen.com', password: '123456'} } }
    let(:params_incorrect) { { login: { email: 'toan@nguyen.com', password: '1234567'} } }

    #create a user before
    before {
      user = User.new
      user.email = 'toan@nguyen.com'
      user.username = 'toannguyen'
      user.password = '123456'
      user.save
    }

    it "Should return status code 200 when login successfull" do
      post '/login.json', :params => params
      expect(response.status).to eq(200)
    end

    it "Should return status code 401 when login with incorrect info" do
      post '/login.json', :params => params_incorrect
      expect(response.status).to eq(401)
    end
  end

  describe 'DELETE logout' do
    let(:params) { { login: { email: 'toan@nguyen.com', password: '123456'} } }

    before {
      user = User.new
      user.email = 'toan@nguyen.com'
      user.username = 'toannguyen'
      user.password = '123456'
      user.save
    }

    it "Should log out successfully" do
      post '/login.json', :params => params

      delete '/logout'

      expect(response.status).to eq(200)
      expect(response.body).to match(/log out successfully/)
    end
  end
end
