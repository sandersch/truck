require 'spec_helper'

describe 'Foodtruck API', type: :request do
  describe "listing foodtrucks from API" do
    let(:parsed_response) { JSON.parse response.body }

    before do
      7.times { FactoryGirl.create :foodtruck }
      get '/foodtrucks.json'
    end

    it 'returns a successful status code' do
      response.status.should == 200
    end

    it 'contains the right number of entries' do
      parsed_response.size.should == 7
    end

    describe 'an entry' do
      subject { parsed_response.first }

      it 'has a name' do
        subject['name'].should == '#1 A+ Foodtruck'
      end

    end
  end 
end
