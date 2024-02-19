module BxBlockContentmanagement
    class TutorialsController < ApplicationController

        before_action :get_user

        def index
            begin
                tutorials = Tutorial.order('created_at DESC')
                tutorials = tutorials.where(group_id: params[:group_id]) if params[:group_id].present?
                tutorials = tutorials.search(params[:search_params]) if params[:search_params].present?
                paginated_tutorials = pagy(tutorials, page: params[:page], items: 10)
            rescue Pagy::OverflowError => error
                render json: {message: "Page doesn't exist", error: error}, status: 404
            else 
                render json: TutorialsSerializer.new(paginated_tutorials.second, params: {current_user: @user}, meta: {page_data: paginated_tutorials.first}).serializable_hash
            end
        end

        def show
            tutorial = Tutorial.find(params[:id])
            tutorial_views = tutorial.tutorial_views.where('account_id = ? and created_at > ?', @user.id, (Time.now - 24.hours))
            tutorial.tutorial_views.create(account_id: @user.id) unless tutorial_views.present?
            render json: TutorialsSerializer.new(tutorial, params: {current_user: @user}).serializable_hash
        end

        def like
            tutorial = Tutorial.find(params[:id])
            like = tutorial.tutorial_likes.find_or_initialize_by(account_id: @user.id)
            like.persisted? ? like.destroy : like.save
            render json: TutorialsSerializer.new(tutorial, params: {current_user: @user}).serializable_hash
        end

        private
        def get_user
            @user = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
            @user = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
            render json: {errors: {message: 'User is invalid'}} and return unless @user.present?
        end
    end
end
