module AccountBlock
    class StoryController < ApplicationController
        before_action :validate_json_web_token
        before_action :get_user
        before_action :check_valid_user, except: [:index, :show]
        before_action :is_freezed
        include BuilderJsonWebToken::JsonWebTokenValidation

        def index 
            accounts = AccountBlock::Account.joins(:stories).where('stories.created_at >= ?', 24.hours.ago).order('stories.created_at DESC')
            # stories = Story.where('created_at >= ? and objectable_id != ?', 24.hours.ago, @account.id)
            # stories = stories.where(target: ["all_users", @account.membership_plan[:plan_type]]) unless @account.role.name.downcase == "therapist"
            # stories = stories.where(target: "all_users") if @account.role.name.downcase == "therapist"
            admin_accounts = AdminUser.joins(:stories).where('stories.created_at >= ?', 24.hours.ago).order('stories.created_at DESC')
            admin_accounts = admin_accounts.uniq
            accounts = accounts.uniq
            accounts.reject! {|a| (a.stories.where('stories.created_at >= ?', 24.hours.ago).first.target != "all_users" and a.stories.first.target != @account.membership_plan[:plan_type])} if @account.role.name.downcase == "user"
            admin_accounts.reject! {|a| (a.stories.where('stories.created_at >= ?', 24.hours.ago).first.target != "all_users" and a.stories.first.target != @account.membership_plan[:plan_type])} if @account.role.name.downcase == "user"
            accounts = accounts + admin_accounts
            render json: StoryIndexSerializer.new(accounts, params: {current_user: @account}).serializable_hash
        end

        def create
            story = @account.stories.create(story_params)
            render json: StoriesSerializer.new(story, params: {current_user: @account}).serializable_hash
        end

        def destroy
            story = Story.find(params[:id])
            story.destroy
            render json: {message: "Deleted succesfully!"}
        end

        def show
            story = Story.find(params[:id])
            @account.story_views.find_or_create_by(story_id: story.id) unless @account == story.objectable
            render json: StoriesSerializer.new(story, params: {current_user: @account}).serializable_hash
        end

        def my_stories
            stories = Story.where(objectable_id: @account.id)
            render json: StoriesSerializer.new(stories, params: {current_user: @account}).serializable_hash
        end

        private
        def get_user
            @account = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
            @account = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
            @account
        end
      
        def check_valid_user
            errors = []
            errors = ['Account is not associated to a therapist or an admin'] unless (@account.role.name.downcase == "therapist" and @account.acuity_calendar.present?) or @account.type == "AdminAccount"
            render json: {errors: errors} unless errors.empty?
        end

        def story_params
            params["data"].require(:attributes).permit(:target, :video)
        end

    end

end