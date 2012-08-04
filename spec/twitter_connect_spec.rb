require_relative '../app/models/twitter_connect'
require 'support/vcr'

describe TwitterConnect, :vcr do
  #use_vcr cassette 'twitter'
  describe 'request a user' do
    let(:user_name) { '2girls4wheels' }
    subject { TwitterConnect.user(user_name) } 

    it 'has a name' do
      subject.name.should eql "2 Girls 4 Wheels"
    end

    its(:location) { should eql 'St. Louis' }
  end

  describe 'their latest status' do
    let(:user_name) { '2girls4wheels' }
    subject { TwitterConnect.latest(user_name) } 

    it 'has a text' do
      subject.text.should be_a String
    end

    it 'has a user' do
      subject.user.should be_a Twitter::User
    end

    describe 'the geolocation' do
      subject { TwitterConnect.latest(user_name).geo }
      its(:latitude) { should be_a Float }
      its(:longitude) { should be_a Float }

      it 'has a coordinate pair' do
        subject.coordinates.should == [subject.lat, subject.long]
      end
    end
  end
end
