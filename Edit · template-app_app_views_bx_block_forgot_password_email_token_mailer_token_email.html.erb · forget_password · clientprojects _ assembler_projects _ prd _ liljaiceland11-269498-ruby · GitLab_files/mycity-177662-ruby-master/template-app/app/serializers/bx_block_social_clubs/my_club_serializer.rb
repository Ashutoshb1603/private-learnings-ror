module BxBlockSocialClubs
  class MyClubSerializer < BuilderBase::BaseSerializer

    attributes :name, :id

    attribute :images do |object, params|
      if params[:skip_images].blank? && object.images.attached?
        object.images.map{|a| a.service_url}
      end
    end
    
    attribute :club_type do |object|
      object.is_visible ? 'Public' : 'Private'
    end

    attribute :participant_count do |object|
      object.account_social_clubs.count
    end

    attribute :participant_images do |object|
      images = []
      participants = object.accounts.joins(:image_attachment).limit(6)
      images = participants.map{|a| a&.image&.service_url} if participants.exists?
      if images.length < 6
        if object.account_social_clubs.count < 6
          images.length.upto(object.account_social_clubs.count) do
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

    attribute :interests do |object|
      object.interests.limit(5).as_json
    end

    attributes :fee_amount do |object|
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
        object.is_club_admin?(params[:current_user].id)
      else
        false
      end
    end

    attribute :joined_club do |object, params|
      if params[:current_user].present?
        object.account_social_clubs.where(account_id: params[:current_user].id).exists?
      else
        false
      end
    end

    attribute :city do |object|
      object&.city
    end

  end
end
