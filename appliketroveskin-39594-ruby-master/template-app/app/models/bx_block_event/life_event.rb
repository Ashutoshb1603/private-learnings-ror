module BxBlockEvent
  class LifeEvent < ApplicationRecord
    self.table_name = :life_events

    ## Validations
    validates :name, presence: true
    validates :name, uniqueness: true

    ## Associations
    has_many :user_events, dependent: :destroy
    has_many :accounts, through: :user_events
    has_many :frame_images, dependent: :destroy

    ## Nested attributes
    accepts_nested_attributes_for :frame_images, reject_if: :all_blank, allow_destroy: true
  end
end