module BxBlockAdmin
  module PostsModeration
    class OffensiveQuestionsController < ApplicationController
      before_action :current_user

      def index
        begin
          offensive_questions = pagy(BxBlockCommunityforum::Question.where('offensive = true').order('created_at DESC'), page: params[:page], items: 10)
        rescue Pagy::OverflowError => error
          render json: {message: "Page doesn't exist", error: error}, status: 404
        else
          render json: BxBlockAdmin::OffensiveQuestionSerializer.new(offensive_questions.second, params: {current_user: @user}, meta: {page_data: offensive_questions.first}).serializable_hash, status: :ok
        end
      end

      def approve
        question = BxBlockCommunityforum::Question.find_by(id: params[:id])
        question.update(offensive: false)
        payload_data = {account: question.accountable, notification_key: 'offensive_post', inapp: true, push_notification: true, redirect: 'forum_feed', record_id: question.id, notification_for: 'post', key: 'forum'}
        BxBlockPushNotifications::FcmSendNotification.new("Your post #{question.title} has been approved.", "Post approved", question.accountable.device_token, payload_data).call if question.title.present?
        render json: {message: "Post approved successfully"}, status: :ok
      end

      def destroy
        question = BxBlockCommunityforum::Question.find_by(id: params[:id])
        begin
          account = question.accountable
          title = question.title
          if question.destroy
            payload_data = {account: account, notification_key: 'offensive_post', inapp: true, push_notification: true, redirect: 'forum_feed', notification_for: 'post', key: 'forum'}
            BxBlockPushNotifications::FcmSendNotification.new("Your post #{title} has been denied.", "Post denied", account.device_token, payload_data).call
            render json: {message: "Post deleted successfully"}, status: :ok
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
