module BxBlockSocialClubs
  class SocialClubSerializer < BuilderBase::BaseSerializer

    attributes *[:name,
                 :description,
                 :community_rules,
                 :location,
                 :is_visible,
                 :user_capacity,                
                 :bank_name,
                 :bank_account_name,
                 :bank_account_number,
                 :routing_code,
                 :language,
                 :created_at,
                 :updated_at,
                 :status,
                 :account_id
    ]  
    
    attributes :interests do |object|
      object.interests.as_json
    end

    attributes :fee_amount do |object|
      # ActionController::Base.helpers.number_to_currency(
      #   Money.new(object.fee_amount_cents, object.fee_currency)
      # )
      object.fee_amount_cents
    end

    attributes :fee_currency do |object|
      object.fee_currency
    end

    attribute :joined_club do |object, params|
      if params[:current_user].present?
        object.account_social_clubs.find_by(account_id: params[:current_user].id).present?
      else
        false
      end
    end

    attribute :participant_count do |object|
      object.account_social_clubs.count
    end

    attribute :events_count do |object|
      object.club_events.count
    end

    attribute :places_count do |object|
      object.club_events.where('location IS NOT NULL').count
    end

    attribute :club_type do |object|
      object.is_visible ? 'Public' : 'Private'
    end

    attribute :activities do |object|
      activities = []
      object.club_events.each do |event|
        activities += event.activities.as_json
        break if activities.length >= 5
      end
      activities
    end

    attribute :travel_items do |object|
      items = []
      object.club_events.each do |event|
        items += event.travel_items.as_json
        break if items.length >= 5
      end
      items
    end

    attribute :city do |object|
      object&.city
    end

  end
end
