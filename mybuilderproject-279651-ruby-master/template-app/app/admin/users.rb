# frozen_string_literal: true

ActiveAdmin.register AccountBlock::Account, as: 'Users' do
  actions :index, :show, :destroy
  permit_params :user_type, :first_name, :last_name, :operator_address, :full_phone_number, :country_code, :phone_number, :email, :activated
  
  scope :all

  scope :operator, :default => true do |users|
    users.where(:user_type => 'operator')
  end

  scope :charterer, :default => true do |users|
    users.where(:user_type => 'charterer')
  end

  filter :user_type
  filter :first_name
  filter :last_name
  filter :operator_address, scope: 'charterer'
  filter :email
  filter :full_phone_number
  filter :activated
  filter :created_at



  member_action :active_account, :method => :get do
    account = AccountBlock::Account.find(params[:id]) rescue nil
    if account.present?
      if account.activated
        account.activated = false
        flash[:notice] = "Account has been Inactive Successfully"
      else
        account.activated = true
        flash[:notice] = "Account has been Active Successfully"
      end
      account.save
    end
    redirect_to "/admin/users"
  end

  show do
    attributes_table do
      row :user_type
      row :first_name
      row :last_name
      row :operator_address unless params['scope']=='charterer'
      row :email
      row :full_phone_number
      row 'created at' do |account|
        account.created_at.to_time.in_time_zone('Asia/Kolkata').strftime('%b %d, %Y, %I:%M %p (%Z)')
      end
    end
  end

  index do
      div class: "panel" do 
        activated_count = AccountBlock::Account.where(activated: true)&.count
        span "Total active user :   #{activated_count}" 
      end
       div class: "panel" do 
        inctivated_count = AccountBlock::Account.where(activated: false)&.count
        span "Total deactived user :  #{inctivated_count}" 
      end
    selectable_column

  #   index do
  #   column :title
  #   column :published_year
  #   column :author unless params['scope'] == 'smith'
  # end

    column "User id", :id
    column :user_type
    column :first_name
    column :last_name
    column :operator_address unless params['scope']=='charterer'
    column :email
    column :full_phone_number
    column "Account Status" do |account|
      if account.activated
        "<div class='green_icon'></div>".html_safe  
      else
        "<div class='red_icon'></div>".html_safe  
      end
    end
    column :status
    column 'created at' do |account|
      account.created_at.to_time.in_time_zone('Asia/Kolkata').strftime('%b %d, %Y, %I:%M %p (%Z)')
    end
    actions do |account|
      if account.activated
        item "block Account", active_account_admin_user_path(account),
          class: "member_link"
      else
        item "unblock Account", active_account_admin_user_path(account),
          class: "member_link"
      end
    end
  end
  
end
