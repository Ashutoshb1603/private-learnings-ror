ActiveAdmin.register AccountBlock::Account, as: "Accounts" do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  actions :all, :except => [:new]
  config.per_page = 10

  permit_params :first_name, :last_name, :full_phone_number, :country_code, :phone_number, :email, :activated, :device_id, :unique_auth_id, :password_digest, :type, :role_id, :user_name, :platform, :user_type, :app_language_id, :last_visit_at, :is_blacklisted, :suspend_until, :status, :stripe_id, :stripe_subscription_id, :stripe_subscription_date, :full_name, :gender, :date_of_birth, :age, :is_paid, :language, :service_and_policy, :term_and_condition, :age_confirmation,:currency, :interests, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:first_name, :last_name, :full_phone_number, :country_code, :phone_number, :email, :activated, :device_id, :unique_auth_id, :password_digest, :type, :role_id, :user_name, :platform, :user_type, :app_language_id, :last_visit_at, :is_blacklisted, :suspend_until, :status, :stripe_id, :stripe_subscription_id, :stripe_subscription_date, :full_name, :gender, :date_of_birth, :age, :is_paid, :language, :service_and_policy, :term_and_condition, :age_confirmation, :interests]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  scope :all, default: true
  scope :active
  scope("Inactive") { |scope| scope.where(activated: false) }

  collection_action :block_user, method: :put do
    resource.update(is_blacklisted: true)
    redirect_to admin_accounts_path, notice: 'Blocked User'
  end

  collection_action :unblock_user, method: :put do
    resource.update(is_blacklisted: false)
    redirect_to admin_accounts_path, notice: 'UnBlocked User'
  end

  collection_action :warning_user, method: :get do
    AccountBlock::WarningMailer.with(account: resource).warning_email.deliver_later
    redirect_to admin_accounts_path, notice: 'Warning notification sent successfully'
  end
  
  index download_links: [:csv] do
    selectable_column
    id_column
    column :full_name
    column :user_name
    column :email
    column :interests
    column :phone_number
    column :user_type
    column :activated
    column :service_and_policy
    column :term_and_condition
    column :age_confirmation

    actions defaults: true do |account|
      if account.is_blacklisted?
        link_to 'UnBlock', unblock_user_admin_accounts_path(id: account.id), method: :put
      else
        link_to 'Block', block_user_admin_accounts_path(id: account.id), method: :put
      end
      
      link_to 'Warning', warning_user_admin_accounts_path(id: account.id), method: :get
    end

  end
  form do |f|
    f.inputs do
      f.semantic_errors *f.object.errors.keys
      f.input :full_name
      f.input :user_name
      f.input :email
      f.input :interests, as: :select, collection: BxBlockInterests::Interest.all, multiple: true
      f.input :phone_number
      f.input :user_type
      f.input :activated
      f.input :service_and_policy
      f.input :term_and_condition
      f.input :age_confirmation
      f.input :currency
      f.input :status
      f.input :image, as: :file
    end

    f.actions
  end

  show do
    attributes_table do
      row :full_name
      row :user_name
      row :email
      row :interests
      row :phone_number
      row :user_type
      row :activated
      row :service_and_policy
      row :term_and_condition
      row :age_confirmation
      row :currency
      row :created_at
      row :image do |ad|
        link_to(ad.image.filename , url_for(ad.image), target: :_blank) if ad.image.present?
      end

    end
  end

  controller do
    def update
      account = AccountBlock::Account.find_by(id: params[:id])
      account.update(get_docs)
      if params[:account][:interest_ids].present?
        params[:account][:interest_ids].each do |interest_id|
         accounts_interests =  AccountBlock::AccountsInterest.find_or_create_by(account_id: params[:id], interest_id: interest_id)
        end
      end
      redirect_to admin_account_path
    end
    private
    def get_docs
      params[:account].permit(:full_name,:user_name,:phone_number,:email,:term_and_condition, :age_confirmation, :service_and_policy, :language, :activated, :currency, :image)
    end
  end

  filter :full_name
  filter :user_name
  filter :phone_number
  filter :country
  filter :email
  filter :activated 
  filter :interests,as: :select, collection: BxBlockInterests::Interest.all, multiple: true
  
end
