class ChangeColumnTypeToTextInBadWordsets < ActiveRecord::Migration[6.0]
  def change
    change_column :bad_wordsets, :words, :text
  end
end
