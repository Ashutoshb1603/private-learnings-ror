module BxBlockCategories
  class Category < BxBlockCategories::ApplicationRecord
    self.table_name = :categories

    has_and_belongs_to_many :sub_categories,
                            join_table: :categories_sub_categories

    validates :name, uniqueness: true
  end
end
