module BxBlockCatalogue
  class Crew < BxBlockCatalogue::ApplicationRecord
    self.table_name = :crews
    has_many :crew_contacts, dependent: :destroy
    has_many :crew_accounts, dependent: :destroy
    has_many :crew_roles, dependent: :destroy
    has_many :crew_aircrafts, dependent: :destroy
    has_many :crew_preferences, dependent: :destroy
  end
end
