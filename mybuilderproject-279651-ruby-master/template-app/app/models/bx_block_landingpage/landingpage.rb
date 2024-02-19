module BxBlockLandingpage
  class Landingpage < ApplicationRecord
    self.table_name = :landingpages
    validate :create_only_eight, on: :create

    validates :description, presence: true

    private

    def create_only_eight
      errors.add(:base, "There can only be eight landing page") if Landingpage.count > 7
    end
  end
end