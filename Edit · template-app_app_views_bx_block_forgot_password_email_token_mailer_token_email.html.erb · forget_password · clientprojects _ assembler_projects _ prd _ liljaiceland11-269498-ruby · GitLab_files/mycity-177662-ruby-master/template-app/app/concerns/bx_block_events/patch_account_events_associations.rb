module BxBlockEvents
  module PatchAccountEventsAssociations
    extend ActiveSupport::Concern

    included do
      has_many :events, class_name: "BxBlockEvents::Event", dependent: :destroy
    end
  end
end
