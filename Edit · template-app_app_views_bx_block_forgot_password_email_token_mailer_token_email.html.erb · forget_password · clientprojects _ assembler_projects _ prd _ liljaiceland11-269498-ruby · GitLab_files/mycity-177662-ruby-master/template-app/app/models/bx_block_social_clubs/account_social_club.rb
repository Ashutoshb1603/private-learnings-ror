module BxBlockSocialClubs
  class AccountSocialClub < ApplicationRecord
    self.table_name = :account_social_clubs

    belongs_to :account, class_name: "AccountBlock::Account"
    belongs_to :social_club, class_name: "BxBlockSocialClubs::SocialClub"
    validates_uniqueness_of :account_id, {scope: [:social_club_id], message: "already exist in this Club." }
  end
end