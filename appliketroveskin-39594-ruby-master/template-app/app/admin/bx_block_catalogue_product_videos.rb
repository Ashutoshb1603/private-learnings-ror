ActiveAdmin.register BxBlockCatalogue::ProductVideo, as: "Product Video" do

    # See permitted parameters documentation:
    # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
    #
    # Uncomment all parameters which should be permitted for assignment
    #
    permit_params :video_url, :product_id
    menu label: "Shopify Product Page Video"
  
    controller do 
      before_action :init_shopify
  
      def init_shopify
        @shopify = BxBlockShopifyintegration::ShopifyProductsController.new({country: params['country']})
        product_ids_with_video = BxBlockCatalogue::ProductVideo.all.pluck(:product_id)
        if params[:action] == "edit"
          shopify_product_id = BxBlockCatalogue::ProductVideo.find(params[:id]).product_id
          product_ids_with_video = product_ids_with_video - [shopify_product_id]
        end
        @count = @shopify.product_count()
        puts @count
        @shopify_products = Array.new
        @product_loop_count = (@count['count']/250) + 1
        @next_page = ""
        for loop_count in 1..@product_loop_count do
          products = @shopify.products(params[:collection_id], "", @next_page, 250)
          if products[:next_page_info].present?
            loop_count += 1 
            @next_page = products[:next_page_info]
          end
          @shopify_products.concat(products[:products])
        end
        puts @shopify_products.count
        puts "****"
        @shopify_products_without_videos = @shopify_products.select {|product| !product_ids_with_video.include?product["id"].to_s}
        puts @shopify_products_without_videos.count
      end
    end

    actions :all

    filter :product_name, as: :select, label: 'Product', collection: BxBlockCatalogue::ProductVideo.products
    filter :video_url
  
    form do |f|
      inputs 'Product Video' do
        f.input :product_id, as: :select, collection: shopify_products_without_videos.pluck('title', 'id')
        f.inputs :video_url
      end
      actions
    end
  
    index do
      selectable_column
      column :product_id, "Product" do |object|
        product = shopify_products.select { |p|  p["id"].to_s == object.product_id }.first
        product["title"] if product.present?
      end
      column :video do |object|
        render "video_tutorial", locals: {url: object.video_url}
      end
      actions
    end
  
end
  