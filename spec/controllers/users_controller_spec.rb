require 'rails_helper'
require 'securerandom'

describe UsersController do

  let(:token) { SecureRandom.uuid }
  describe 'POST create' do
    it 'should create user when token is valid' do
      post :create, user: { device_token: token }
      expect(User.first.device_token).to eq(token)
    end

    it 'should not create user when token is existed' do
      User.create(device_token: token)
      post :create, user: { device_token: token }
      expect(User.count).to eq(1)
    end

    it 'should return bad_request when creating user failed' do
      User.create(device_token: token)
      post :create, user: { device_token: token }
      expect(response.status).to eq(400)
    end
  end

end