require 'rails_helper'

describe BxBlockRolesPermissions::Permission, :type => :model do
  # let (:subject) { build :bx_block_roles_permissions/permission }
  context "validation" do
  end
  context "associations" do
    it { should have_many :role_permissions }
  end
  context "after_add_for_role_permissions" do
    it "exercises after_add_for_role_permissions somehow" do
      subject.after_add_for_role_permissions 
    end
  end
  context "after_add_for_role_permissions=" do
    it "exercises after_add_for_role_permissions= somehow" do
      subject.after_add_for_role_permissions= 1
    end
  end
  context "after_add_for_role_permissions?" do
    it "exercises after_add_for_role_permissions? somehow" do
      subject.after_add_for_role_permissions? 
    end
  end
  context "after_remove_for_role_permissions" do
    it "exercises after_remove_for_role_permissions somehow" do
      subject.after_remove_for_role_permissions 
    end
  end
  context "after_remove_for_role_permissions=" do
    it "exercises after_remove_for_role_permissions= somehow" do
      subject.after_remove_for_role_permissions= 1
    end
  end
  context "after_remove_for_role_permissions?" do
    it "exercises after_remove_for_role_permissions? somehow" do
      subject.after_remove_for_role_permissions? 
    end
  end
  context "autosave_associated_records_for_role_permissions" do
    it "exercises autosave_associated_records_for_role_permissions somehow" do
      subject.autosave_associated_records_for_role_permissions 
    end
  end
  context "before_add_for_role_permissions" do
    it "exercises before_add_for_role_permissions somehow" do
      subject.before_add_for_role_permissions 
    end
  end
  context "before_add_for_role_permissions=" do
    it "exercises before_add_for_role_permissions= somehow" do
      subject.before_add_for_role_permissions= 1
    end
  end
  context "before_add_for_role_permissions?" do
    it "exercises before_add_for_role_permissions? somehow" do
      subject.before_add_for_role_permissions? 
    end
  end
  context "before_remove_for_role_permissions" do
    it "exercises before_remove_for_role_permissions somehow" do
      subject.before_remove_for_role_permissions 
    end
  end
  context "before_remove_for_role_permissions=" do
    it "exercises before_remove_for_role_permissions= somehow" do
      subject.before_remove_for_role_permissions= 1
    end
  end
  context "before_remove_for_role_permissions?" do
    it "exercises before_remove_for_role_permissions? somehow" do
      subject.before_remove_for_role_permissions? 
    end
  end
  context "validate_associated_records_for_role_permissions" do
    it "exercises validate_associated_records_for_role_permissions somehow" do
      subject.validate_associated_records_for_role_permissions 
    end
  end

end
