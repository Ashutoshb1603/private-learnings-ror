ActiveAdmin.register BxBlockSocialClubs::SocialClub, as: "SocialClubs" do
  actions :all, :except => [:new]
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :account_id, :interests, :description, :community_rules,
                :location, :is_visible, :chat_channels, :user_capacity,
                :bank_name, :bank_account_name, :bank_account_number,
                :routing_code, :max_channel_count, :fee_currency,
                :fee_amount_cents, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:account_id, :interests, :description, :community_rules, :location, :is_visible, :chat_channels, :user_capacity, :bank_name, :bank_account_name, :bank_account_number, :routing_code, :max_channel_count, :fee_currency, :fee_amount_cents]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index download_links: [:csv] do
    selectable_column
    id_column
    column :name
    column :interests
    column :is_visible
    column :age_should_be
    column :start_date_and_time
    column :end_date_and_time
    column :status    
    column :location
    
    actions
  end

  filter :name
  filter :interests
  filter :is_visible
  filter :status
  filter :fee_currency
  filter :account_id

  form do |f|
    f.inputs do
      f.semantic_errors *f.object.errors.keys
      f.input :account
      f.input :status, :collection => [['Draft', :draft], ['Approved', :approved], ['Archieved', :archived], ['Deleted', :deleted]]
      end

    f.actions
  end
  # show do
  #   attributes_table do
  #     row :name
  #     row :icon do |ad|
  #       link_to(ad.icon.filename , url_for(ad.icon), target: :_blank) if ad.icon.present?
  #     end      
  #   end
  # end
  
end
