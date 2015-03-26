require 'rails_helper'

describe SignInRecord do

  it { should belong_to :user }
  it { should validate_presence_of :latitude }
  it { should validate_presence_of :longitude }

  context 'device_token is existed' do


  end
end