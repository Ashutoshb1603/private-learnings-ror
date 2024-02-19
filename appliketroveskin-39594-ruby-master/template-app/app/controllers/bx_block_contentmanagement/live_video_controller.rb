module BxBlockContentmanagement
    class LiveVideoController < ApplicationController

        before_action :get_user

        def index
            begin
                videos = LiveVideo.active.order('created_at DESC')
                videos = videos.where(group_id: params[:group_id]) if params[:group_id].present?
                paginated_videos = pagy(videos, page: params[:page], items: 10)
            rescue Pagy::OverflowError => error
                render json: {message: "Page doesn't exist", error: error}, status: 404
            else 
                render json: LiveVideoSerializer.new(paginated_videos.second, params: {current_user: @user}, meta: {page_data: paginated_videos.first}).serializable_hash
            end
        end

        def show
            video = LiveVideo.find(params[:id])
            video_views = video.video_views.where('account_id = ? and created_at > ?', @user.id, (Time.now - 24.hours))
            video.video_views.create(account_id: @user.id) unless video_views.present?
            render json: LiveVideoSerializer.new(video, params: {current_user: @user}).serializable_hash
        end

        def like
            video = LiveVideo.find(params[:id])
            like = video.video_likes.find_or_initialize_by(account_id: @user.id)
            like.persisted? ? like.destroy : like.save
            render json: LiveVideoSerializer.new(video, params: {current_user: @user}).serializable_hash
        end

        private
        def get_user
            @user = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
            @user = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
            render json: {errors: {message: 'User is invalid'}} and return unless @user.present?
        end
    end
end