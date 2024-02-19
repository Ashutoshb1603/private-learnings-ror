module BxBlockSkinDiary
  class SkincareStepsController < ApplicationController
    before_action :current_user
    before_action :set_skincare_step, only: [:update]

    def create
      @skincare_step = BxBlockSkinDiary::SkincareStep.new(skin_step_params)
      if @skincare_step.save
      steps_products = @skincare_step.skincare_products

      products = steps_products.present? ? @@shopify.favourites(steps_products.pluck(:product_id)) : []
      if products.present? && @current_user&.role != BxBlockRolesPermissions::Role.find_by(name: "User")
        recommend_product(products, @skincare_step)
      end
        render json: BxBlockSkinDiary::SkincareStepsSerializer.new(@skincare_step, params: {current_user: @current_user, products: products}).serializable_hash,
               status: :ok
      else
        render json: {errors: {message: @skincare_step.errors.full_messages}},
               status: :unprocessable_entity
      end
    end

    def update
      return if @skincare_step.nil?
      if @skincare_step.update(skin_step_params)
      steps_products = @skincare_step.skincare_products
      products = steps_products.present? ? @@shopify.favourites(steps_products.pluck(:product_id)) : []
      if products.present? && @current_user&.role != BxBlockRolesPermissions::Role.find_by(name: "User")
        recommend_product(products, @skincare_step)
      end
        render json: BxBlockSkinDiary::SkincareStepsSerializer.new(@skincare_step, params: {current_user: @current_user, products: products}).serializable_hash,
               status: :ok
      else
        render json: {errors: {message: @skincare_step.errors.full_messages}},
               status: :unprocessable_entity
      end
    end

    def recommend_product(products, skincare_step)
      account_id =  skincare_step&.skincare_routine&.account_id
      prod_name = []
      skin_step_params[:skincare_products_attributes]&.each do |prod|
        prod_name << prod[:name]
      end
      products = products.select {|p| prod_name.include?(p['title'])}
      if account_id.present?
        products.each do |product|
          begin
            prod = @@shopify.product_show(product['id'], "Ireland")
            prod = @@shopify.product_show(product['id'], "UK") if prod['errors'].present?
            title = prod['product']['title']
            recommended_product = @current_user.recommended_products.create(account_id: account_id.to_i, title: title, price: prod['product']['variants'][0]['price'].to_d, product_id: prod['product']['id'])
            recommended_product.save!
          rescue => e
            next
          end
        end
      end
    end

    def delete_comment
      if note = BxBlockSkinDiary::SkincareStepNote.find(params[:id])
        if note.destroy
          render json: { message: "Deleted succesfully" } ,status: :ok
        else
          render json: { errors: note.errors }, status: :unprocessable_entity
        end
      else
        render json: { errors: "Skincare step note with id #{params[:id]} doesn't exists" }, status: :unprocessable_entity
      end
    end

    private

    def skin_step_params
      params.require(:skincare_step).permit(:skincare_routine_id, :step, :header, skincare_products_attributes: [:id, :product_id, :name, :image_url], skincare_step_notes_attributes: [:id, :comment] )
    end

    def set_skincare_step
      @skincare_step = BxBlockSkinDiary::SkincareStep.find_by(id: params[:id])
      if @skincare_step.nil?
        render json: {
          errors: {message: "Skincare step with id #{params[:id]} doesn't exists"}
        }, status: :not_found
      end
    end

  end
end
