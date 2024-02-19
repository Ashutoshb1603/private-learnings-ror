# This migration comes from bx_block_account_details (originally 20210119091217)
class AddLivingInToAdditionalInfos < ActiveRecord::Migration[6.0]
  def change
    add_column :additional_infos, :living_in, :string
  end
end
