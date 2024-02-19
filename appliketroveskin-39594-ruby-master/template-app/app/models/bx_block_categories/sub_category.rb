module BxBlockCategories
  class SubCategory < BxBlockCategories::ApplicationRecord
    self.table_name = :sub_categories

    has_and_belongs_to_many :categories, join_table: :categories_sub_categories

    validates :name, uniqueness: true
  end
end
