module BxBlockBlogpostsmanagement
    class BlogsController < ApplicationController
        before_action :shopify_blogs
        before_action :get_user, only: [:article]

        def index
            blogs = @@shopify.blogs
            render json: blogs
        end

        def show
            articles = @@shopify.articles(params[:id], "", params[:search_params])
            featured = FeaturedPost.all
            featured_posts = []
            posts = []
            articles["articles"].each do |article|
                article["body_html"] = article["body_html"].tr("\n", "").tr("\t", "").tr("\"", "'")
                article["body_html"] = article["body_html"].gsub(/\[.*?\]/, '')
                if featured.where(post_id: article["id"].to_s).present? 
                    featured_posts << article.merge(featured_post: true)
                else
                    posts << article.merge(featured_post: false)
                end
            end
            articles["articles"] = (featured_posts + posts)
            render json: articles
        end

        def article
            article = JSON.parse(@@shopify.article(params[:id], params[:article_id]))
            views = BlogView.where('blog_id = ? and account_id = ? and created_at > ?', article["article"]["id"].to_s, @user.id, (Time.now - 24.hours))
            BlogView.create(account_id: @user.id, blog_id: article["article"]["id"].to_s) unless views.present?
            article["article"]["body_html"] = article["article"]["body_html"].tr("\n", "").tr("\t", "").tr("\"", "'")
            article["article"]["body_html"] = article["article"]["body_html"].gsub(/\[.*?\]/, '')
            render json: article
        end

        private
        def get_user
            @user = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
            @user = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
            render json: {errors: {message: 'Account is invalid'}}, status: 404 and return unless @user.present?
            # render json: {errors: {message: 'You need to be an admin to access this API.'}}, status: 401 and return unless @user.admin?
        end
    end
end
