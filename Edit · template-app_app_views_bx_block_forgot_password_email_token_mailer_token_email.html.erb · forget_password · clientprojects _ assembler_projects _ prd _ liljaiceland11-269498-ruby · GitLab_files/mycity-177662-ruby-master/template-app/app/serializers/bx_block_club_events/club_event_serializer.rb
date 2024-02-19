module BxBlockClubEvents
    class ClubEventSerializer < BuilderBase::BaseSerializer
  
      attributes *[ :social_club_id, :event_name, :social_club_name, :location, :is_visible, :activity_ids,
                    :travel_item_ids, :max_participants, :min_participants,
                    :description, :age_should_be, :created_at, :updated_at
      ]  
      
      attributes :activity_ids do |object|
        object.activities&.as_json
      end

      attributes :travel_item_ids do |object|
        object.travel_items&.as_json
      end

      attributes :social_club_name do |object|
        object.social_club&.name
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

      attributes :images do |object|        
        if object.images&.attached?
          image_urls = object.images&.map do |image| 
            image.service_url rescue nil
          end      
          image_urls
        end
      end

      attributes :start_date_and_time do |object|
        object.start_date_and_time&.strftime("%d/%m/%Y")
      end

      attributes :end_date_and_time do |object|
        object.end_date_and_time&.strftime("%d/%m/%Y")
      end

      attributes :start_time do |object|
        object.start_date_and_time&.strftime("%H:%M:%S")
      end

      attributes :end_time do |object|
        object.end_date_and_time&.strftime("%H:%M:%S")
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