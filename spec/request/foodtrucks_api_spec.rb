require 'spec_helper'

describe 'Using the Foodtruck API', type: :request do
  describe "to request a listing of foodtrucks" do
    subject { parsed_response }

    let(:parsed_response) { JSON.parse response.body }

    before do
      number_of_foodtrucks.times { FactoryGirl.create :foodtruck }
      #get '/foodtrucks.json'
      get foodtrucks_path(format: :json)
    end

    context 'when there are foodtrucks' do
      let(:number_of_foodtrucks) { 7 }

      it 'should be properly formatted, non-empty JSON' do
        subject.should_not be_nil
      end

      it 'has a successful status code' do
        response.status.should == 200
      end

      it 'contains the correct number of entries' do
        subject.size.should == number_of_foodtrucks
      end

      describe 'each listing' do

        it 'has a name' do
          number_of_foodtrucks.times do |n|
            subject[n]['name'].should == '#1 A+ Foodtruck'
          end
        end

        it "has a screen name" do
          number_of_foodtrucks.times do |n|
            subject[n]['screen_name'].should == 'truck1'
          end
        end
      end
    end

    context 'when there are no foodtrucks' do
      let(:number_of_foodtrucks) { 0 }

      it 'is a properly formatted empty JSON array' do
        response.body.should be_json_eql '[]'
      end

      it 'has a successful status code' do
        response.status.should == 200
      end
    end
  end
end
