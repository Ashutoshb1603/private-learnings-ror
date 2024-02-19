ActiveAdmin.register BxBlockCatalogue::Advertisement, as: "Advertisement" do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :url, :image, :dimension, :active, :product_id, :country, :appointment_id
  menu label: "Ad Banners"
  
  controller do 
    before_action :init_shopify, :init_consultation

    def init_shopify
      @shopify = BxBlockShopifyintegration::ShopifyProductsController.new(params)
      @shopify_products = @shopify.products("", "", "", 250)[:products]
    end

    def init_consultation
      @@acuity = BxBlockAppointmentManagement::AcuityController.new
      @appointments = @@acuity.appointment_types
    end
  end

  batch_action :inactive_all do |ids|
    BxBlockCatalogue::Advertisement.where(id: ids).update_all(active: false)
    redirect_to collection_path, notice: 'All selected advertisements was inactivated successfully.'
  end

  batch_action :active_all do |ids|
    BxBlockCatalogue::Advertisement.where(id: ids).update_all(active: true)
    redirect_to collection_path, notice: 'All selected advertisements was activated successfully.'
  end

  # breadcrumb do
  #   links = [link_to('Admin', admin_root_path)]
  #   if %(new create).include?(params['action'])
  #     links << link_to('Advertisements', admin_advertisements_path)
  #   end
  #   links
  # end

  csv do
    column :url
    column :active
    column :dimension
    column(:image){ |advertisement| Rails.application.routes.url_helpers.url_for(advertisement.image) if advertisement.image.attached?}
  end

  remove_filter :created_at, :updated_at, :image_blob, :image_attachment
  filter :url
  filter :active
  filter :dimension, as: :select, collection: BxBlockCatalogue::Advertisement.dimensions.keys
  #
  # or
  #
  # permit_params do
  #   permitted = [:url, :active]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  actions :all

  member_action :update_status, method: [:put, :patch] do
    resource.update(active: resource.active ? false : true)
    redirect_to resource_path, notice: "Advertisement was successfully #{resource.active ? "activated" : "inactivated"}."
  end

  form do |f|
    inputs 'Advertisement' do
      f.semantic_errors
      f.input :title
      f.input :country, as: :select, collection: ["Ireland", "United Kingdom"], :input_html => {class: 'country', value: params[:country]}
      f.input :dimension, as: :radio, collection: BxBlockCatalogue::Advertisement.dimensions.keys
      f.input :image, as: :file, wrapper_html: {class: 'advertisement_image'}
      f.inputs :url, :input_html => {id: 'advertisement_url'}
      f.input :product_id, as: :select, collection: shopify_products.pluck('title', 'id'), include_blank: true, input_html: {id: 'advertisment_product_id'}
      f.input :appointment_id, as: :select, collection: (appointments.pluck('name', 'id') << ["Consultation Homepage", "all"]), include_blank: true, input_html: {id: 'advertisment_appointment_id'}
      f.inputs :active
    end
    actions
  end

  index do |ad|
    selectable_column
    column :title
    column :url
    column :active
    column :clicks do |advertisement|
      advertisement.page_clicks.sum(:click_count)
    end
    column :dimension
    column :country
    column :product_id do |object|
      product = shopify_products.select { |p|  p["id"].to_s == object.product_id }.first
      product["title"] if product.present?
    end
    column :appointment_id do |object|
      appointment = appointments.select { |p|  p["id"].to_s == object.appointment_id }.first
      appointment.present? ? appointment["name"] : object.appointment_id.to_s
    end
    column "Image" do |ad|
      image_tag ad.image, size: 50 if ad.image.attached?
    end
    actions defaults: false do |ad|
      item "View", admin_advertisement_path(ad), class: "member_link"
      item "Edit", edit_admin_advertisement_path(ad), class: "member_link"
      item "Delete", admin_advertisement_path(ad), method: :delete, class: "member_link"
      item ad.active ? "Inactive" : "Active", update_status_admin_advertisement_path(ad), method: :put, class: "member_link"
    end
  end

  show do |ad|
    attributes_table do
      row :dimension
      row "Active/Inactive Advertisement" do
        link_to ad.active ? "Inactive" : "Active", update_status_admin_advertisement_path(ad), method: :put, class: "link"
      end
      row :url
      row :active
      row "Image" do
        ul do
          li do 
            image_tag(ad.image) if ad.image.attached?
          end
        end
      end
      row :country
      row :product_id
      row :appointment_id
      row :created_at
      row :updated_at
    end
  end
end
