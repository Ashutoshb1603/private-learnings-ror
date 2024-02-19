module BxBlockClubEvents
    class TicketEventSerializer < BuilderBase::BaseSerializer
  
      attributes *[ :club_event_id, :id]  
      
      attribute :order_id do |object|
        object.unique_code
      end

      attribute :name do |object|
        object.account.full_name
      end

      attributes :activities do |object|
        object.club_event.activities&.as_json
      end

      attribute :location do |object|
        object.club_event.location
      end

      attribute :event_name do |object|
        object.club_event.event_name
      end

      attribute :club_name do |object|
        object.social_club.name
      end

      attribute :participant_count do |object|
        object.club_event.club_event_accounts.count
      end
      
      attribute :participant_images do |object|
        images = []
        participants = object.club_event.accounts.joins(:image_attachment).limit(6)
        images = participants.map{|a| a&.image&.service_url} if participants.exists?
        if images.length < 6
          if object.club_event.club_event_accounts.count < 6
            images.length.upto(object.club_event.club_event_accounts.count) do
              images << nil
            end
          else
            images.length.upto(5) do
              images << nil
            end
          end
        end
        images
      end

      attributes :fee_amount do |object|
        object.club_event.fee_amount_cents
      end

      attributes :fee_currency do |object|
        object.club_event.fee_currency
      end

      attributes :images do |object|        
        if object.club_event.images&.attached?
          image_urls = object.club_event.images&.map do |image| 
            image.service_url rescue nil
          end      
          image_urls
        end
      end

      attributes :start_date do |object|
        object.club_event.start_date_and_time&.strftime("%d/%m/%Y")
      end

      attributes :start_time do |object|
        object.club_event.start_date_and_time&.strftime("%H:%M:%S")
      end

      attributes :end_date do |object|
        object.club_event.end_date_and_time&.strftime("%d/%m/%Y")
      end

      attributes :end_time do |object|
        object.club_event.end_date_and_time&.strftime("%H:%M:%S")
      end

      attribute :description do |object|
        object.club_event.description
      end

      attribute :city do |object|
        object.club_event.city
      end

    end
  end