module BxBlockSkinDiary
  class SkincareRoutineSerializer < BuilderBase::BaseSerializer
    attributes :id, :routine_type, :note, :created_at, :updated_at
    
    attribute :account_name do |object|
       object.account.name
    end

    attribute :skincare_steps do |object, params|
      current_user = params[:current_user]
      shopify_products = params[:products]
      BxBlockSkinDiary::SkincareStepsSerializer.new(object.skincare_steps, params: {current_user: current_user, products: shopify_products}).serializable_hash
    end
    # attribute :skincare_steps do |object, params|
    #    # object.skincare_steps
    #   current_user = params[:current_user]
    #   shopify_products = params[:products]

    #     skincare_steps = []
    #     object.skincare_steps.each do |x|
    #     skincare_steps <<  {
    #       id: x.id,
    #       step: x.step,
    #       skincare_routine_id: x.skincare_routine_id,
    #       created_at: x.created_at,
    #       updated_at: x.updated_at,
    #       header: x.header,
    #       header: x.skincare_step_notes,
    #       skincare_products: BxBlockSkinDiary::SkincareStep.skincare_products(x, current_user, shopify_products)
    #     }
    #   end
    #   rtrn = skincare_steps.group_by{|k| k[:header]}
    # end
  end
end
