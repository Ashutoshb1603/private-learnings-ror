ActiveAdmin.register BxBlockCatalogue::RecommendedProduct, as: 'Recommended Products' do
    menu label: "Recommended Products"
    permit_params :parentable_id, :account_id, :product_id, :title, :price, :parentable_type
    actions :all
    
    index do
      column :account_id
      column :product_id
      column :purchased
      column :title
      column :price
      actions
    end

    show do |product|
        attributes_table do
            row "Account" do
                product&.account
            end
            row "Recommended by" do
                product&.parentable&.name
            end
            row "Product" do
                product&.product_id
            end
            row 'Is_purchased' do
                product&.purchased
            end
            row "Product Name" do
                product&.title
            end
            row "Price" do
                product&.price
            end
            if product.purchases.present?
                div class: 'panel' do
                  h3 'Purchase History'
                  div class: 'attributes_table' do
                    table do
                      tr class: 'table-header' do
                        th 'Date'
                        th 'Quantity'
                      end
                      product.purchases.each do |purchase|
                        tr do
                          td purchase.created_at
                          td purchase.quantity
                        end
                      end
                    end
                  end
                end
              end
        end
    end

    form do |f|
        f.inputs do
            f.input :product_id
            f.input :account
            f.input :title
            f.input :price
            f.input :purchased
        end
        actions
    end
end
  
