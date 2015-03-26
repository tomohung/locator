require 'rails_helper'

describe User do

  it { should validate_uniqueness_of :device_token }

  context 'device_token is existed' do
    it 'should create a new user by device_token' do
      User.create(device_token: "a")
      expect(User.count).to eq(1)
    end
  end

  context 'device_token is NOT existed' do
    it 'should not create new user' do
      device_token = 'a'
      User.create(device_token: device_token)
      User.create(device_token: device_token)
      expect(User.count).to eq(1)
    end
  end

end