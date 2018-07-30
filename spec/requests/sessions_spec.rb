require 'rails_helper'

RSpec.describe "Users API", :type => :request do

  # pending "add some examples to (or delete) #{__FILE__}"

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
end
