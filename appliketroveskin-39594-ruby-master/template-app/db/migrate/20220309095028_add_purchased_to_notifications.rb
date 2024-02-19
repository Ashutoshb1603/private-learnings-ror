class AddPurchasedToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :purchased, :boolean, default: false
  end
end
