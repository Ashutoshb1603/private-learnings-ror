namespace :flex_data_import do
  task :import_crew_data => :environment do
    puts "environment - #{Rails.env}"
    BxBlockCfflexapi2::FlexApiService.get_crew_data
    puts "job in progress."
  end

  task :import_aircraft_data => :environment do
    puts "environment - #{Rails.env}"
    BxBlockCfflexapi2::FlexApiService.get_aircaft_data_and_store
    puts "job in progress."
  end
end