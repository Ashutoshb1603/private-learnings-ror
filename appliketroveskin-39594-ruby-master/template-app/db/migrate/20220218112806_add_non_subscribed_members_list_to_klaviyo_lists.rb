class AddNonSubscribedMembersListToKlaviyoLists < ActiveRecord::Migration[6.0]
  def change
    add_column :klaviyo_lists, :non_subscribed_members_list, :integer, default: 1
  end
end
