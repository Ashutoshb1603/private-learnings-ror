# require 'rails_helper'

# RSpec.describe BxBlockCfaviaapi2::AviapagesController, type: :controller do
#   describe 'POST #create_aviapages' do
#     let!(:aircraft_1) { FactoryBot.create(:aircraft) }
#     let!(:aircraft_2) { FactoryBot.create(:aircraft) }

#     let!(:schedule_1) { FactoryBot.create(:aircraft_schedule, aircraft: aircraft_1) }
#     let!(:schedule_2) { FactoryBot.create(:aircraft_schedule, aircraft: aircraft_1) }
#     let!(:schedule_3) { FactoryBot.create(:aircraft_schedule, aircraft: aircraft_2) }

#     before do
#       allow(controller).to receive(:get_aviapage_response)
#     end

#     it 'calls #get_aviapage_response for each aircraft and schedule' do
#       post :create_aviapages
#       expect(controller).to have_received(:get_aviapage_response).with(aircraft_1, schedule_1)
#       expect(controller).to have_received(:get_aviapage_response).with(aircraft_1, schedule_2)
#       expect(controller).to have_received(:get_aviapage_response).with(aircraft_2, schedule_3)
#     end
#   end

#   describe '#get_aviapage_response' do
#     let!(:aircraft) { FactoryBot.create(:aircraft) }
#     let!(:schedule) { FactoryBot.create(:aircraft_schedule, aircraft: aircraft) }
    
#     it 'creates a new Aviapage record with the response data' do
#       expect {
#         controller.get_aviapage_response(aircraft, schedule)
#       }.to change { BxBlockCfaviaapi2::Aviapage.count }.by(1)

#       aviapage = BxBlockCfaviaapi2::Aviapage.last
#       expect(aviapage.fuel).not_to be_nil
#       expect(aviapage.time).not_to be_nil
#       expect(aviapage.route).not_to be_nil
#       expect(aviapage.distance).not_to be_nil
#       expect(aviapage.airport).not_to be_nil
#       expect(aviapage.arrival_airport).not_to be_nil
#       expect(aviapage.departure_airport).not_to be_nil
#     end
#   end
# end


require 'rails_helper'
require 'webmock/rspec'

RSpec.describe BxBlockCfaviaapi2::AviapagesController, type: :controller do
  describe 'POST #create_aviapages' do
    let!(:aircraft_1) { FactoryBot.create(:aircraft) }
    let!(:aircraft_2) { FactoryBot.create(:aircraft) }

    let!(:schedule_1) { FactoryBot.create(:aircraft_schedule, aircraft: aircraft_1) }
    let!(:schedule_2) { FactoryBot.create(:aircraft_schedule, aircraft: aircraft_1) }
    let!(:schedule_3) { FactoryBot.create(:aircraft_schedule, aircraft: aircraft_2) }

    before do
      allow(controller).to receive(:get_aviapage_response)
    end

    it 'calls #get_aviapage_response for each aircraft and schedule' do
      stub_request(:post, "https://frc.aviapages.com/flight_calculator/")
        .to_return(status: 200, body: "{\"fuel\": 100, \"time\": 200, \"route\": \"ABC\", \"distance\": 300, \"airport\": \"DEF\", \"arrival_airport\": \"GHI\", \"departure_airport\": \"JKL\"}", headers: {})
      post :create_aviapages
      expect(controller).to have_received(:get_aviapage_response).with(aircraft_1, schedule_1)
      expect(controller).to have_received(:get_aviapage_response).with(aircraft_1, schedule_2)
      expect(controller).to have_received(:get_aviapage_response).with(aircraft_2, schedule_3)
    end
  end

  describe '#get_aviapage_response' do
    let!(:aircraft) { FactoryBot.create(:aircraft) }
    let!(:schedule) { FactoryBot.create(:aircraft_schedule, aircraft: aircraft) }
    let(:data_set) do
        {
            "fuel"=>{"airway"=>201, "airway_block"=>1854}, 
     "time"=>{"airway"=>13}, "route"=>{"ifr_route"=>["LOWW", "48N017E", "LOWW"]},
     "airport"=>{"arrival_airport"=>"LOWW", "departure_airport"=>"LOWW"}, "aircraft"=>"Challenger 850", "distance"=>{"airway"=>0}
    }.to_json
    end
    
    it 'creates a new Aviapage record with the response data' do
      stub_request(:post, "https://frc.aviapages.com/flight_calculator/")
        .to_return(status: 200, body: data_set , headers: {})
      expect {
        controller.get_aviapage_response(aircraft, schedule)
      }.to change { BxBlockCfaviaapi2::Aviapage.count }.by(1)

      aviapage = BxBlockCfaviaapi2::Aviapage.last
      expect(aviapage.fuel).not_to be_nil
      expect(aviapage.time).not_to be_nil
      expect(aviapage.route).not_to be_nil
      expect(aviapage.distance).not_to be_nil
      expect(aviapage.airport).not_to be_nil
      expect(aviapage.arrival_airport).not_to be_nil
      expect(aviapage.departure_airport).not_to be_nil
    end
        end
      end
      
