module BxBlockSocialClubs
  class MyClubEventsSerializer < BuilderBase::BaseSerializer

    attributes :event_name, :id, :location

    attribute :images do |object, params|
      if params[:skip_images].blank? && object.images.attached?
        object.images.map{|a| a.service_url}
      end
    end

    attribute :club do |object|
      object.social_club&.name
    end

    attribute :start_date do |object|
      object.start_date_and_time.strftime("%d/%m/%Y") if object.start_date_and_time.present?
    end

    attribute :start_time do |object|
      object.start_date_and_time.strftime("%H:%M:%S") if object.start_date_and_time.present?
    end

    attribute :end_date do |object|
      object.end_date_and_time&.strftime("%d/%m/%Y")
    end

    attribute :end_time do |object|
      object.end_date_and_time&.strftime("%H:%M:%S")
    end

    attribute :fee_amount do |object|
      # if object.is_visible?
      #   'FREE'
      # else
      #   ActionController::Base.helpers.number_to_currency(
      #     Money.new(object.fee_amount_cents, object.fee_currency)
      #   )
      # end
      object.fee_amount_cents
    end

    attributes :fee_currency do |object|
      object.fee_currency
    end

    attribute :club_admin do |object, params|
      if params[:current_user].present?
        object.social_club.is_club_admin?(params[:current_user].id)
      else
        false
      end
    end

    attribute :joined_club do |object, params|
      if params[:current_user].present?
        object.social_club.account_social_clubs.where(account_id: params[:current_user].id).exists?
      else
        false
      end
    end

    attribute :joined_event do |object, params|
      if params[:current_user].present?
        object.club_event_accounts.find_by(account_id: params[:current_user].id).present?
      else
        false
      end
    end

    attribute :city do |object|
      object&.city
    end
    
  end
end
