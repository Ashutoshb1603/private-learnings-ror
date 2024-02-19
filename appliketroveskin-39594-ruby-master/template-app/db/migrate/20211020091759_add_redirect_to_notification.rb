class AddRedirectToNotification < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :redirect, :string
  end
end
