module BxBlockContentmanagement
    class BlogsWorker
        include Sidekiq::Worker

        def initialize
            @shopify = BxBlockShopifyintegration::ShopifyBlogsController.new({country: "Ireland"})
        end

        def perform()
            blogs = @shopify.blogs["blogs"]
            blog_id = "50963775523"
            blogs.each do |blog|
                blog_id = blog["id"] if blog["title"] == "Corinna's Corner"
            end
            time = 1.hour.ago.beginning_of_hour
            articles = @shopify.articles(blog_id, "", "", time)["articles"]

            if articles.present?
                accounts = AccountBlock::Account.all
                registration_ids = accounts.map(&:device_token)
                payload_data = {account_ids: accounts.map(&:id), notification_key: 'skin_hub', inapp: true, push_notification: true, all: true, type: 'skin_hub', notification_for: 'skin_hub', key: 'blog', record_id: articles[0]["id"]}
                BxBlockPushNotifications::FcmSendNotification.new("Corinna has just posted her latest blog to Corinna’s Corner. Stay up to date with the latest skincare news and innovation.", "Corinna has just posted her latest blog on Skin Deep", registration_ids, payload_data).call
            end
        end
    end
end