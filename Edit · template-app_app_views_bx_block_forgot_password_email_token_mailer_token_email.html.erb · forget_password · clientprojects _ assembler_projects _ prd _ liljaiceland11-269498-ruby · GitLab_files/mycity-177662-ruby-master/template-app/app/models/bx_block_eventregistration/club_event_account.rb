module BxBlockEventregistration
  class ClubEventAccount < ApplicationRecord
    self.table_name = :club_event_accounts

    belongs_to :account, class_name: "AccountBlock::Account"
    belongs_to :club_event, class_name: "BxBlockClubEvents::ClubEvent"
    has_one :social_club, through: :club_event, class_name: "BxBlockSocialClubs::SocialClub"

    validates_uniqueness_of :account_id, {scope: [:club_event_id], message: "already registered in this event." }

    before_create :generate_unique_code_for_event

    def generate_unique_code_for_event
      loop do
        code = rand(1_00000..9_99999)
        next if BxBlockEventregistration::ClubEventAccount.where(club_event_id: self.club_event_id, unique_code: code).exists?
        self.unique_code  = code
        break
      end
    end
  end
end
