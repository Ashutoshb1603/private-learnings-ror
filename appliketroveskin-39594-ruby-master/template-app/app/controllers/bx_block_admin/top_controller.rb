module BxBlockAdmin
    class TopController < BxBlockAdmin::ApplicationController
        before_action :current_user
        before_action :shopify_blogs
        before_action :shopify_products

        def index
            start_date = params[:start_date]&.to_time
            end_date = params[:end_date]&.to_time || Time.now
            blogs = BxBlockBlogpostsmanagement::BlogView.all
            blogs = blogs.where('created_at >= ? and created_at <= ?', start_date, end_date)
            top_10_blogs = blogs.group(:blog_id).order('count(blog_id) DESC').count.first(10).to_h 

            blogs = @@shopify.blogs["blogs"]
            blog_id = "50963775523"
            blogs.each do |blog|
                blog_id = blog["id"] if blog["title"] == "Corinna's Corner"
            end
            blogs = @@shopify.articles(blog_id, "", params[:search])["articles"]
            top_blogs = []
            blogs.each do |blog|
             top_blogs << {
                "id": blog_id,
                "article_id": blog["id"],
                "title": blog["title"],
                "blog_views": top_10_blogs[blog["id"].to_s]
             } if top_10_blogs.key?(blog["id"].to_s)
            end

            top_blogs = top_blogs.sort_by! {|k| k["blog_views"]}.reverse

            # home_page_views = BxBlockContentmanagement::HomePageView.all.sum(:view_count)

            tutorials_views = BxBlockContentmanagement::SkinHubView.where(objectable_type: 'BxBlockContentmanagement::Tutorial')
            tutorial_views = tutorials_views.where('created_at >= ? and created_at <= ?', start_date, end_date) if start_date.present?
            tutorials = BxBlockContentmanagement::Tutorial.joins(:tutorial_views).group(:objectable_id).order('count(objectable_id) DESC').count.first(10).to_h if !start_date.present?
            tutorials = BxBlockContentmanagement::Tutorial.joins(:tutorial_views).group(:objectable_id).where('skin_hub_views.created_at >= ? and skin_hub_views.created_at <= ?', start_date, end_date).order('count(objectable_id) DESC').count.first(10).to_h if start_date.present?
            top_tutorials = []
            tutorials.map {|k,v| top_tutorials << BxBlockContentmanagement::Tutorial.find(k) }
            serialized_tutorials = BxBlockAdmin::TopTutorialSerializer.new(top_tutorials).serializable_hash

            live_views = BxBlockContentmanagement::SkinHubView.where(objectable_type: 'BxBlockContentmanagement::LiveVideo')
            live_video = BxBlockContentmanagement::LiveVideo.joins(:video_views).group(:objectable_id).order('count(objectable_id) DESC').count.first if !start_date.present?
            live_video = BxBlockContentmanagement::LiveVideo.joins(:video_views).group(:objectable_id).where('skin_hub_views.created_at >= ? and skin_hub_views.created_at <= ?', start_date, end_date).order('count(objectable_id) DESC').count.first if start_date.present?
            top_live_video = BxBlockContentmanagement::LiveVideo.find(live_video[0]) if live_video.present?

            forums = BxBlockCommunityforum::Question.joins(:views).group(:question_id).order('count(question_id) DESC').count.first(10).to_h if !start_date.present?
            forums = BxBlockCommunityforum::Question.joins(:views).group(:question_id).where('views.created_at >= ? and views.created_at <= ?', start_date, end_date).order('count(question_id) DESC').count.first(10).to_h if start_date.present?
            top_forums = []
            forums.map {|k,v| top_forums << BxBlockCommunityforum::Question.find(k) }
            serialized_top_forums = BxBlockCommunityforum::QuestionsSerializer.new(top_forums, params: {current_user: @current_user}).serializable_hash

            plan_type_value = BxBlockCustomisableusersubscriptions::MembershipPlan.plan_types[params[:user_type]] if params[:user_type].present?
            accounts = AccountBlock::Account.all
            accounts = accounts.joins(:membership_plans).where('membership_plans.end_date > ? and membership_plans.plan_type = ?', Time.now, plan_type_value) if plan_type_value.present?
            accounts = AccountBlock::Account.joins(:membership_plans).where("plan_type in(1, 2)") if params[:user_type] == 'all'
            top_forum_users = accounts.joins(:questions).group(:accountable_id).order('count(accountable_id) DESC').count.first(10).to_h if !start_date.present?
            top_forum_users = accounts.joins(:questions).where('questions.created_at >= ? and questions.created_at <= ?', start_date, end_date).group(:accountable_id).order('count(accountable_id) DESC').count.first(10).to_h if start_date.present?
            top_forum_users_accounts = []
            top_forum_users.map {|k,v| top_forum_users_accounts << AccountBlock::Account.find(k) }
            serialzed_users = BxBlockAdmin::TopForumUsersSerializer.new(top_forum_users_accounts).serializable_hash

            top_collection = BxBlockCatalogue::ProductCollectionView.where('created_at >= ? and created_at <= ?', start_date, end_date).group(:collection_id).order('count(collection_id) DESC').count.first if start_date.present?
            top_collection = BxBlockCatalogue::ProductCollectionView.group(:collection_id).order('count(collection_id) DESC').count.first if !start_date.present?
            top_collection_id = top_collection[0] if top_collection.present?
            s_data = @@shopify_product.product_library_show(top_collection_id) if top_collection_id.present?
            collection_title = s_data == nil ? '' : s_data["collection"].present? ? s_data["collection"]["title"] : ''
            puts top_collection
            puts "*******"
            puts top_collection_id
            puts "*-**-**-*-"
            puts s_data
            puts "*-**-**-*-"
            puts collection_title
            page_views = []

            # page_views << {
            #     title: "Home Page",
            #     views: home_page_views,
            #     redirect_to: 'home_page'
            # } if home_page_views.present?

            page_views << {
                id: top_blogs[0][:id],
                article_id: top_blogs[0][:article_id],
                title: top_blogs[0][:title],
                views: top_blogs[0][:blog_views],
                redirect_to: 'blogs'

            } if top_blogs.present?
            
            page_views << {
                id: top_tutorials.first.id,
                title: top_tutorials.first.title,
                views: top_tutorials.first.tutorial_views.count,
                redirect_to: 'tutorials'
            } if top_tutorials.present?
            
            page_views << {
                id: top_forums.first.id,
                title: top_forums.first.title,
                views: top_forums.first.views.count,
                redirect_to: 'forums'
            } if top_forums.present?
            
            page_views << {
                id: top_collection[0],
                title: collection_title,
                views: top_collection[1],
                redirect_to: 'product_library'
            } if top_collection.present?
            
            page_views << {
                id: top_live_video.id,
                title: top_live_video.title,
                views: top_live_video.video_views.count,
                redirect_to: 'live_video'
            } if top_live_video.present?

            render json: {
                page_views: page_views,
                blogs: {
                    blogs_count: blogs.count,
                    top_blogs: top_blogs
                },
                tutorials: {
                    tutorial_views_count: tutorials_views.count,
                    top_tutorials: serialized_tutorials,
                },
                forums: serialized_top_forums,
                top_users: serialzed_users
            }
        end

    end
end