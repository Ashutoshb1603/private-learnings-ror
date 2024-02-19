class AddInfoTextLifeEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :life_events, :info_text, :string, :default => ""
  end
end
