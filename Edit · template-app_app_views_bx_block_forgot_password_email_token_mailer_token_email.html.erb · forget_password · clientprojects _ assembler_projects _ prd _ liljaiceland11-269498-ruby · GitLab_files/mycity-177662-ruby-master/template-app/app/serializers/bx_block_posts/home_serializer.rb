module BxBlockPosts
  class HomeSerializer < BuilderBase::BaseSerializer

    attribute :images do |object|
      if object.searchable_type == 'Google Place'
        [object.google_place_url] if object.google_place_url.present?
      elsif object&.searchable&.images&.attached?
        object.searchable.images.map{|a| a.service_url}
      end
    end

    attribute :created_at do |object|
      if object.searchable_type == 'Google Place'
        object.created_at
      else
        object&.searchable&.created_at
      end
    end

    attribute :post_type do |object|
      object&.searchable_type
    end

    attribute :post_type_id do |object|
      object&.searchable_id
    end

    attribute :title do |object|
      object&.name
    end

    attribute :location do |object|
      object&.location
    end

    attributes :club_detail do |object, params|
      if object.searchable_type == 'BxBlockSocialClubs::SocialClub'
        BxBlockSocialClubs::MyClubSerializer.new(object&.searchable, {params: {skip_images: true, current_user: params[:current_user]}}).serializable_hash[:data][:attributes]
      end
    end

    attributes :event_detail do |object, params|
      if object.searchable_type == 'BxBlockClubEvents::ClubEvent'
        BxBlockSocialClubs::MyClubEventsSerializer.new(object&.searchable, {params: {skip_images: true, current_user: params[:current_user]}}).serializable_hash[:data][:attributes]
      end
    end

    attribute :latitude do |object|
      object.latitude
    end

    attribute :longitude do |object|
      object.longitude
    end    

  end
end
