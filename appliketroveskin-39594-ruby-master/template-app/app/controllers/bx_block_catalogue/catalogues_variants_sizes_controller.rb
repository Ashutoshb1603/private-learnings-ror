module BxBlockCatalogue
  class CataloguesVariantsSizesController < ApplicationController
    def create
      sizes = CatalogueVariantSize.new(name: params[:name])
      save_result = sizes.save

      if save_result
        render json: CatalogueVariantSizeSerializer.new(sizes)
                         .serializable_hash,
               status: :created
      else
        render json: {errors: {message: sizes.errors.full_messages}},
               status: :unprocessable_entity
      end
    end

    def index
      serializer = CatalogueVariantSizeSerializer.new(CatalogueVariantSize.all)

      render json: serializer, status: :ok
    end
  end
end
