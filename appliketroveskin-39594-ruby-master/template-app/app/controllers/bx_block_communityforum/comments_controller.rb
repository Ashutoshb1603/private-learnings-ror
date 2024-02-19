module BxBlockCommunityforum
    class CommentsController < ApplicationController
        
        before_action :get_user

        def show
            comment = Comment.find(params[:id])
            render json: CommentsSerializer.new(comment, params: {current_user: @user}).serializable_hash
        end

        def like
            comment = Comment.find(params[:id])
            accountable_type = 'AccountBlock::Account' unless @token.account_type == "AdminAccount"
            accountable_type = "AdminUser" if @token.account_type == "AdminAccount"
            like = comment.likes.find_or_initialize_by(accountable_id: @user.id, accountable_type: accountable_type)
            account = comment.accountable
            like.persisted? ? like.destroy : like.save
            payload_data = {account: account, notification_key: 'like_comment', inapp: true, push_notification: false, type: 'skin_hub', created_by: @user.id, redirect: "view_comment", record_id: comment.id, notification_for: 'comment', key: 'forum'}
            BxBlockPushNotifications::FcmSendNotification.new("#{@user.name} has liked your comment", "Liked a comment", account.device_token, payload_data).call if @user.present?
            serializer = comment.objectable_type == "BxBlockCommunityforum::Question" ? "Comments" : "Replies"
            render json: "BxBlockCommunityforum::#{serializer}Serializer".constantize.new(comment, params: {current_user: @user}).serializable_hash
        end

        def reply
            comment = Comment.find(params[:id])
            accountable_type = 'AccountBlock::Account' unless @token.account_type == "AdminAccount"
            accountable_type = "AdminUser" if @token.account_type == "AdminAccount"
            reply = comment.comments.create(accountable_id: @user.id, accountable_type: accountable_type, description: params["data"]["description"], image: params["data"]["image"])
            account = comment.accountable
            payload_data = {account: account, notification_key: 'replied_on_post', inapp: true, push_notification: false, type: 'skin_hub', created_by: @user.id, redirect: 'forum_view_post', record_id: comment.id, notification_for: 'comment', key: 'forum'}
            BxBlockPushNotifications::FcmSendNotification.new("#{@user.name} has replied to your post", "Replied on post", account.device_token, payload_data).call if @user.present?
            # ActionCable.server.broadcast "comment#{params[:id]}", data: CommentsSerializer.new(reply, params: {current_user: @user}).serializable_hash[:data]
            render json: RepliesSerializer.new(reply, params: {current_user: @user}).serializable_hash
        end

        def report
            comment = Comment.find(params[:id])
            report = @user.reports.find_or_initialize_by(reportable: comment)
            message = report.persisted? ? "unflagged" : "flagged"
            report.persisted? ? report.destroy : report.save
            render json: {message: "Comment #{message}!"}
        end

        def update
            @comment = Comment.find(params[:id])
            @comment.update_attributes(comment_params)
            @comment.save
            render json: CommentsSerializer.new(@comment, params: {current_user: @user}).serializable_hash
        end

        def destroy
            @comment = Comment.find(params[:id])
            @comment.destroy
            render json: {message: "Comment deleted!"}
        end

        private

        def comment_params
            params.require(:data).permit(:description, :image)
        end

        def get_user
            @user = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
            @user = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
            render json: {errors: {message: 'User is invalid'}} and return unless @user.present?
        end
    end
end