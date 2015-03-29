require 'rails_helper'

describe User do

  it { should validate_uniqueness_of :device_token }
  it { should have_many :sign_in_records }
  it { should have_many :tracked_users }

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

  describe '#find_by_token' do
    let(:token) { 'aaa' }

    it 'should return user if device_token is existed' do
      User.create(device_token: token)
      user = User.find_by_token(token)
      expect(User.count).to eq(1)
      expect(user).to eq(User.first)
    end
  end

end
