module BxBlockAdmin
  class ContactUs < BxBlockAdmin::ApplicationRecord
    self.table_name = :contact_us
    validates :name, :email, presence: true 
  end
end