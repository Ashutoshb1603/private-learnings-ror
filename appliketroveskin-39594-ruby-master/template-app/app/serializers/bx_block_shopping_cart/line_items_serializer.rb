module BxBlockShoppingCart
    class LineItemsSerializer < BuilderBase::BaseSerializer
  
      attributes *[
          :id,
          :variant_id,
          :quantity,
          :product_id,
          :name,
          :price,
          :total_discount,
          :product_image_url
      ]
  
    end
  end
  