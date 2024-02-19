module BxBlockCatalogue
  class BrandsController < ApplicationController
    def create
      brand = Brand.new(name: params[:name])
      save_result = brand.save

      if save_result
        render json: BrandSerializer.new(brand).serializable_hash,
               status: :created
      else
        render json: {errors: {message: brand.errors.full_messages}},
               status: :unprocessable_entity
      end
    end

    def index
      serializer = BrandSerializer.new(Brand.all)

      render json: serializer, status: :ok
    end
  end
end
