module BxBlockContentmanagement
    class HomePageViewsController < ApplicationController
        
        before_action :get_user

        def create
            @home_page_view = @user.home_page_view
            @home_page_view = @user.create_home_page_view unless @home_page_view.present?
            @home_page_view.increment(:view_count).save! if @home_page_view.updated_at < Time.now.beginning_of_day || @home_page_view.view_count == 0
            render json: {success: true}
        end

        private

        def get_user
            @user = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
            @user = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
            render json: {errors: {message: 'User is invalid'}} and return unless @user.present?
        end

    end
end