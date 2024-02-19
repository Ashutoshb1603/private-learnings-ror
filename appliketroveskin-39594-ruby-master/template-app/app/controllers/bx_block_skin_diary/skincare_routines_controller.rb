module BxBlockSkinDiary
  class SkincareRoutinesController < ApplicationController
    before_action :current_user
    before_action :set_skincare_routine, only: [:upload_product, :update, :remove_note]
    # before_action :check_user,  only: [:remove_product, :update]
    before_action :check_valid_therapist, except: [:index]

    def index
      if params[:account_id].present?
        user = AccountBlock::Account.find_by(id: params[:account_id])
        skincare = user.skincare_routine.where(routine_type: params[:routine_type]&.to_i)
      else
        skincare = current_user.skincare_routine.where(routine_type: params[:routine_type]&.to_i)
      end
      steps_products = BxBlockSkinDiary::SkincareProduct.joins(:skincare_step).where(skincare_steps: {skincare_routine: skincare})
      products = steps_products.present? ? @@shopify.favourites(steps_products.pluck(:product_id)) : []
      render json: BxBlockSkinDiary::SkincareRoutineSerializer.new(skincare, params: {current_user: @current_user, products: products}).serializable_hash
    end

    def create
      skincare = @current_user.skincare_routines.find_or_initialize_by(account_id: skin_routine_params[:account_id], routine_type: skin_routine_params[:routine_type]&.to_i)
      skincare.update(skin_routine_params)
      if @current_user&.id !=  skin_routine_params[:account_id]&.to_i #&& (@current_user&.role != BxBlockRolesPermissions::Role.find_by(name: "User"))
        account = AccountBlock::Account.find(skin_routine_params[:account_id])
        payload_data = {account: account, notification_key: 'skincare_routine_created', inapp: true, push_notification: true, redirect: "skincare-routine", key: 'skin_journey'}
        BxBlockPushNotifications::FcmSendNotification.new("#{current_user.name} has added your skincare routine to your journey.", "Skin routine is added", account.device_token, payload_data).call if account.present?
        payload_data = {account: account, notification_key: 'skincare_routine_created', inapp: true, push_notification: true, redirect: "skincare-routine", key: 'skin_journey'}
        BxBlockPushNotifications::FcmSendNotification.new("#{current_user.name} wants to reach out to you - view here!", "Skin routine is added", account.device_token, payload_data).call if account.present?
      end
      # render json: BxBlockSkinDiary::SkincareRoutineSerializer.new(skincare, params: {current_user: @current_user}).serializable_hash
      steps_products = BxBlockSkinDiary::SkincareProduct.joins(:skincare_step).where(skincare_steps: {skincare_routine: skincare.id})
      products = steps_products.present? ? @@shopify.favourites(steps_products.pluck(:product_id)) : []
      if products.present? && @current_user&.role != BxBlockRolesPermissions::Role.find_by(name: "User")
        recommend_product(products, skin_routine_params[:account_id])
      end
      render json: BxBlockSkinDiary::SkincareRoutineSerializer.new(skincare, params: {current_user: @current_user, products: products}).serializable_hash
    end

    # def upload_product
    #   skincare_products = @skincare_routine.update(skin_routine_params)
    #   steps_products = BxBlockSkinDiary::SkincareProduct.joins(:skincare_step).where(skincare_steps: {skincare_routine: @skincare_routine.id})
    #   products = steps_products.present? ? @@shopify.favourites(steps_products.pluck(:product_id)) : []
    #   render json: BxBlockSkinDiary::SkincareRoutineSerializer.new(@skincare_routine, params: {current_user: @current_user, products: products}).serializable_hash,
    #            status: :ok
    # end

    def remove_product
      skincare_product = BxBlockSkinDiary::SkincareProduct.find_by(id: params[:id])
      if skincare_product&.destroy
        render json: {message: "Deleted succesfully!"}
      else
        render json: {errors: {message: skincare_product&.errors&.full_messages}},
               status: :unprocessable_entity
      end
    end

    def get_routines
      skin_routines = BxBlockSkinDiary::SkincareRoutine.routine_types
      render json: skin_routines
    end

    def update
      return if @skincare_routine.nil?
      update_result = @skincare_routine.update(skin_routine_params)
      if update_result
      steps_products = BxBlockSkinDiary::SkincareProduct.joins(:skincare_step).where(skincare_steps: {skincare_routine: @skincare_routine.id})
      products = steps_products.present? ? @@shopify.favourites(steps_products.pluck(:product_id)) : []
      if products.present? && @current_user&.role != BxBlockRolesPermissions::Role.find_by(name: "User")
        recommend_product(products, @skincare_routine.account_id)
      end
        render json: BxBlockSkinDiary::SkincareRoutineSerializer.new(@skincare_routine, params: {current_user: @current_user, products: products}).serializable_hash,
               status: :ok
      else
        render json: {errors: {message: @skincare_routine.errors.full_messages}},
               status: :unprocessable_entity
      end
    end

    def remove_note
      begin
        if @skincare_routine.update(note: nil)
           render json: { message: "updated succesfully" } ,status: :ok
         else
           render json: { message: @skincare_routine.errors } ,status: :unprocessable_entity
         end
      rescue => e
         render json: { message: e.message } ,status: :unprocessable_entity
      end
    end


    private

    def recommend_product(products, account_id)
      prod_name = []
      skin_routine_params[:skincare_steps_attributes]&.each do |step|
        step[:skincare_products_attributes]&.each do |prod|
          prod_name << prod[:name]
        end
      end
      products = products.select {|p| prod_name.include?(p['title'])}
      if account_id.present?
        products.each do |product|
          begin
            prod = @@shopify.product_show(product['id'], "Ireland")
            prod = @@shopify.product_show(product['id'], "UK") if prod['errors'].present?
            title = prod['product']['title']
            recommended_product =@current_user.recommended_products.new(account_id: account_id.to_i, title: title, price: prod['product']['variants'][0]['price'].to_d, product_id: prod['product']['id'])
            recommended_product.save!
          rescue => e
            next
          end
        end
      end
    end

    def skin_routine_params
      params.require(:skincare_routine).permit(:account_id, :note, :routine_type, skincare_steps_attributes: [:id, :step, :header, skincare_products_attributes: [:id, :product_id, :name, :image_url], skincare_step_notes_attributes: [:id, :comment]])
    end

    def product_params
      params.require(:skincare_routine).permit(:id, :name, :product_id, :image_url)
    end

    def set_skincare_routine
      @skincare_routine = BxBlockSkinDiary::SkincareRoutine.find_by(id: params[:id])
      if @skincare_routine.nil?
        render json: {
          errors: {message: "Skincare routine with id #{params[:id]} doesn't exists"}
        }, status: :not_found
      end
    end

    def check_valid_therapist
      render json: {errors: ['Account is not associated to a therapist']} unless ((@current_user.role.name.downcase == "therapist" or @current_user.role.name.downcase == "admin") and @current_user.acuity_calendar.present?)
    end

    # def check_user
    #   current_user != @skincare_routine.therapist && @skincare_routine.therapist.role ==  BxBlockRolesPermissions::Role.find_by(name: "User")
    # end
  end
end
