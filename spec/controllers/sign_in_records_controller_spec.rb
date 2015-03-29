require 'rails_helper'

describe SignInRecordsController do
  let(:token) { 'aaa' }    

  describe 'POST create' do
    it 'should create sign_in_record if input is valid' do
      post :create, device_token: token, sign_in_record: { latitude: '37', longitude: '-100' }
      expect(SignInRecord.count).to eq(1)
      expect(User.first.device_token).to eq(token)
    end

    it 'should not create sign_in_record if input is invalid' do
      post :create, device_token: token, sign_in_record: { latitude: '' }
      expect(SignInRecord.count).to eq(0)        
    end
  end

  describe 'GET show' do
    it 'should render sign_in_record' do
      user = User.create(device_token: token)
      record = user.sign_in_records.create(latitude: '0', longitude: '0')
      get :show, device_token: token, id: record.id
      expect(response).to be_success
      expect(SignInRecord.count).to eq(1)
    end

    it 'should return bad_status if device_token is not existed' do
      user = User.create(device_token: 'qqq')
      record = user.sign_in_records.create(latitude: '0', longitude: '0')
      get :show, device_token: token, id: record.id
      expect(response).to be_error
    end
  end

  describe 'PUT update' do
    it 'should update sign_in_record' do
      user = User.create(device_token: token)
      record = user.sign_in_records.create(latitude: '0', longitude: '0')
      put :update, device_token: token, id: record.id, sign_in_record: { longitude: '1'}
      expect(SignInRecord.first.longitude).to eq('1')
    end

    it 'should not update sign_in_record not belong to user' do
      user = User.create(device_token: token)
      record = user.sign_in_records.create(latitude: '0', longitude: '0')
      User.create(device_token: 'qqq')
      put :update, device_token: 'qqq', id: record.id, sign_in_record: { longitude: '1'}
      expect(SignInRecord.first.longitude).to eq('0')
    end

  end

  describe 'DELETE destroy' do
    it 'should delete sign_in_record' do
      user = User.create(device_token: token)
      record = user.sign_in_records.create(latitude: '0', longitude: '0')
      expect(SignInRecord.count).to eq(1)
      delete :destroy, device_token: token, id: record.id
      expect(SignInRecord.count).to eq(0)
    end

    it 'should not delete record not belong to user' do
      user = User.create(device_token: token)
      record = user.sign_in_records.create(latitude: '0', longitude: '0')
      expect(SignInRecord.count).to eq(1)
      User.create(device_token: 'qqq')
      delete :destroy, device_token: 'qqq', id: record.id
      expect(SignInRecord.count).to eq(1)
    end
  end
end
