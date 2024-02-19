module BxBlockAdmin
  module PostsModeration
    class RepeatedOffendersController < ApplicationController
      before_action :current_user

      def index
        begin
          accounts = pagy(AccountBlock::Account.joins(:comments).where("comments.offensive = ?", true).order('created_at DESC'), page: params[:page], items: 10)
        rescue Pagy::OverflowError => error
          render json: {message: "Page doesn't exist", error: error}, status: 404
        else
          render json: BxBlockAdmin::RepeatedOffenderSerializer.new(accounts.second, params: {current_user: @user}, meta: {page_data: accounts.first}).serializable_hash, status: :ok
        end
      end

    end
  end
end
