module BxBlockSocialClubs
    class AccountSocialClubsSerializer < BuilderBase::BaseSerializer
        attributes *[ :social_club_id, :account_id, :email, :full_name, :image, :created_at, :updated_at ]
        
        attribute :email do |object|
            object.account&.email
        end

        attribute :full_name do |object|
            object.account&.full_name
        end

        attributes :image do |object|
          object.account&.image&.attached? ? object.account.image.service_url : nil
        end
    end
end