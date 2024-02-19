puts "****************************** Started creating notifications types ***********************"

keys = ['appointment', 'broadcast', 'live', 'forum', 'skin_journey', 'tutorial', 'academy', 'blog', 'profile', 'wallet', 'plan', 'account', 'order', 'glow_gift']

keys.each do |key|
    BxBlockNotifications::NotificationType.find_or_create_by(key: key)
end


puts "****************************** Completed creating notifications types ***********************"