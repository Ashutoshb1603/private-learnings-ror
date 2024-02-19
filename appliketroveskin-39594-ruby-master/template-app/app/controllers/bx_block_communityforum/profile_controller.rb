module BxBlockCommunityforum
    class ProfileController < ApplicationController
        
        before_action :get_user

        def index
            render json: ProfileSerializer.new(@user, params: {page: params[:page]}).serializable_hash
        end

        def show
            user = AccountBlock::Account.find(params[:id])
            render json: ProfileSerializer.new(user, params: {page: params[:page]}).serializable_hash
        end

        def saved
            begin
                paginated_questions = pagy(Question.where(id: @user.saved.pluck(:question_id)), page: params[:page], items: 10)
            rescue Pagy::OverflowError => error
                render json: {message: "Page doesn't exist", error: error}, status: 404
            else 
                render json: QuestionsSerializer.new(paginated_questions.second, params: {current_user: @user}, meta: {page_data: paginated_questions.first}).serializable_hash
            end
        end

        def my_activity
            activities = @user.activities.where.not(concern_mail_id: @user.id).order('created_at DESC')
            begin
                paginated_activities = pagy(activities, page: params[:page], items: 10)
            rescue Pagy::OverflowError => error
                render json: {message: "Page doesn't exist", error: error}, status: 404
            else 
                render json: ActivitiesSerializer.new(paginated_activities.second, params: {activity_type: "self"}, meta: {page_data: paginated_activities.first}).serializable_hash
            end
        end

        def activity
            activities = @user.user_activities.where.not(accountable: @user).order('created_at DESC')
            date = params[:start_date]
            activities = activities.where('created_at >= ?', Date.parse(date).beginning_of_day) unless date.nil?
            begin
                paginated_activities = pagy(activities, page: params[:page], items: 10)
            rescue Pagy::OverflowError => error
                render json: {message: "Page doesn't exist", error: error}, status: 404
            else 
                render json: ActivitiesSerializer.new(paginated_activities.second, params: {activity_type: "other_users"}, meta: {page_data: paginated_activities.first}).serializable_hash
            end
            # render json: ActivitiesSerializer.new(activities, params: {activity_type: "other_users"}).serializable_hash
        end

        private
        def get_user
            @user = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
            @user = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
            render json: {errors: {message: 'User is invalid'}} and return unless @user.present? or @token.account_type != "AdminAccount"
        end
    end
end