module BxBlockCommunityforum
    class Question < ApplicationRecord
        self.table_name = :questions

        enum status: {'active': 1, 'draft': 2, 'removed': 3}
        enum user_type: {'free': 1, 'glow_getter': 2, 'therapist': 3, 'elite': 4, 'admin': 5}

        scope :non_offensive, -> {where(offensive: false)}
        scope :offensive, -> {where(offensive: true)}

        before_create :remove_if_offensive
        before_create :set_user_type

        has_many :question_tags, class_name: 'BxBlockCommunityforum::QuestionTag', dependent: :destroy
        has_many :groups, through: :question_tags, class_name: 'BxBlockCommunityforum::Group'
        has_many :saved, class_name: 'BxBlockCommunityforum::Saved', dependent: :destroy
        has_many :comments, as: :objectable, class_name: 'BxBlockCommunityforum::Comment', dependent: :destroy
        has_many :likes, as: :objectable, class_name: 'BxBlockCommunityforum::Like', dependent: :destroy
        has_many :views, class_name: 'BxBlockCommunityforum::View', dependent: :destroy
        # belongs_to :account, class_name: 'AccountBlock::Account'
        belongs_to :accountable, polymorphic: true
        has_many_attached :images, dependent: :destroy
        has_many :reports, as: :reportable, class_name: 'BxBlockCommunityforum::Report', dependent: :destroy

        accepts_nested_attributes_for :groups

        def self.search(value)
            if value.present?
              results = self.joins(:groups).
                        where("groups.title ilike '%#{value}%' 
                              or questions.title ilike '%#{value}%' 
                              or questions.description ilike '%#{value}%'").distinct
            end
            results
        end

        def set_user_type
            self.user_type = self.accountable.membership_plan[:plan_type] unless self.accountable.type == "AdminAccount"
            self.user_type = "admin" if self.accountable.type == "AdminAccount"
            self.user_type = "therapist" if self.accountable.role.name.downcase == "therapist"
        end

        def remove_if_offensive
            words = []
            flag = 0
            words = BxBlockCommunityforum::BadWordset.first.words.split(/[\n\r,]+/) if BxBlockCommunityforum::BadWordset.first.present?
            str = self.description.downcase
            str_arr = str.split(/[\n\r, ]+/).map(&:downcase)
            title = self.title
            title_arr = title.split(/[\n\r, ]+/)
            if words.any? { |word| str.downcase.include?(" " + word.downcase + " ") } || !(str_arr & words).empty?
                flag = 1
                self.offensive = true
            end
            if words.any? { |word| title.downcase.include?(word.downcase) } || !(title_arr & words).empty?
                flag = 1
                self.offensive = true
            end
            if flag == 1
                payload_data = {account: self.accountable, notification_key: 'offensive_post', inapp: true, push_notification: true, redirect: 'forum_feed', record_id: self.id, notification_for: 'post', key: 'forum'}
                BxBlockPushNotifications::FcmSendNotification.new("Your post #{self.title} is being reviewed.", "Post reviewed", self.accountable.device_token, payload_data).call if self.title.present?
                PostMailer.with(account: self.accountable, post: self.title).offensive_post.deliver
            end
        end
    end
end
