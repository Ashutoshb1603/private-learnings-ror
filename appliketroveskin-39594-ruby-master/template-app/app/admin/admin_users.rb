module AdminUsers
end

ActiveAdmin.register AdminUser do
  permit_params :first_name, :last_name, :email, :password, :password_confirmation, :role_id, :name, :acuity_calendar

  remove_filter :created_at
  filter :email

  controller do 
    before_action :init_acuity
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
    column :id
    column :first_name
    column :last_name
    column :email
    column :created_at
  end

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :role
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role
      f.input :acuity_calendar, as: :select, collection: acuity_calendars.pluck('name', 'id')
    end
    f.actions
  end

end
