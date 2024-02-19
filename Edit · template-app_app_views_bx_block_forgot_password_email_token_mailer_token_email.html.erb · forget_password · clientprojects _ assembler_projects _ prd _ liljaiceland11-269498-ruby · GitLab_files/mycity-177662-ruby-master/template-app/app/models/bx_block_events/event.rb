module BxBlockEvents
  class Event < ApplicationRecord
    self.table_name = :events

    belongs_to :email_account, class_name: "AccountBlock::EmailAccount"

    validate :validate_event_date
    before_save :set_assignment_and_visibilities
    enum notify: ["One Day Before", "One Hour Before", "30 Minutes Before", "15 Minutes Before"]
    enum repeat: ["Never", "Every Day", "Every Week", "Every Month", "Every 2 Months", "Every Year", "Custom"]
    enum custom_repeat_every: ["day", "week", "month", "year"]
    validates :event_type, presence: true, inclusion: { in: ["Birthday", "School Drop Off", "School Pick Up", "Get Together", "Meeting", "Out for Coffee", "Gym", "Flight", "Doctor", "Vet", "Rent", "Fees", "Activity", "Custom"], message: "%{value} is not a valid event type" }

    before_save :visible_email_account
    scope :account_events, ->(account_id){ where("email_account_id = ? OR '?' = ANY(assign_to) OR '?' = ANY(visibility)", account_id, account_id, account_id)}

    def visible_email_account
      account = AccountBlock::Account.where(email: self.visible_email).map(&:id).map { |obj| obj = obj.to_s }
      self.visibility = (self.visibility + account).uniq
    end

    def event_occurance
      repeates_val = BxBlockEvents::Event.repeats.invert
      case true
      when repeat.eql?(repeates_val[1])
        schedule = IceCube::Schedule.new(now = date)
        schedule.add_recurrence_rule(IceCube::Rule.daily)
      when repeat.eql?(repeates_val[2])
        schedule = IceCube::Schedule.new(now = date)
        schedule.add_recurrence_rule(IceCube::Rule.weekly)
      when repeat.eql?(repeates_val[3])
        schedule = IceCube::Schedule.new(now = date)
        schedule.add_recurrence_rule(IceCube::Rule.monthly)
      when repeat.eql?(repeates_val[4])
        schedule = IceCube::Schedule.new(now = date)
        schedule.add_recurrence_rule(IceCube::Rule.monthly(2))
      when repeat.eql?(repeates_val[5])
        schedule = IceCube::Schedule.new(now = date)
        schedule.add_recurrence_rule(IceCube::Rule.yearly)
      when repeat.eql?(repeates_val[0])
        schedule = IceCube::Schedule.new(now = date)
        schedule.add_recurrence_rule(IceCube::Rule.daily.count(1))
      when repeat.eql?(repeates_val[6])
        schedule = IceCube::Schedule.new(now = date)
        rule = IceCube::Rule.daily(custom_repeat_in_number.to_i) if self.day?
        rule = IceCube::Rule.weekly(custom_repeat_in_number.to_i) if self.week?
        rule = IceCube::Rule.monthly(custom_repeat_in_number.to_i) if self.month?
        rule = IceCube::Rule.yearly(custom_repeat_in_number.to_i) if self.year?
        schedule.add_recurrence_rule(rule)
      end
      schedule
    end

    def check_event_occurance(from, to)
      schedule = event_occurance
      from = from.class.eql?(String) ? Date.parse(from) : from
      to = to.class.eql?(String) ? Date.parse(to) : to
      schedule.present? ? schedule.occurs_between?(from, to) : false
    end

    def set_assignment_and_visibilities
      if self.assign_to.include?("None")
        self.assign_to = []
      end

      if self.visibility.include?("None")
        self.visibility = []
      end
    end

    def validate_event_date
      if self.date_changed? || self.time_changed?
        errors.add(:event, "Past date and can not be accepted") if self.date < Date.today
        errors.add(:event, "Past time and can not be accepted") if self.date == Date.today && self.time.utc.strftime("%H:%M") < Time.now.utc.strftime("%H:%M")
      end
    end

    def visible_to_partner?(account)
      assign_and_rejected?(account) || assign_and_accepted?(account) || owner?(account) || visibility_to(account)
    end

    def assign_to?(account)
      self.assign_to.include?(account.id.to_s)
    end

    def visibility_to(account)
      self.visibility.include?(account.id.to_s)
    end

    def assign_and_pending?(account)
      assign_to?(account) && assign_account_request(account).present? && assign_account_request(account).pending?
    end

    def assign_and_accepted?(account)
      assign_to?(account) && assign_account_request(account).present? && assign_account_request(account).accept?
    end

    def assign_and_rejected?(account)
      assign_to?(account) && assign_account_request(account).present? && assign_account_request(account).decline?
    end

    def assign_account_request(account)
      requests.where(assignee_email: account.email, access_type: "assign").last
    end

    def owner?(account)
      email_account == account
    end

    def self.visible_events(account)
      select{|event| event.visible_to_partner?(account)}
    end

    def assignment_to
      get_accounts(assign_to)
    end

    def visible_to
      get_accounts(visibility)
    end

    def get_accounts(ids)
      AccountBlock::EmailAccount.where(id: ids)
    end

    def self.filter_by_date(from=nil, to=nil, period=nil)
      if period.present?
        range = period.eql?('monthly') ? Date.today.beginning_of_month..Date.today.end_of_month : Date.today..Date.today.end_of_week
        where(date: range)
      elsif from.present? && to.present?
        range = from.to_s.to_date..to.to_s.to_date
        where(date: range)
      else
        all
      end
    end
  end
end
