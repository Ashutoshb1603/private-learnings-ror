class AddExtraColumnsForArabic < ActiveRecord::Migration[6.0]
  def change
    add_column :terms_and_conditions, :description_ar, :text
    add_column :interests, :name_ar, :string
    add_column :activities, :name_ar, :string
    add_column :travel_items, :name_ar, :string
    add_column :weathers, :name_ar, :string

  end
end
