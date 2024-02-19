module BxBlockCommunityforum
    class Comment < ApplicationRecord
        self.table_name = :comments

        scope :non_offensive, -> {where(offensive: false)}
        scope :offensive, -> {where(offensive: true)}
        
        belongs_to :objectable, polymorphic: true
        # belongs_to :account, class_name: 'AccountBlock::Account'
        belongs_to :accountable, polymorphic: true
        has_many :likes, as: :objectable, class_name: 'BxBlockCommunityforum::Like', dependent: :destroy
        has_many :comments, as: :objectable, dependent: :destroy
        has_one_attached :image, dependent: :destroy
        has_many :reports, as: :reportable, class_name: 'BxBlockCommunityforum::Report', dependent: :destroy

        after_create :create_mentions
        before_create :remove_if_offensive

        after_create :log_activity
        before_destroy :remove_activity

        def remove_if_offensive
          words = []
          words = BxBlockCommunityforum::BadWordset.first.words.split(/[\n\r,]+/) if BxBlockCommunityforum::BadWordset.first.present?
          str = self.description.downcase
          str_arr = str.split(/[\n\r, ]+/).map(&:downcase)
          if words.any? { |word| str.downcase.include?(" " + word.downcase + " ") } || !(str_arr & words).empty?
            self.offensive = true 
            question = BxBlockCommunityforum::Question.find(self.objectable_id)
            payload_data = {account: self.accountable, notification_key: 'offensive_comment', inapp: true, push_notification: true, redirect: "forum_feed", record_id: self.id, notification_for: 'comment', key: 'forum'}
            BxBlockPushNotifications::FcmSendNotification.new("Your comment on #{question.title} is being reviewed.", "Offensive Comment", self.accountable.device_token, payload_data).call if self.description.present?
            CommentMailer.with(account: self.accountable, title: question.title).offensive_comment.deliver
          end
        end
    
        def log_activity
          action = self.objectable_type == "BxBlockCommunityforum::Question" ? "commented" : "replied"
          Activity.find_or_create_by(accountable_id: self.accountable_id, accountable_type: self.accountable_type, action: action, objectable: self, concern_mail_id: self.objectable.accountable.id)
        end
    
        def remove_activity
          Activity.where(objectable: self).destroy_all
        end

        def create_mentions
            reg = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
            emails = self.description.scan(reg).uniq

            emails.each do |email|
                account =  AccountBlock::Account.find_by_email(email)
                Activity.create(accountable_id: self.accountable_id, action: 'mentioned', objectable: self, concern_mail_id: account.id) unless account.nil?
            end
        end
    end
end
