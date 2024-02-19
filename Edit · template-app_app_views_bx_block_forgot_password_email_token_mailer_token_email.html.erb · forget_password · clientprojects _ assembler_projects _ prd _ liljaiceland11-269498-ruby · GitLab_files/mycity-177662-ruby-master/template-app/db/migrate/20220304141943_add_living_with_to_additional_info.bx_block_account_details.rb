# This migration comes from bx_block_account_details (originally 20201121041327)
class AddLivingWithToAdditionalInfo < ActiveRecord::Migration[6.0]
  def change
    add_column :additional_infos, :living_with, :string
  end
end
