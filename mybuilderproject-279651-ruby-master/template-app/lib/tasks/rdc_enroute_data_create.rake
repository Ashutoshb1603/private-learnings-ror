namespace :rdc_enroute_data_create do
  task :import_rdc_enroute_data => :environment do
    puts "environment - #{Rails.env}"
    BxBlockCfrdcenroutechargesapi::RdcEnrouteChargeApiService.create_rdc_enroute_charge_data
    puts "job in progress."
  end
end