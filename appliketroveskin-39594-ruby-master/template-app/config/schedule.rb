# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#

# require File.expand_path('../..//config/environment.rb', __FILE__)
# ## Send Abandoned cart notifications
# abandon_cart = BxBlockNotifications::NotificationPeriod.find_by(notification_type: 'abandon_cart')
# every abandon_cart.get_cronjob_period do
#   runner "AccountBlock::Account.send_abandoned_notifications"
# end


# every 1.hour do
#   rake "notification:abandoned_cart_notification", :output => 'abandoned_cart_notification.log'
# end


# every 1.days, at: '12:00am' do
#   rake 'payment:daily_payment', :output => 'payment_cron.log'
# end

# every 7.days, at: '12:00am' do
#   rake 'payment:weekly_payment', :output => 'payment_cron.log'
# end

# every 30.days, at: '12:00am' do
#   rake 'payment:monthly_payment', :output => 'payment_cron.log'
# end

# every 15.minutes do
#   rake 'live:notify', :output => 'live_cron.log'
#   rake 'notification:scheduled_notification', :output => 'scheduled_notification.log'
# end

# every 1.day at '12:00pm' do
#   rake 'membership_expiring_soon:notify', :output => 'membership_expiring_soon_cron.log'
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
