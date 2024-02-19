module BxBlockCatalogue
  class TagsController < ApplicationController
    before_action :current_user, only: :index
    def create
      tag = Tag.new(title: params[:title])
      save_result = tag.save

      if save_result
        render json: TagSerializer.new(tag).serializable_hash,
               status: :ok
      else
        render json: {errors: {message: tag.errors.full_messages}},
               status: :unprocessable_entity
      end
    end

    def index
      serializer = TagSerializer.new(Tag.all)

      render json: serializer, status: :ok
    end
  end
end
