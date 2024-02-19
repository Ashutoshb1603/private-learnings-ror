namespace :airport_data_import do
  task :import_airport_data => :environment do
    puts "environment - #{Rails.env}"
    BxBlockCatalogue::AirportDataApiService.get_airport_data
    puts "job in progress."
  end
end
