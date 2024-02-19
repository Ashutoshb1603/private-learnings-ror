module BxBlockAdmin
  module PostsModeration
    class OffensiveCommentsController < ApplicationController
      before_action :current_user

      def index
        begin
          offensive_comments = pagy(BxBlockCommunityforum::Comment.where('offensive = true').order('created_at DESC'), page: params[:page], items: 10)
        rescue Pagy::OverflowError => error
          render json: {message: "Page doesn't exist", error: error}, status: 404
        else
          render json: BxBlockAdmin::OffensiveCommentSerializer.new(offensive_comments.second, params: {current_user: @user}, meta: {page_data: offensive_comments.first}).serializable_hash, status: :ok
        end
      end

      def approve
        comment = BxBlockCommunityforum::Comment.find(params[:id])
        comment.update(offensive: false)
        payload_data = {account: comment.accountable, notification_key: 'offensive_comment', inapp: true, push_notification: true, redirect: 'forum_feed', record_id: comment.id, notification_for: 'comment', key: 'forum'}
        BxBlockPushNotifications::FcmSendNotification.new("Your comment on #{comment&.objectable&.title} has been approved.", "Comment approved", comment.accountable.device_token, payload_data).call
        render json: {message: "Comment approved successfully"}, status: :ok
      end

      def destroy
        comment = BxBlockCommunityforum::Comment.find_by(id: params[:id])
        begin
          account = comment.accountable
          title = comment&.objectable&.title
          if comment.destroy
            payload_data = {account: account, notification_key: 'offensive_comment', inapp: true, push_notification: true, redirect: "forum_feed", notification_for: 'comment', key: 'forum'}
            BxBlockPushNotifications::FcmSendNotification.new("Unfortunately your comment has not been approved.", "Offensive Comment", account.device_token, payload_data).call
            render json: {message: "Comment deleted successfully"}, status: :ok
          end
        rescue ActiveRecord::InvalidForeignKey
          message = "Record can't be deleted due to reference to a catalogue " \
                    "record"

          render json: {
            errors: { message: message }
          }, status: :internal_server_error
        end
      end

    end
  end
end
