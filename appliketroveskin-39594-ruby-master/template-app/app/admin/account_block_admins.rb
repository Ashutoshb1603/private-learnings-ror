# ActiveAdmin.register AccountBlock::Account, as: "Mobile Admins" do
#   # See permitted parameters documentation:
#   # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#   #
#   # Uncomment all parameters which should be permitted for assignment
#   #
#   actions :all
#   permit_params :name, :activated, :full_phone_number, :email, :password, :role_id, :gender
#   #
#   # or
#   #
#   remove_filter :role, :account_choice_skin_quizzes, :choices, :addresses, :user_event, :account_choice_skin_logs,
#                 :skin_log_choices, :user_images, :orders, :account_choice_skin_goals, :customer_favourite_products,
#                  :discount_code_usages, :cart_items, :wallet, :wallet_transactions, :membership_plans, :device_id, :unique_auth_id,
#                  :password_digest, :created_at, :updated_at, :is_deleted, :life_event, :questions, :comments, :views, :likes, :saved, :activities,
#                  :notifications, :user_consultations, :user_activities, :account_choice_skin_consultations, :profile_pic, :jwt_token, :device_token,
#                  :profile_pic_attachment, :profile_pic_blob
  
#   breadcrumb do
#     links = [link_to('Admin', admin_root_path)]
#     if %(new create).include?(params['action'])
#       links << link_to('Mobile Admins', admin_mobile_admins_path)
#     end
#     links
#   end

#   csv do
#     column :name
#     column :full_phone_number
#     column :gender
#     column :country_code
#     column :phone_number
#     column :email
#     column :activated
#   end

#   index do
#     selectable_column
#     column :name
#     column :full_phone_number
#     column :gender
#     column :country_code
#     column :phone_number
#     column :email
#     column :activated
#     actions
#   end

#   show do
#     attributes_table do
#       row :name
#       row :full_phone_number
#       row :gender
#       row :country_code
#       row :phone_number
#       row :email
#       row :activated
#       row :role
#       row :created_at
#       row :updated_at
#     end
#   end

#   form do |f|
#     f.semantic_errors *f.object.errors.keys
#     f.inputs  do
#       f.input :name
#       f.input :email
#       f.input :activated
#       f.input :gender, as: :select, collection: AccountBlock::Account.genders.keys, prompt: "Select Gender"
#       f.input :full_phone_number
#       f.input :password, required: true
#       f.input :confirm_password, required: true
#     end
#     f.actions do
#       f.actions do
#       f.action :submit, as: :input, label:  ["new", "create"].include?(params[:action]) ? 'Create Mobile Admin' : 'Update Mobile Admin'
#       f.cancel_link({action: "index"})
#     end
#     end
#   end

#   controller do
#     def scoped_collection
#       AccountBlock::Account.unscoped.where(role_id: BxBlockRolesPermissions::Role.find_by(name: "Admin")&.id)
#     end

#     def create
#       @admin = AccountBlock::EmailAccount.new(permitted_params['account'])
#       @admin.role_id = BxBlockRolesPermissions::Role.find_by(name: "Admin")&.id
#       if @admin.save
#         flash[:notice] = "Mobile Admin was successfully created."
#         redirect_to admin_mobile_admins_path
#       else          
#         flash.now[:error] = @admin.errors.full_messages.join(", ")
#         @resource = @admin
#         render :new
#       end
#     end

#     def update
#       @admin = AccountBlock::EmailAccount.find_by(id: params[:id])
#       if @admin.update(permitted_params['account'])
#         flash[:notice] = "Mobile Admin was successfully updated."
#         redirect_to admin_mobile_admins_path
#       else          
#         flash.now[:error] = @admin.errors.full_messages.join(", ")
#         @resource = @admin
#         render :edit
#       end
#     end

#     def destroy
#       @admin = AccountBlock::Account.find_by(id: params[:id])
#       if @admin.destroy
#         flash[:notice] = "Mobile Admin was successfully destroyed."
#         redirect_to admin_mobile_admins_path
#       else
#         flash[:error] = @admin.errors.full_messages.join(", ")
#         redirect_to admin_mobile_admins_path
#       end
#     end
#   end
# end
