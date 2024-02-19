require 'rails_helper'

describe BxBlockEvent::UserEvent, :type => :model do
  # let (:subject) { build :bx_block_event/user_event }
  # context "validation" do
  #   it { should validate_presence_of :life_event }
  #   it { should validate_presence_of :account }
  #   it { should validate_presence_of :event_date }
  # end
  context "associations" do
    it { should belong_to :life_event }
    it { should belong_to :account }
  end
  context "autosave_associated_records_for_account" do
    it "exercises autosave_associated_records_for_account somehow" do
      subject.autosave_associated_records_for_account 
    end
  end
  context "autosave_associated_records_for_life_event" do
    it "exercises autosave_associated_records_for_life_event somehow" do
      subject.autosave_associated_records_for_life_event 
    end
  end
  # context "set_show_frame" do
  #   it "exercises set_show_frame somehow" do
  #     subject.set_show_frame 
  #   end
  # end

end
