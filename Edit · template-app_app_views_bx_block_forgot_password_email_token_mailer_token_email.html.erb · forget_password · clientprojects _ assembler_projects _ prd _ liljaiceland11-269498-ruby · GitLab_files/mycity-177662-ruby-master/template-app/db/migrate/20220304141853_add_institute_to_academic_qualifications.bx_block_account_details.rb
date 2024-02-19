# This migration comes from bx_block_account_details (originally 20210209062330)
class AddInstituteToAcademicQualifications < ActiveRecord::Migration[6.0]
  def change
    add_column :academic_qualifications, :institute, :string
  end
end
