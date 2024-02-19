module BxBlockCatalogue
  class AdvertisementsController < ApplicationController
    before_action :set_advertisement, only: :update
    before_action :current_user
    def index
      if params[:country].present?
        advertisement = Advertisement.where(country: params[:country])
      else
        advertisement = Advertisement.where(country: "Ireland")
      end
      serializer = AdvertisementSerializer.new(advertisement.active)

      render json: serializer, status: :ok
    end

    def update
      BxBlockSkinClinic::PageClick.increment_click_count(@current_user, @advertisement)
      render json: AdvertisementSerializer.new(@advertisement), status: :ok
    end

    private

    def set_advertisement
      @advertisement = Advertisement.find_by(id: params[:id])
      if @advertisement.nil?
        render json: {
          errors: {message: "Advertisement with id #{params[:id]} doesn't exists"}
        }, status: :not_found
      end
    end
  end
end