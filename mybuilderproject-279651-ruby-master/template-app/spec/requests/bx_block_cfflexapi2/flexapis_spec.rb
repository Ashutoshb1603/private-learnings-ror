require 'rails_helper'

RSpec.describe "BxBlockCfflexapi2::Flexapis", type: :request do
  describe "store aircraft data in db" do
    air_res = [
    {
        "tailNumber": "XA-AGV",
        "numberOfSeats": 9,
        "type": "C68A",
        "model": "680A Citation Latitude",
        "typeName": "Example Aircraft",
        "homebase": "MMMX",
        "equipment": {
            "v110": true,
            "v230": true,
        },
        "wingSpan": 22.05,
        "maxFuel": 5168.0,
        "category": "ULTRA_LONG_RANGE_JET",
        "keyAccountManager": {
            "firstName": "Thomas",
            "lastName": "McClish",
        },
        "layout": {
          "cabinCrew": 0
        },
        "links": [
            {
                "rel": "schedule",
                "href": "http://test.fl3xx.com/api/external/aircraft/XA-AGV/schedule?from=2023-02-06&to=2023-05-06&initLocation=false"
            },
            {
                "rel": "self",
                "href": "http://test.fl3xx.com/api/external/aircraft/XA-AGV"
            }
        ]
    }]

    schedule_res = [
    {
        "id": "flight_52685",
        "departureAirport": "MMMX",
        "arrivalAirport": "UHWW",
        "arrivalDate": "2023-03-26T12:45",
        "arrivalDateUTC": "2023-03-26T02:45",
        "departureDate": "2023-03-25T02:27",
        "departureDateUTC": "2023-03-25T08:27",
        "pax": 0,
        "tripNumber": 500638,
        "workflow": "CHARTER",
        "fplType": "N",
        "workflowCustomName": "Charter"
    }]
    it "get and save data" do
      stub_request(:get, "https://test.fl3xx.com/api/external/aircraft").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'multipart/form-data',
          'Host'=>'test.fl3xx.com',
          'User-Agent'=>'Ruby',
          'X-Auth-Token'=>'iB-YfHt0rYZgpKdIbDM6_Nyuzcda7J5U'
           }).
         to_return(status: 200, body: JSON.dump(air_res), headers: {})

      stub_request(:get, "https://test.fl3xx.com/api/external/aircraft/XA-AGV/schedule?from=2023-02-06&initLocation=false&to=2023-05-06").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'multipart/form-data',
          'Host'=>'test.fl3xx.com',
          'User-Agent'=>'Ruby',
          'X-Auth-Token'=>'iB-YfHt0rYZgpKdIbDM6_Nyuzcda7J5U'
           }).
         to_return(status: 200, body: JSON.dump(schedule_res), headers: {})

      post "/bx_block_cfflexapi2/flexapis/store_aircraft_data", headers: {}
      data = JSON.parse(response.body)
      expect(response).to have_http_status(200)
    end
  end

  describe "store crew data in db" do
    crew_res = [
              {
                  "id": 23873,
                  "operator": {
                      "id": 3,
                      "name": "TestAir"
                  },
                  "firstName": "Sergey",
                  "contacts": [
                      {
                          "id": 488243218,
                          "type": "EMAIL",
                          "data": "test@mailinator.com",
                          "main": true
                      },
                  ],
                  "icalCalendarLink": "https://test.fl3xx.com/api/external/ical/personSchedules/23873.ics",
                  "defaultAccount": {
                      "id": 17731,
                      "name": "Sergey Ivanovlux",
                      "status": "ACTIVE",
                  },
                  "homeAirport": {
                      "id": 20725,
                      "timeZone": "Europe/Vienna"
                  },
                  "fuzzySearch": true,
                  "roles": [
                      {
                          "id": 10,
                          "type": "PILOT",
                          "mandatoryId": 13,
                      }
                  ],
                  "aircrafts": [
                      {
                          "id": 810,
                          "operator": {
                              "id": 3,
                              "name": "TestAir"
                          },
                          "aircraftName": "Citation Mustang",
                          "registration": "OE-ATT"
                      }
                  ]
              }
          ]

    it "get and save data" do
      arr = ["LOWW", "KLAX", "LEMD", "EDDM", "EDDS"]
      arr.each do |a|
        url = "https://test.fl3xx.com/api/external/airports/#{a}/crew"
        stub_request(:get, url).
           with(
             headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type'=>'multipart/form-data',
            'Host'=>'test.fl3xx.com',
            'User-Agent'=>'Ruby',
            'X-Auth-Token'=>'iB-YfHt0rYZgpKdIbDM6_Nyuzcda7J5U'
             }).
           to_return(status: 200, body: JSON.dump(crew_res), headers: {})
      end



      post "/bx_block_cfflexapi2/flexapis/store_crew_data", headers: {}
      data = JSON.parse(response.body)
      expect(response).to have_http_status(200)
    end
  end

  describe "store airport data in db" do
    region_res_body = {
    "regions": [
        {
            "region_id": "6",
            "region_name": "Africa"
        }]}

    countries_res_body = {
    "countries": [
        {
            "country_id": 4,
            "country_name": "ALGERIA",
            "iso_country_name": "ALGERIA",
            "iso_code_2": "DZ",
            "iso_code_3": "DZA",
            "region_id": "6",
            "region_name": "Africa"
        }]}

    airport_res = {
    "airports": [
        {
            "airport_id": 339,
            "icao": "DAAB",
            "iata": "QLD",
            "faa": nil,
            "airport_name": "Blida/El Boulaida AB",
            "city": "Blida",
            "subdivision_name": "Blida",
            "country_name": "ALGERIA",
            "iso_country_name": "ALGERIA",
            "airport_of_entry": "No",
            "Last_Edited": "19/5/2022"
        }]}

    it "get and save data" do
      stub_request(:get, "https://api.airportdata.com/regions?apikey=91754B6CBC5F5856").
               with(
                 headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Host'=>'api.airportdata.com',
                'User-Agent'=>'Ruby'
                 }).
               to_return(status: 200, body: JSON.dump(region_res_body), headers: {})

      stub_request(:get, "https://api.airportdata.com/countries?apikey=91754B6CBC5F5856&region_id=6").
               with(
                 headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Host'=>'api.airportdata.com',
                'User-Agent'=>'Ruby'
                 }).
               to_return(status: 200, body: JSON.dump(countries_res_body), headers: {})

      stub_request(:get, "https://api.airportdata.com/airports?apikey=91754B6CBC5F5856&country_id=4").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host'=>'api.airportdata.com',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: JSON.dump(airport_res), headers: {})

      post "/bx_block_cfflexapi2/flexapis/store_airport_data", headers: {}
      data = JSON.parse(response.body)
      expect(response).to have_http_status(200)
    end
  end
end