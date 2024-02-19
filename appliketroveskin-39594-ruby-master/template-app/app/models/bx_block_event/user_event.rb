class BxBlockEvent::UserEvent < ApplicationRecord
  self.table_name = :user_events

  ## Asspciations
  belongs_to :life_event
  belongs_to :account, class_name: 'AccountBlock::Account'

  ## Validations
  validates :event_date, presence: true
  after_save :set_show_frame, :if => Proc.new {|a| a.show_frame_till.nil?}

  def set_show_frame
    event_date = self.event_date
    updated_at = self.updated_at
    diff = updated_at.year - event_date.year
    if diff < 0
      self.update(show_frame_till: event_date)
    elsif diff == 0 && event_date > updated_at
      self.update(show_frame_till: event_date)
    else
      till = event_date + (diff + 1).year
      self.update(show_frame_till: till)
    end
  end
end
