module BxBlockCatalogue
  class AdvertisementSerializer < BuilderBase::BaseSerializer
    attributes :id, :url, :active, :country, :product_id, :appointment_id, :screen_route, :created_at, :updated_at

    attribute :screen_route do |object|
      response = "NavigationProductViewMessage" if object.product_id.present?
      response = "Consultation" if object.appointment_id.present?
      response
    end

    attribute :image do |object|
      get_image_url(object)
    end

    attribute :click_count do |object|
      BxBlockSkinClinic::PageClick.where(objectable: object).sum(:click_count)
    end
  end
end