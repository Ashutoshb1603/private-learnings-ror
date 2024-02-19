module BxBlockAdmin
  module PostsModeration
    class BadWordsetsController < ApplicationController
      before_action :current_user

      def index
        bad_word = BxBlockCommunityforum::BadWordset.first
        render json: BxBlockAdmin::BadWordsetSerializer.new(bad_word).serializable_hash,
          status: :ok
      end

      def update
        if bad_word = BxBlockCommunityforum::BadWordset.first
          bad_word.update(words: params[:words])
          render json: BxBlockAdmin::BadWordsetSerializer.new(bad_word).serializable_hash,
          status: :ok
        else
          ActiveRecord::Base.transaction do
            bad_word = BxBlockCommunityforum::BadWordset.create(words: params[:words])
          end
          render json: BxBlockAdmin::BadWordsetSerializer.new(bad_word).serializable_hash,
          status: :ok
        end
      end

    end
  end
end
