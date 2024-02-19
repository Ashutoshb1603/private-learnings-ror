# This migration comes from bx_block_account_details (originally 20201117030329)
class CreateAcademicQualifications < ActiveRecord::Migration[6.0]
  def change
    create_table :academic_qualifications do |t|
      t.string :school
      t.string :location
      t.string :academic_board
      t.string :course_name
      t.string :start_year
      t.string :end_year
      t.string :grade
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
