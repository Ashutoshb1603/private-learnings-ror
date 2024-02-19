# This migration comes from bx_block_account_details (originally 20210119065915)
class AddFieldsToAcademicQualifications < ActiveRecord::Migration[6.0]
  def change
    add_column :academic_qualifications, :degree, :string
    add_column :academic_qualifications, :specialization, :string
  end
end
