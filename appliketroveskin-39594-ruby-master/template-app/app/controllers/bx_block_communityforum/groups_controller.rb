module BxBlockCommunityforum
    class GroupsController < ApplicationController

        before_action :get_user

        def index
            groups = Group.active

            data = groups.select( "groups.id, groups.title, count(question_tags.id) AS posts_count").joins( "LEFT OUTER JOIN question_tags ON question_tags.group_id = groups.id").group("groups.id")
            begin
                paginated_groups = pagy(data, page: params[:page], items: 10)
            rescue Pagy::OverflowError => error
                render json: {message: "Page doesn't exist", error: error}, status: 404
            else 
                render json: {groups: paginated_groups.second, meta: paginated_groups.first}
            end
        end

        def show
            group = Group.find(params[:id])
            questions = group.questions.active.non_offensive.order('created_at DESC')
            if @token.account_type != "AdminAccount"
                questions = questions.where('user_type != ?', Question.user_types["elite"]) if @user.membership_plan[:plan_type] == "free" or @user.membership_plan[:plan_type] == "glow_getter"
            end

            begin
                paginated_questions = pagy(questions, page: params[:page], items: 10)
            rescue Pagy::OverflowError => error
                render json: {message: "Page doesn't exist", error: error}, status: 404
            else 
                render json: QuestionsSerializer.new(paginated_questions.second, params: {current_user: @user}, meta: {page_data: paginated_questions.first}).serializable_hash
            end
            # render json: QuestionsSerializer.new(group.questions, params: {current_user: @user}).serializable_hash
        end

        def create
            if @user.type == "AdminAccount"
                group = Group.new(params["data"].require(:attributes).permit(:title))
                if group.save
                    render json: {status: 'success', message: "New tag added successfully"}, status: :ok
                else
                    render json: {status: 'failed', message: "New tag can't be added", errors: group.errors}, status: 422
                end
            else 
                render json: {errors: {message: 'Need admin access to create groups'}}
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