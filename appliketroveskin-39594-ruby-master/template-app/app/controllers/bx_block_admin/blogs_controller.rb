module BxBlockAdmin
    class BlogsController < ApplicationController
        before_action :current_user
        before_action :shopify_blogs

        def create 
            article_body = {article: article_params.merge(author: @current_user.name).to_h}
            accounts = AccountBlock::Account.where("device_token is not null and device_token != ''")
            registration_ids = accounts.map(&:device_token)
            article = @@shopify.create(params[:blog_id], article_body)
            article_json = JSON.parse(article)["article"]
            if !article["errors"].present?
                payload_data = {account_ids: accounts.map(&:id), notification_key: 'blog_created', inapp: true, push_notification: true, all: true, type: 'skin_hub', redirect: 'blog_post', record_id: article_json["id"], notification_for: 'blog', parent_id: params[:blog_id], key: 'blog'}
                blog_data = {parent_id: params[:blog_id], article_id: article_json["id"]}
                BxBlockPushNotifications::FcmSendNotification.new("Corinna has just posted her latest blog to Corinna’s Corner. Stay up to date with the latest skincare news and innovation", "New blog is added", [registration_ids], payload_data, blog_data).call
                emails = AccountBlock::Account.pluck(:email)
                BxBlockBlogpostsmanagement::BlogMailer.with(account: @user, article: article_json, emails: emails).blog_created.deliver
            end
            render json: article
        end

        def pin_or_unpin
            post_id = params[:article_id]
            featured = BxBlockBlogpostsmanagement::FeaturedPost.find_or_initialize_by(post_id: post_id) if post_id.present?
            featured.persisted? ? featured.destroy : featured.save if post_id.present?
            render json: {message: "Pinned successfully"}
        end

        private
        def article_params
            params["data"].require("article").permit(:title, :tags, :body_html, image: [:src, :alt])
        end

    end
end