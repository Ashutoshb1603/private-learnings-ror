module BxBlockCommunityforum
    class QuestionsController < ApplicationController

        before_action :get_user

        def index
            if params[:sort] == "recommended"
                questions = Question.active.non_offensive.order('recommended DESC, created_at DESC')
            elsif params[:sort] == "popular"
                questions = Question.active.non_offensive.joins(:likes).group(:id).order('count(likes.id) DESC')
            else
                questions = Question.active.non_offensive.order('created_at DESC')
            end
            questions = questions.where('user_type != ?', Question.user_types["elite"]) if @user.type != "AdminAccount" and (@user.membership_plan[:plan_type] == "free" or @user.membership_plan[:plan_type] == "glow_getter")
            questions = questions.search(params[:search]) if params[:search].present?
            begin
                paginated_questions = pagy(questions, page: params[:page], items: 10)
            rescue Pagy::OverflowError => error
                render json: {message: "Page doesn't exist", error: error}, status: 404
            else 
                render json: QuestionsSerializer.new(paginated_questions.second, params: {current_user: @user}, meta: {page_data: paginated_questions.first}).serializable_hash
            end
        end

        def create
            question = @user.questions.new(question_params)
            if question.save
                render json: QuestionsSerializer.new(question, params: {current_user: @user}).serializable_hash
            else
                render json: {message: "Question can't be saved", errors: question.errors}, status: 400
            end
        end

        def update
            question = Question.find(params[:id])
            if question.update(question_params)
                render json: QuestionsSerializer.new(question, params: {current_user: @user}).serializable_hash
            else
                render json: {message: "Question can't be updated", errors: question.errors}, status: 400
            end
        end
        
        def show
            question = Question.find(params[:id])
            views = question.views.where('accountable_id = ? and created_at > ?', @user.id, (Time.now - 24.hours))
            accountable_type = 'AccountBlock::Account' unless @token.account_type == "AdminAccount"
            accountable_type = "AdminUser" if @token.account_type == "AdminAccount"
            question.views.create(accountable_id: @user.id, accountable_type: accountable_type) unless views.present?
            render json: QuestionsSerializer.new(question, params: {current_user: @user}).serializable_hash
        end

        def like
            question = Question.find(params[:id])
            account = question.accountable
            accountable_type = 'AccountBlock::Account' unless @token.account_type == "AdminAccount"
            accountable_type = "AdminUser" if @token.account_type == "AdminAccount"
            like = question.likes.find_or_initialize_by(accountable_id: @user.id, accountable_type: accountable_type)
            like.persisted? ? like.destroy : like.save
            payload_data = {account: account, notification_key: 'like_post', inapp: true, push_notification: false, type: 'skin_hub', created_by: @user.id, redirect: 'forum_view_post', record_id: question.id, notification_for: 'post', key: 'forum'}
            BxBlockPushNotifications::FcmSendNotification.new("#{@user.name} has liked your post", "Liked a post", account.device_token, payload_data).call if @user.present?
            # ActionCable.server.broadcast "question#{params[:id]}", data: BxBlockCommunityforum::QuestionsSerializer.new(question, params: {current_user: @user}).serializable_hash[:data]
            # ActionCable.server.broadcast "question", data: BxBlockCommunityforum::QuestionsSerializer.new(question, params: {current_user: @user}).serializable_hash[:data]
            render json: QuestionsSerializer.new(question, params: {current_user: @user}).serializable_hash
        end

        def saved
            question = Question.find(params[:id])
            accountable_type = 'AccountBlock::Account' unless @token.account_type == "AdminAccount"
            accountable_type = "AdminUser" if @token.account_type == "AdminAccount"
            saved = question.saved.find_or_initialize_by(accountable_id: @user.id, accountable_type: accountable_type)
            saved.persisted? ? saved.destroy : saved.save
            render json: QuestionsSerializer.new(question, params: {current_user: @user}).serializable_hash
        end

        def comment
            question = Question.find(params[:id])
            account = question.accountable
            accountable_type = 'AccountBlock::Account' unless @token.account_type == "AdminAccount"
            accountable_type = "AdminUser" if @token.account_type == "AdminAccount"
            comment = question.comments.create(accountable_id: @user.id, description: params["data"]["description"],accountable_type: accountable_type, image: params["data"]["image"])
            payload_data = {account: account, notification_key: 'comment_on_post', inapp: true, push_notification: false, type: 'skin_hub', created_by: @user.id, redirect: "view_comment", record_id: comment.id, notification_for: 'comment', key: 'forum'}
            BxBlockPushNotifications::FcmSendNotification.new("#{@user.name} has just commented on your post, #{question.title}", "Commented on post", account.device_token, payload_data).call
            # ActionCable.server.broadcast "question#{params[:id]}", data: CommentsSerializer.new(comment, params: {current_user: @user}).serializable_hash[:data]
            # ActionCable.server.broadcast "question", data: BxBlockCommunityforum::QuestionsSerializer.new(question, params: {current_user: @user}).serializable_hash[:data]
            render json: CommentsSerializer.new(comment, params: {current_user: @user}).serializable_hash
        end

        def paginate_questions(questions, page, user)
            page = 1 if page.nil?
            begin
                paginated_questions = pagy(questions.non_offensive.order('created_at DESC'), page: page, items: 10)
            rescue Pagy::OverflowError => error
                {
                    "data": []
                }
            else 
                QuestionsSerializer.new(paginated_questions.second, params: {current_user: user}, meta: {page_data: paginated_questions.first}).serializable_hash
            end
        end

        def report
            question = Question.find(params[:id])
            report = @user.reports.find_or_initialize_by(reportable: question)
            message = report.persisted? ? "unflagged" : "flagged"
            report.persisted? ? report.destroy : report.save
            render json: {message: "Post #{message}!"}
        end

        def destroy
            question = Question.find(params[:id])
            question.destroy
            render json: {message: "Question deleted!"}
        end

        private
        def question_params
            params["data"].require("attributes").permit(:title, :description, :status, :anonymous, images: [], group_ids: [])
        end

        def get_user
            @user = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
            @user = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
            render json: {errors: {message: 'User is invalid'}} and return unless @user.present?
        end
    end
end