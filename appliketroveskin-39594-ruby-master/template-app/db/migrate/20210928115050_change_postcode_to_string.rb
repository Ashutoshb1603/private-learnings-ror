class ChangePostcodeToString < ActiveRecord::Migration[6.0]
  def change
    change_column :addresses, :postcode, :string
  end
end
