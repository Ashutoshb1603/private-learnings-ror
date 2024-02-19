class AddConcernMailIdToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :concern_mail_id, :integer
  end
end
