module BxBlockChat
  class Chat < BxBlockChat::ApplicationRecord
    self.table_name = :chats
    has_one_attached :image
    has_many :accounts_chats,
             class_name: 'BxBlockChat::AccountsChatsBlock',
             dependent: :destroy
    has_many :accounts, through: :accounts_chats, class_name: 'AccountBlock::Account'
    has_many :messages, class_name: 'BxBlockChat::ChatMessage', dependent: :destroy
    belongs_to :social_club, class_name: "BxBlockSocialClubs::SocialClub"

    scope :multiple_user_chats, -> { where(chat_type: 1) }
    enum chat_type: { single_user: 0, multiple_user: 1}
    before_save :set_group_image

    def admin_accounts
      accounts_chats.where(status: :admin).includes(:accounts).pluck('accounts.id')
    end

    def last_admin?(account)
      accounts.include?(account.id) && accounts.count == 1
    end

    def set_group_image
      if image_updated?
        self.group_image = self.image&.service_url rescue nil
      else
        self.group_image = self.social_club&.images&.last&.service_url rescue nil
      end
    end

    def image_updated?
      self.image&.changed? rescue nil
    end
  end
end
