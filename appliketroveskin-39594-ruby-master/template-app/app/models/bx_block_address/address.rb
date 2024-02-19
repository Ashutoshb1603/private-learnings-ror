module BxBlockAddress
  class Address < ApplicationRecord
    self.table_name = :addresses

    belongs_to :addressable, polymorphic: true
    reverse_geocoded_by :latitude, :longitude

    enum address_type: { 'Home' => 0, 'Work' => 1, 'Other' => 2 }

    validates :address_type, :street, :county, :country, :postcode, presence: true
    after_validation :reverse_geocode

    before_create :add_address_type

    before_save :change_location

    private
    def add_address_type
      self.address_type = 'Home' unless self.address_type.present?
    end

    def change_location
      self.addressable.update(location: self.country) if self.country.present?
    end
  end
end
