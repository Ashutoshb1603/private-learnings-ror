module BxBlockCatalogue
  class Aircraft < BxBlockCatalogue::ApplicationRecord
    self.table_name = :aircrafts
    enum data_source: [:leon, :flex]
    has_one :aircraft_equipment, dependent: :destroy
    has_many :aircraft_links, dependent: :destroy
    has_many :aircraft_schedules, dependent: :destroy
    has_many :aircraft_companies, dependent: :destroy
    has_one :aircraft_account_manager, dependent: :destroy
    belongs_to :category, class_name: 'BxBlockCategories::Category', foreign_key: 'category_id', optional: true
    belongs_to :operator, foreign_key: 'operator_id', optional: true
  end
end
