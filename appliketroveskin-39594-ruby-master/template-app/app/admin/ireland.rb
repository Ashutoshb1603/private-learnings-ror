include ActiveAdminHelpers
require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper

ActiveAdmin.register_page "Ireland" do
  require "uri"
  require "net/http"
  menu :parent => "Shopify Products"
  # menu label: "Ireland"

  content do
    uri = URI.parse(ENV['REDIS_URL'])
      redis = Redis.new(host: uri.host)
      ireland_key = redis.get("ireland_products")
    if ireland_key
      key = "MmNhYjUzYTA3Y2EwOWQxYjk5OWViMDlk"
      begin
        crypt = ActiveSupport::MessageEncryptor.new(key)
        ireland_products = crypt.decrypt_and_verify(ireland_key)
        products = ireland_products
      rescue ActiveSupport::MessageEncryptor::InvalidMessage => e
        products = []
      end
    else
      products = []
    end
    case params[:status]&.to_i
    when 1
      products = JSON.parse(ireland_shopify("/admin/api/2021-10/products.json?status=draft&limit=250"))['products']
    when 2
      products = JSON.parse(ireland_shopify("/admin/api/2021-10/products.json?status=archived&limit=250"))['products']
    when 0
      products = products
    end
    products = products.select{|prod| prod['vendor'].downcase.include?(params[:vendor].downcase)} if params[:vendor].present?
    products = products.select{|prod| prod['product_type'].downcase.include?(params[:type].downcase)} if params[:type].present?
    if params[:search].present?
      response = JSON.parse(ireland_shopify("/admin/api/2021-10/products.json?limit=250"))
      products = response['products']
      while response['next'] != ""
        next_page = response['next']
        response = JSON.parse(ireland_shopify("/admin/api/2021-10/products.json?page_info=#{next_page}"))
        products += response['products']
      end
      products = products.select{|prod| prod['title'].downcase.include?(params[:search].downcase)} 
      products = products.sort_by{|prod| prod['title'].downcase.index(params[:search].downcase)}
    end
    products.each do |product|
      product['price'] = product['variants'][0]['price'] + " " + "EUR"
    end
    last_update = BxBlockCatalogue::ProductKey.where(location: "Ireland").last.last_refreshed
    div class: 'sidebar' do
      div class: 'sidebar_section panel', id: 'filters_sidebar_section' do
        h3 "Filters"
        div class: 'mb-3 d-flex align-items-end filterBlock' do
          div class: 'status_div' do
            label "Status"
           select id: 'filter_by_status', collection: [["Active", 0], ["Draft", 1], ["Archived", 2]], propmt: 'Select therapist'
          end
          div class: 'vendor_label' do
            label "Vendor"
            input vendor: :text, id: 'vendor', style: "height:36px;"
          end
          div do
            label "Type", class: 'type_label'
            input type: :text, id: 'type'
          end
          div do
            link_to "Filter", admin_ireland_path, class: 'link', id: "filter_products", style: "padding:20% 12px"
          end
          div do
            link_to "Refresh products", "", class: 'link', id: "refresh_button", value: "Ireland", style: "padding:4% 12px;"
          end
          div do
            para "Last updated at: #{time_ago_in_words(last_update)} ago", id: 'last_updated', style: "margin:4% 0px;"
          end
        end
      end
    end

    div class: 'paginated_collection' do
      div class: 'paginated_collection_contents' do
        div class: 'index_content' do
          div class: 'index_as_table appointment_table' do
            table class: "index_table index" do
              tr do
                th "Id", class: 'col'
                th "Title", class: 'col'
                th "Type", class: 'col'
                th "Status", class: 'col'
                th "Vendor", class: 'col'
                th "Price", class: 'col'
                th "Tags", class: 'col'
              end
              if products.present?
                products.each do |product|
                  tr do
                    td product["id"], class: 'col'
                    td product["title"], class: 'col'
                    td product["product_type"], class: 'col'
                    td product["status"], class: 'col'
                    td product["vendor"], class: 'col'
                    td product["price"], class: 'col'
                    td product["tags"], class: 'col'
                  end
                end
              else
                tr do
                  td colspan: '8' do
                    h2 "No Products found", class: 'center-text'
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
