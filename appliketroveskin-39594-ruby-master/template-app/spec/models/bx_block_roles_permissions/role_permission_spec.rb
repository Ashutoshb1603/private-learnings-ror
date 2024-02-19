require 'rails_helper'

describe BxBlockRolesPermissions::RolePermission, :type => :model do
  # let (:subject) { build :bx_block_roles_permissions/role_permission }
  # context "validation" do
  #   it { should validate_presence_of :role }
  #   it { should validate_presence_of :permission }
  # end
  context "associations" do
    it { should belong_to :role }
    it { should belong_to :permission }
  end
  context "autosave_associated_records_for_permission" do
    it "exercises autosave_associated_records_for_permission somehow" do
      subject.autosave_associated_records_for_permission 
    end
  end
  context "autosave_associated_records_for_role" do
    it "exercises autosave_associated_records_for_role somehow" do
      subject.autosave_associated_records_for_role 
    end
  end

end
