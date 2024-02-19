# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
every 1.hours do
  rake "flex_crew_data_import:import_crew_data"
  rake "flex_crew_data_import:import_aircraft_data"
  rake "airport_data_import:import_airport_data"
  rake "rdc_enroute_data_create:import_rdc_enroute_data"
end
every 23.hours do
  runner "BxBlockCfflexapi2::GenerateLeonRefreshTokenJob.perform_later"
end

every 25.minutes do
  runner "BxBlockCfflexapi2::GenerateLeonAccessTokenJob.perform_later"
end