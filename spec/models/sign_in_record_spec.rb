require 'rails_helper'

describe SignInRecord do

  it { should belong_to :user }
  it { should validate_presence_of :latitude }
  it { should validate_presence_of :longitude }

  describe '.get_distance' do
    context 'lat = 0, lng = 0' do
      let(:lat) { 0.0 }
      let(:lng) { 0.0 }

      it 'should return roughly 111km when record.latitude = 1.0 and longitude = 0.0' do
        user = User.create(device_token: 'token')
        record = user.sign_in_records.new(latitude: '1.0', longitude: '0.0')
        d = record.get_distance('0', '0')
        expect(d.to_i).to eq(111)
      end

      it 'should return 0km when record.latitude = 0, record.longitude = 0' do
        user = User.create(device_token: 'token')
        record = user.sign_in_records.new(latitude: '0.0', longitude: '0.0')
        d = record.get_distance('0', '0')
        expect(d.to_i).to eq(0)
      end  
    end    
  end

  describe '#search_nearest_records' do
    it 'should return at least 10 records if param is nil' do
      user = User.create(device_token: 'token')
      (0..14).each do |index|
        record = user.sign_in_records.create(latitude: index.to_s, longitude: '0')
      end
      expect(SignInRecord.count).to eq(15)
      expect(SignInRecord.first.search_nearest_records.count).to eq(10)
    end

    it 'should return records if param is 500M' do
      user = User.create(device_token: 'token')
      (0..14).each do |index|
        record = user.sign_in_records.create(latitude: (index.to_f / 1110).to_s, longitude: '0')
      end
      expect(SignInRecord.count).to eq(15)
      records = SignInRecord.first.search_nearest_records(0.5)
      expect(records.count).to eq(5)
    end

    it 'should return records if param is 1KM' do
      user = User.create(device_token: 'token')
      (0..14).each do |index|
        record = user.sign_in_records.create(latitude: (index.to_f / 1110).to_s, longitude: '0')
      end
      expect(SignInRecord.count).to eq(15)
      records = SignInRecord.first.search_nearest_records(1)
      expect(records.count).to eq(10)
    end

    it 'should return records if param is 5KM' do
      user = User.create(device_token: 'token')
      (0..14).each do |index|
        record = user.sign_in_records.create(latitude: (index.to_f / 111.0).to_s, longitude: '0')
      end
      expect(SignInRecord.count).to eq(15)
      records = SignInRecord.first.search_nearest_records(5)
      expect(records.count).to eq(5)
    end

    it 'should return records if param is 10KM' do
      user = User.create(device_token: 'token')
      (0..14).each do |index|
        record = user.sign_in_records.create(latitude: (index.to_f / 111.0).to_s, longitude: '0')
      end
      expect(SignInRecord.count).to eq(15)
      records = SignInRecord.first.search_nearest_records(10)
      expect(records.count).to eq(10)
    end
  end

end
