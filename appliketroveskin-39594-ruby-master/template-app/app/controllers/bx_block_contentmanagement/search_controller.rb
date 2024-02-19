module BxBlockContentmanagement
    class SearchController < ApplicationController
        include BxBlockShopifyintegration
        before_action :shopify_products
        before_action :shopify_blogs
        before_action :get_user

        # @@acuity = BxBlockAppointmentManagement::AcuityController.new

        def index
            recent_searches = RecentSearch.where(account_id: @user.id).order('id DESC').last(10)
            render json: RecentSearchesSerializer.new(recent_searches).serializable_hash
        end

        def search
            products = @@shopify_product.product_recommendation(@user, params[:search]) if params[:search].present?
            filtered_products = products[0..3] if params[:search].present? && products.present?
            blogs = @@shopify.blogs["blogs"]
            blog_id = "50963775523"
            blogs.each do |blog|
                blog_id = blog["id"] if blog["title"] == "Corinna's Corner"
            end
            blogs = @@shopify.articles(blog_id, "", params[:search])["articles"][0..3] if params[:search].present?
            questions = BxBlockCommunityforum::Question.search(params[:search]).limit(4) if params[:search].present?
            serialized_questions = BxBlockCommunityforum::QuestionsSerializer.new(questions, params: {current_user: @user})
            tutorials = Tutorial.search(params[:search]).limit(4) if params[:search].present?
            serialized_tutorials = TutorialsSerializer.new(tutorials, params: {current_user: @user})
            # consultations = @@acuity.appointment_types
            # consultations = consultations.select {|consultation| consultation["name"].downcase.include? params[:search].downcase} if params[:search].present?

            check_exist = RecentSearch.find_by(search_param: params[:search], account_id: @user.id)
            if !check_exist.present?
                search_data = RecentSearch.create(search_param: params[:search], account_id: @user.id)
            end
            data = {}
            data = data.merge(products: filtered_products, blogs: blogs, questions: serialized_questions, tutorials: serialized_tutorials)
            render json: data
        end

        def auto_suggest
            if params[:search].length > 1
                search = params[:search].gsub('(', "").gsub(')', '').gsub(/\d/, '').gsub('&', '').gsub('-', " ").split(/ /).last.downcase
                location = @user.location == "Uk" ? "uk_products" : "ireland_products"
                uri = URI.parse(ENV['REDIS_URL'])
                redis = Redis.new(host: uri.host)
                key = redis.get(location)
                encrypt_key = "MmNhYjUzYTA3Y2EwOWQxYjk5OWViMDlk"
                begin
                    crypt = ActiveSupport::MessageEncryptor.new(encrypt_key)
                    products = crypt.decrypt_and_verify(key)
                    titles = products.map{|prod| prod['title']}
                    keywords = []
                    titles.each do |title|
                        keywords += title.gsub('(', "").gsub(')', '').gsub(/\d/, '').gsub('&', '').gsub('-', " ").split(/ /)
                    end
                    titles = titles.select{|prod| prod.downcase.include?(params[:search].downcase)}
                    titles = titles.sort_by{|key| key.downcase.index(params[:search].downcase)}
                    keywords = keywords.uniq
                    keywords = keywords.select{|key| key.downcase.include?(search)}
                    keywords = keywords.sort_by{|key| key.downcase.index(search)}
                    render json: {keywords: keywords[0...3] + titles[0..3]}, status: 200
                rescue ActiveSupport::MessageEncryptor::InvalidMessage => e
                    return render json: {error: "list not updated"}, status: 422
                end
            else
                render json: {keywords: []}, status: 200
            end
        end

        private

        def get_user
            @user = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
            @user = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
            render json: {errors: {message: 'User is invalid'}} and return unless @user.present?
        end
    end
end
