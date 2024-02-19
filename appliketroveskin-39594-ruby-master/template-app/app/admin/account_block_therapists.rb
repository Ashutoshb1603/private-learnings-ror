ActiveAdmin.register AccountBlock::Account, as: "Therapists" do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  actions :all
  permit_params :full_phone_number, :country_code, :phone_number, :email, :activated, :type, :role_id, :first_name, :last_name, :gender, :acuity_calendar
  menu :parent => "Staff Roles & Permissions", :priority => 3
  #
  # or
  #
  remove_filter :role, :account_choice_skin_quizzes, :choices, :addresses, :user_event, :account_choice_skin_logs,
                :skin_log_choices, :user_images, :orders, :account_choice_skin_goal, :customer_favourite_products,
                 :discount_code_usages, :cart_items, :wallet, :wallet_transactions, :membership_plans, :device_id, :unique_auth_id,
                 :password_digest, :created_at, :updated_at, :is_deleted, :life_event, :comments, :activities, :likes, :views, :saved,
                 :user_activities, :notifications, :user_consultations, :account_choice_skin_consultations, :profile_pic_attachment, :profile_pic_blob,
                 :jwt_token, :device_token
  
  # breadcrumb do
  #   links = [link_to('Admin', admin_root_path)]
  #   if %(new create).include?(params['action'])
  #     links << link_to('Therapists', admin_therapists_path)
  #   end
  #   links
  # end

  controller do 
    before_action :init_acuity, only: [:new, :edit]

    def init_acuity
      @acuity_controller = BxBlockAppointmentManagement::AcuityController.new
      already_selected = AccountBlock::Account.where.not(acuity_calendar: nil).pluck(:acuity_calendar) || []
      already_selected += AdminUser.where.not(acuity_calendar: nil).pluck(:acuity_calendar)
      @acuity_calendars = @acuity_controller.therapists
      @acuity_calendars.reject! { |therapist| (already_selected.include? therapist["id"].to_s and resource&.acuity_calendar != therapist["id"].to_s) } if action_name == 'edit'
      @acuity_calendars.reject! { |therapist| already_selected.include? therapist["id"].to_s } if action_name == 'new'
      @acuity_calendars
    end
  end

  csv do
    column :name
    column :full_phone_number
    column :gender
    column :country_code
    column :phone_number
    column :email
    column :activated
  end

  index do
    selectable_column
    column :name
    column :full_phone_number
    column :gender
    column :country_code
    column :phone_number
    column :email
    column :activated
    actions
  end

  show do
    attributes_table do
      row :name
      row :full_phone_number
      row :gender
      row :country_code
      row :phone_number
      row :email
      row :activated
      row :role
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs  do
      f.input :first_name
      f.input :last_name
      f.input :gender, as: :select, collection: AccountBlock::Account.genders.keys, prompt: "Select Gender"
      f.input :full_phone_number
      f.input :email
      f.input :acuity_calendar, as: :select, collection: acuity_calendars.pluck('name', 'id'), required: true
    end
    f.actions do
      f.action :submit, as: :input, label:  ["new", "create"].include?(params[:action]) ? 'Create Therapist' : 'Update Therapist'
      f.cancel_link({action: "index"})
    end
  end

  controller do
    def scoped_collection
      AccountBlock::Account.unscoped.where(role_id: BxBlockRolesPermissions::Role.find_by('lower(name)=?', "therapist")&.id)
    end

    def create
      @therapist = AccountBlock::EmailAccount.new(permitted_params["account"])
      @therapist.role_id = BxBlockRolesPermissions::Role.find_by('lower(name)=?', "therapist")&.id
      @therapist.password = SecureRandom.hex(4)
      @therapist.activated = true
      if @therapist.save
        @therapist.send_password_mail(request.base_url, @therapist.password)
        flash[:notice] = "Therapist was successfully created."
        redirect_to admin_therapists_path
      else
        flash.now[:error] = @therapist.errors.full_messages.join(", ")
        @resource = @therapist
        render :new
      end
    end

    def destroy
      @therapist = AccountBlock::Account.find_by(id: params[:id])
      if @therapist.destroy
        flash[:notice] = "Therapist was successfully destroyed."
        redirect_to admin_therapists_path
      else
        flash[:error] = @therapist.errors.full_messages.join(", ")
        redirect_to admin_therapists_path
      end
    end
  end
end
