module BxBlockContentmanagement
    class SkinHubController < ApplicationController
       
        before_action :shopify_blogs
        before_action :get_user

        def index
            questions = BxBlockCommunityforum::Question.active.non_offensive.order('created_at DESC')
            questions = questions.where('user_type != ?', BxBlockCommunityforum::Question.user_types["elite"]) if @user.role.name.downcase == "user" and (@user.membership_plan[:plan_type] == "free" or @user.membership_plan[:plan_type] == "glow_getter")
            post = questions.limit(5)
            blogs = @@shopify.blogs["blogs"]
            blog_id = "50963775523"
            blogs.each do |blog|
                blog_id = blog["id"] if blog["title"] == "Corinna's Corner"
            end
            article_ids = BxBlockBlogpostsmanagement::FeaturedPost.where.not(post_id: "").pluck(:post_id)
            articles = {}
            articles["articles"] = []
            if article_ids.count > 1
                article_ids = article_ids.sample(2)
                articles["articles"] << JSON.parse(@@shopify.article(blog_id, article_ids[0]))["article"]
                articles["articles"] << JSON.parse(@@shopify.article(blog_id, article_ids[1]))["article"]
            elsif article_ids.count > 0
                article_ids = article_ids.sample(1)
                articles["articles"] << JSON.parse(@@shopify.article(blog_id, article_ids[0]))["article"]
            end
            articles["articles"].compact!
            if articles["articles"].count < 2
                shopify_articles = @@shopify.articles(blog_id, 2)["articles"]
                articles["articles"] << (shopify_articles[0]["id"].to_s != article_ids[0] ? shopify_articles[0] : shopify_articles[1]) if articles["articles"].count == 1
                articles["articles"] = @@shopify.articles(blog_id, 2)["articles"] if articles["articles"].count == 0
            end


            tutorials = Tutorial.order('created_at DESC').limit(3)
            live_videos = LiveVideo.active.order('created_at DESC').limit(3)
            academies = Academy.limit(3)

            serialized_post = BxBlockCommunityforum::QuestionsSerializer.new(post, params: {current_user: @user})
            serialized_tutorials = TutorialsSerializer.new(tutorials, params: {current_user: @user})
            serialized_live_videos = LiveVideoSerializer.new(live_videos, params: {current_user: @user})
            serialized_academies = AcademySerializer.new(academies, params: {current_user: @user})

            data = {}
            data = data.merge(post: serialized_post, articles: articles["articles"], tutorials: serialized_tutorials, live_videos: serialized_live_videos, academies: serialized_academies)
            render json: data
        end

        private

        def get_user
            @user = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
            @user = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
            render json: {errors: {message: 'User is invalid'}} and return unless @user.present?
        end
    end
end